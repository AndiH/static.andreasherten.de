---
layout: post
title: Auswertung zum &#35;bteAC
---
<style type="text/css">
	div.save {
		text-align: right;
		position: relative;
		top: -40px;
	}
</style>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">
	google.load("visualization", "1", {packages:["corechart"]});
	google.setOnLoadCallback(drawCharts);
	function returnOptions(mytitle) {
		return {
			// title: mytitle,
			fontName: 'Open Sans, Arial',
			colors: ["#6fa8dc","#e06666","#f6b26b","#93c47d","#8e7cc3","#0099C6","#DD4477","#66AA00","#B82E2E","#316395","#994499","#22AA99","#AAAA11","#6633CC","#E67300","#8B0707","#651067","#329262","#5574A6","#3B3EAC","#B77322","#16D620","#B91383","#F4359E","#9C5935","#A9C413","#2A778D","#668D1C","#BEA413","#0C5922","#743411"],
			theme: "maximized",
			legend: "right",
			chartArea: {
				top: 10,
				height:'90%'
			}
		}
	} 
	function drawCharts() {
		var data_burgerart = google.visualization.arrayToDataTable([
			['Art', 'Anzahl Esser'],
			['Hamburger Classic',  2],
			['Burger Mozzi',       2],
			['Chickenburger',      1],
			['Calamaris Burger',   2],
			['Burger Forckenbeck', 4]
			]);
		var data_burgergesamt = google.visualization.arrayToDataTable([
			['Note', 'Anzahl'],
			['1', 0],
			['2', 0],
			['3', 0],
			['4', 1],
			['5', 0],
			['6', 1],
			['7', 4],
			['8', 2],
			['9', 3],
			['10', 0]
			]);
		var data_gesamt = google.visualization.arrayToDataTable([
			['Note', 'Anzahl'],
			['1', 0],
			['2', 0],
			['3', 1],
			['4', 0],
			['5', 1],
			['6', 1],
			['7', 1],
			['8', 4],
			['9', 1],
			['10', 2]
			]);

		// var options = {
		// 	title: 'Art des Burgers',
		// 	fontName: 'Open Sans, Arial',
		// 	colors: ["#6fa8dc","#e06666","#f6b26b","#93c47d","#8e7cc3","#0099C6","#DD4477","#66AA00","#B82E2E","#316395","#994499","#22AA99","#AAAA11","#6633CC","#E67300","#8B0707","#651067","#329262","#5574A6","#3B3EAC","#B77322","#16D620","#B91383","#F4359E","#9C5935","#A9C413","#2A778D","#668D1C","#BEA413","#0C5922","#743411"],
		// 	theme: "maximized",
		// 	legend: "right"
		// };

		var chart_burgerart = new google.visualization.PieChart(document.getElementById('pie_burgerart'));
		chart_burgerart.draw(data_burgerart, returnOptions('Art des Burgers'));
		document.getElementById('link_pie_burgerart').innerHTML = '<a href="' + chart_burgerart.getImageURI() + '"><i class="fa fa-floppy-o"></i></a>';

		var chart_burgergesamt = new google.visualization.ColumnChart(document.getElementById('column_burgegesamt'));
		chart_burgergesamt.draw(data_burgergesamt, returnOptions('Burgergesamtbewertung'));
		document.getElementById('link_column_burgegesamt').innerHTML = '<a href="' + chart_burgergesamt.getImageURI() + '"><i class="fa fa-floppy-o"></i></a>';

		var chart_gesamt = new google.visualization.ColumnChart(document.getElementById('column_gesamt'));
		var gesamt_options = returnOptions('Gesamtbewertung');
		gesamt_options.colors[0] = gesamt_options.colors[1];
		chart_gesamt.draw(data_gesamt, gesamt_options);
		document.getElementById('link_column_gesamt').innerHTML = '<a href="' + chart_gesamt.getImageURI() + '"><i class="fa fa-floppy-o"></i></a>';
	}
</script>
Am 27. Mai 2014 fand ein Burger-Testessen in Aachen, kurz #bteAC, statt. Ort war das Forckenbeck-Restaurant in der Nähe des Uniklinikum.

Über [ein Google-Docs-Formular](https://docs.google.com/forms/d/1gBdRxQ5yCqOfCvUo7BI6xnAYI0N3aQ5uPlt0qQE47HI/viewform) bat ich die Teilnehmenden um ihre Meinung zum konsumierten Burger. Dies ist die Auswertung der 11 Bewertungen.

## Art des Burgers
Das Forckenbeck hatte extra für das #bteAC seine Burgerspeisekarte erweitert. Die Aufteilung der gegessenen Burger ist wiefolgt. Der Burger Forckenbeck war mit vier Testessern der meistgegessene.

<div id="pie_burgerart" style="width: 800px; height: 300px;"></div><div id="link_pie_burgerart" class="save"></div>

## Burgergesamtbewertung
Die Burger sind relativ gut angekommen. Die durchschnittliche Bewertung ist **7,36*.

<div id="column_burgegesamt" style="width: 800px; height: 300px;"></div><div id="link_column_burgegesamt" class="save"></div>

## Alles in Allem
Das Bild der Gesamtbewertung dieses #bteACs gleicht dem der Bewertung der Burger. Durchschnitt ist **7,45**. Die Standardabweichung ist hier allerdings höher als 2 Noten (Burgerbewertung: 1,5) – die Streuung um den Mittelwert ist größer; die Meinungen unterschiedlicher.

<div id="column_gesamt" style="width: 800px; height: 300px;"></div><div id="link_column_gesamt" class="save"></div>

## Restliche Bewertungen
Das war noch lange nicht alles an Kategorien, die ausgefüllt wurden.  
Eine komplette Übersicht findet ihr in der **[automatisches Auswertung des Google-Dokuments](https://docs.google.com/forms/d/1gBdRxQ5yCqOfCvUo7BI6xnAYI0N3aQ5uPlt0qQE47HI/viewanalytics)**.