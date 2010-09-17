require "yaml"

class ColorDistrictChart

	def initialize(country)
		@folder = File.dirname(__FILE__) + File::SEPARATOR + "country"  + File::SEPARATOR
		@country = country
		@districts = YAML::load_file("#{@folder}#{country}.yaml")[country.to_s]
		@source_image = "#{@folder}#{country}.png"
		@commands = []
	end

	def reset!
		@commands = []
	end

	def color name, color
		color = "rgb(#{color * ","})" if color.is_a? Array

		coordinates = get_coordinates_for name
		@commands << "-fill '#{color}'" unless coordinates.empty?
		coordinates.each do |coordinate|
			@commands << "-draw 'color #{coordinate} floodfill'"
		end
	end

	def list level_name_or_number, *filter
		level = get_level level_name_or_number
		collect_names(level, @districts["districts"], filter)
	end

	def output_file file_name
		command = "convert #{@source_image} #{@commands * " "} #{file_name}"
		puts command
		`#{command}`
	end

	private

	def get_level level_name_or_number
		case level_name_or_number
			when Numeric : level_name_or_number
			when String, Symbol : begin
				begin
					levels = @districts["levels"]
					value = levels.index level_name_or_number.to_s
					raise "level: #{level_name_or_number} not found" if value.nil?
					value
				rescue
					raise "level: #{level_name_or_number} not found"
				end
			end
		end
	end

	def collect_names(level, root, filter)
		return root.keys if level == 0
		active_filter = (filter || []).shift
		root.collect do |key, values|
			collect_names(level - 1, values, filter) if active_filter and active_filter == key
		end.flatten.compact
	end

	def get_coordinates_for name, set = nil, correct = false
		set ||= @districts["districts"]
		set.collect do |key, value|
			if key == name or correct
				case value
					when String : (value == "") ? nil : value
					when Array: value
					when Hash : get_coordinates_for(name, value, true)
				end
			else
				get_coordinates_for(name, value) unless value.nil?
			end
		end.flatten.compact
	end

end