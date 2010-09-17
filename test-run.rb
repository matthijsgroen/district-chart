#!/bin/ruby
require "lib/color_district_chart"

chart = ColorDistrictChart.new :netherlands
puts chart.list(:province).sort.inspect
puts chart.list(:municipality, "Noord Brabant").sort.inspect

chart.color "Valkenburg aan de Geul", [40, 40, 100]
chart.color "Meerssen", [100, 40, 40]
chart.color "Noord Brabant", "#40EE40"
chart.output_file "test1.png"

