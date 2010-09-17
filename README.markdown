District Chart
==============
Simple tool that calls Image Magic to color municipalities on a map.

Usage
=====

	chart = ColorDistrictChart.new :netherlands
	puts chart.list(:province).sort.inspect
	puts chart.list(:municipality, "Noord Brabant").sort.inspect

	chart.color "Valkenburg aan de Geul", [40, 40, 100]
	chart.color "Meerssen", [100, 40, 40]
	chart.color "Noord Brabant", "#40EE40"
	chart.output_file "test1.png"
	
Todo
====
Make the Netherlands complete:

	- Drenthe
	- Flevoland
	- Friesland
	- Gelderland
	- Groningen
	- Limburg
	- *Noord Brabant*
	- Noord Holland
	- Overijssel
	- Utrecht
	- Zeeland
	- Zuid Holland


