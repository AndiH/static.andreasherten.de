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
<img src="/img/sola2014/2014-anzahl_fotos_pro_uhrzeit_pro_fotograf.png.svg" onerror="this.onerror=null; this.src='/img/sola2014/2014-anzahl_fotos_pro_uhrzeit_pro_fotograf.png.svg'" style="width: 100%">

### Getaggte Personen
Ich habe ein paar Gesichter der Fotos getaggt. Bei weitem nicht alle, sondern nur die, die Picasa.app gruppiert und mit Namen vorgeschlagen hat.
Unter derartig getaggten Bildern ist die Häufigkeitsverteilung wiefolgt:
<img src="/img/sola2014/2014-anzahl_personen_gefunden-censored.png" style="width: 100%">

Schauen wir uns mal die sieben häufigsten erkannten Gesichter an. Wann wurden die denn fotografiert?
<img src="/img/sola2014/2014-anzahl_personen_gefunden_top7_pro_uhrzeit-censored.png" style="width: 100%">
Jonas scheint lange aufzubleiben.

### Andere Sommerlager
Wie verhält sich denn die Foto-Verteilung über den Tag hinweg im Vergleich zu den anderen Lagern? Ich habe mir die letzten drei Sommerlager angeschaut.  
Aussagekräftiger wäre hier vielleicht eine normalisierte Verteilung auf die Gesamtzahl der Bilder im jeweiligen Jahr. Wird, vielleicht, nachgereicht.
<img src="/img/sola2014/2014-2012-2012-pictures_per_day.svg" onerror="this.onerror=null; this.src='/img/sola2014/2014-2012-2012-pictures_per_day.svg'" style="width: 100%">

## Technischer Hintergrund
*Folgt.*
