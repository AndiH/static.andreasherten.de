---
layout: post
date: 06.9.2014 14:30
title: Campsite Pictures
---
*The following post is written in German as it solely addresses a German-speaking audience*

2014 ging unser Pfadfinder-Sommerlager in die Nähe von Lübeck. Und zum ersten Mal hatten wir fünf aktive Fotografen dabei. Super!

Nachdem die Fotos sortiert waren und in erster Instanz getagged waren ('von Andreas' zum identifizieren des Fotografens, sowie von Picasa automatisch erkannte Gesichter gespeichert im entsprechenden EXIF-Tag) habe ich ein bisschen mit Python rum gespielt um ein paar Graphen zu erstellen.

Die folgen sogleich, eine kurze Erklärung der Hintergründe kommt weiter unten.

## Graphen

### Zeitliche Verteilung der Bilder über das Lager hinweg
Die Gesamtzahl der Fotos im Sommerlager 2014, sortiert nach Tagen.
<img src="/img/sola2014/2014-anzahl_fotos_pro_tag.svg" onerror="this.onerror=null; this.src='/img/sola2014/2014-anzahl_fotos_pro_tag.svg'" style="width: 100%">

Da wir mehrere Fotografen vor Ort hatten, kann das natürlich noch nach Fotograf sortiert werden.
<img src="/img/sola2014/2014-anzahl_fotos_pro_tag_pro_fotograf.svg" onerror="this.onerror=null; this.src='/img/sola2014/2014-anzahl_fotos_pro_tag_pro_fotograf.svg'" style="width: 100%">

### Zeitliche Verteilung an einem Tag
Um welche Uhrzeit werden die meisten Fotos geschossen? Zwischen 15 und 16 Uhr sowie zwischen 20 und 21 Uhr.
<img src="/img/sola2014/2014-anzahl_fotos_pro_uhrzeit.svg" onerror="this.onerror=null; this.src='/img/sola2014/2014-anzahl_fotos_pro_uhrzeit.svg'" style="width: 100%">

Auch das geht natürlich geordnet nach allen Fotografen. Meine Fotos sind die, die hauptäschlich in der Mittagszeit entstehen. Susanne macht das entweder abends oder morgens. Peter ist der einzige, der nach Zwölf noch knipst.
<img src="/img/sola2014/2014-anzahl_fotos_pro_uhrzeit_pro_fotograf.svg" onerror="this.onerror=null; this.src='/img/sola2014/2014-anzahl_fotos_pro_uhrzeit_pro_fotograf.svg'" style="width: 100%">

### Getaggte Personen
Ich habe ein paar Gesichter der Fotos getaggt. Bei weitem nicht alle, sondern nur die, die Picasa.app gruppiert und mit Namen vorgeschlagen hat.
Unter derartig getaggten Bildern ist die Häufigkeitsverteilung wiefolgt:
<img src="/img/sola2014/2014-anzahl_personen_gefunden.png" onerror="this.onerror=null; this.src='/img/sola2014/2014-anzahl_personen_gefunden.svg'" style="width: 100%">

Schauen wir uns mal die sieben häufigsten erkannten Gesichter an. Wann wurden die denn fotografiert?
<img src="/img/sola2014/2014-anzahl_personen_gefunden_top7_pro_uhrzeit.png" onerror="this.onerror=null; this.src='/img/sola2014/2014-anzahl_personen_gefunden_top7_pro_uhrzeit.svg'" style="width: 100%">
Jonas scheint lange aufzubleiben.

### Andere Sommerlager
Wie verhält sich denn die Foto-Verteilung über den Tag hinweg im Vergleich zu den anderen Lagern? Ich habe mir die letzten drei Sommerlager angeschaut.  
<img src="/img/sola2014/2014-2012-2012-bilder_pro_tag.svg" onerror="this.onerror=null; this.src='/img/sola2014/2014-2012-2012-bilder_pro_tag.svg'" style="width: 100%">

Normalisiert auf die Anzahl der Fotos im jeweiligen Sommerlager sieht das dann wiefolgt aus. Man erkennt, dass es immer mal ein/zwei Tage gibt, bei denen viel mehr fotografiert wird als an den anderen Sommerlagertagen.
<img src="/img/sola2014/2014-2012-2012-bilder_pro_tag-normalisiert.svg" onerror="this.onerror=null; this.src='/img/sola2014/2014-2012-2012-bilder_pro_tag-normalisiert.svg'" style="width: 100%">

## Technischer Hintergrund
Ich habe jedes Bild mit dem EXIF-Keyword »von *Fotograf*« um, unabhängig vom Kameramodell, den Fotografen eindeutig identifizieren zu können.  
Picasa verfügt über eine Gesichtserkennung, die, mit entsprechender Option in den Einstellungen aktiviert, die Gesichtsnamen in allgemein EXIF-Tag namens »RegionName« ablegt. Im wesentlichen definiert es erst eine Region (mit dem Namne des Gesichts) und beschreibt in weiteren, assoziierten Tags die Koordinaten der Region. Kann man sicherlich auch noch auswerten. Hab ich aber nicht. Ich habe auch nicht alle gefundenen Gesichter betaggt, sondern nur die, bei denen Picasa mir schon einen Namnesvorschlag angeboten hatte.

Aller im Folgenden erläuterter Code ist in [einem Gist-Repo zusammengefasst](https://gist.github.com/AndiH/ed115593344f31390d72).

Zum Extrahieren der EXIF-Informationen aus den Bildern habe ich [pyexif](https://github.com/EdLeafe/pyexif) genommen, das im wesentlichen ein Python-Wrapper für das Kommandozeilen-Werkzeug [exiftool](http://www.sno.phy.queensu.ca/~phil/exiftool/) ist. Alle anderen, etwas nativeren Python-EXIF-Zugänge hatten bei meinem Test immer irgendwelche Probleme.  
Um mich nicht mit Restruktierung von geschriebenen und gelesenen Daten auseinanderzusetzen, habe ich als Speicherungsformat JSON benutzt.  
Das entsprechende Skript ist [picStats.py](https://gist.github.com/AndiH/ed115593344f31390d72#file-picstats-py).

Zum resortieren der Information und anzeigen als Graphen habe ich die bekannte Kombination aus Pyplot, Numpy und Prettyplotlib (für schönere Graphen) genommen. Der Aufwand hier war aus den Datumsinformationen konsistente, anzeigbare Werte zu extrahieren, zum Beispiel für die Stunden am Tag. Und herauszufinden, wie die Pyplot-API denn eigentlich so genau funktioniert. Das vergisst man nämlich nach zwei Monaten Nichtbenutzens (ein Naturgesetz).  
Zur Übersicht habe ich alles in einem File zusammengefasst: [createPictureGraphs.py](https://gist.github.com/AndiH/ed115593344f31390d72#file-createpicturegraphs-py).

Mich interessierte auch, wie dieses Sommerlager im Vergleich zu anderen Sommerlagern abschnitt, bei denen wir weniger Fotografierende hatten. [compareYears.py](https://gist.github.com/AndiH/ed115593344f31390d72#file-compareyears-py) stellt das dar.

Python macht Spaß.
