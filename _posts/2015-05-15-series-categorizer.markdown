---
layout: post
date: 15.5.2015 17:30
title: Series Categorizer
---
<style type="text/css">
	#modifyconsole, #seriesList {
		display: none;
	}
	#toggleAdminConsole {
		text-align: right;
		margin-top: -1.1em;
	}
	.formdescription {
		font-size: 0.8em;
	}
	#showPositioner .ui-widget-content {
		border: 1px solid #ddd;
	}
	#showPositioner .ui-slider {
		position: relative;
	}
	#showPositioner .ui-slider-horizontal {
		height: 2px;
	}
	#showPositioner .ui-corner-all {
		border-radius: 2px;
	}
	#showPositioner .ui-slider .ui-slider-handle {
		position: absolute;
		z-index: 2;
		width: 15px;
		height: 15px;
	}
	#showPositioner .ui-slider-horizontal .ui-slider-handle {
		top: -9px;
		margin-left: -.6em;
	}
	#showPositioner .ui-state-default, .ui-widget-content .ui-state-default {
		border: 1px solid #ccc;
		background: #f6f6f6;
	}
	#showPositioner .ui-slider-handle.ui-state-default {
		border-radius: 15px;
		top: -8px;
	}
	#showPositioner .ui-slider-handle.ui-state-default.ui-corner-all:focus {
		outline: none;
		box-shadow: 0 0 5px 2px rgb(112, 165, 249);
	}
	#showPositioner .ui-state-hover, .ui-widget-content .ui-state-hover {
		background: #d0e8f7;
		border-color: #9fcae5;
	}
	.init {
		opacity: 0.3;
	}
	#showinput {
		margin-bottom: 15px;
	}	
	#urlInteraction pre {
		overflow: auto;
		font-size: 0.8em;
	}
/*
	#boxModifier input {
		text-align: center;
	}
*/
	#boxModifier .rightInput {
		margin-right: 20px;
	}
	#seriesList {
		position: relative;
		float: left;
		left: 840px;
		top: -100px;
		padding: 10px;
		background-color: rgba(255, 255, 255, 0.4);
		max-width: 160px
	}
	#seriesList h1 {
		font-size: 12px;
		margin-top: 0;
	}
	#seriesList #listSelect {
		float: left;
		margin-right: 5px;
	}
	#seriesList .up-botton, #seriesList .down-button {
		display: block;
	}
</style>
<link rel="stylesheet" href="/css/seriestriptychon.css" type="text/css" media="screen" />

<script src="https://code.jquery.com/jquery-2.1.3.js"></script>
<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<script src="/assets/js/js.cookie.js"></script>
<script src="/assets/js/jquery.ba-bbq.browserFix.js"></script>
<script src="/assets/js/jquery.ba-bbq.min.js"></script>
<link rel="stylesheet" href="/assets/js/jquery.fancybox.css?v=2.1.5" type="text/css" media="screen" />
<script type="text/javascript" src="/assets/js/jquery.fancybox.pack.js?v=2.1.5"></script>
<script>
function initGapi() {
	gapi.client.setApiKey('AIzaSyDzu5-cdGnVFrOGIIO20_nDJo0rQmaVAfs');
	gapi.client.load('urlshortener', 'v1', function() {});
}
</script>
<script src="https://apis.google.com/js/client.js?onload=initGapi"></script>
<div id="toggleAdminConsole"><button>Show Admin Console</button></div>
<div id="modifyconsole">
	<form id="boxModifier">
		<span class="formdescription">Map Height:</span> <input type="text" id="boxHeight" value="500" style="width: 35px" title="Height of the show box in px">
<!-- 		<span class="formdescription">Max / Min Font Size:</span> <input type="text" id="maxFontSize" value="2.2" style="width: 25px" title="Maximum font size of a show on the map, in em"> <input type="text" id="minFontSize" class="rightInput" value="0.4" style="width: 25px" title="Minimum font size of a show on the map, in em"> -->
		<input type="submit" id="setBoxHeight" value="Set">
		<span class="formdescription" title="Should there be a purgatory region at the end of the map? It's for shows you hate but still watch. Because the devil.">Purgatory:</span> <input type="checkbox" id="displayPurgatory" title="Display purgatory?" checked>
	</form>
	<form id="showinput">
		<span class="formdescription">New Show:</span> <input type="text" id="newshowname" value="Show Name">
		<input type="checkbox" id="withLink" title="Create a link?" checked>
		<input type="submit" id="createshow" value="Create Show">
	</form>
	<form id="currentShow" class="init">
		<span class="formdescription" title="Name of currently selected show. Can be used to rename it.">Name of Current Show:</span> <input type="text" id="currentshowname" value="">
		<input type="submit" id="renameshow" value="Set New Name">
<!-- 		<button id="delete">Delete Show</button> -->
	</form>
	<div id="showPositioner" class="init">
		<span class="formdescription">Vertical Position:</span> <div id="verticalSlider"></div>
		<span class="formdescription">Horizontal Position:</span> <div id="horizontalSlider"></div>
		<form id="showModifier">
			<span class="formdescription">Font size / em:</span> <input type="text" id="size" style="width: 30px" value="1">
			<input type="submit" id="modifyShow" value="Set">
		</form>
	</div>
	<div id="cookieInteraction">
		<span class="formdescription" title="The current shows and their configuration can be saved or retrieved from cookies.">Cookies:</span> <button id="saveCookie">Save</button>
		<button id="loadCookie">Load</button>
	</div>
	<div id="urlInteraction">
		<span class="formdescription" title="Shows can be parsed from URL or a URL for the current shows can be generated.">URLs:</span> 
		<button id="genUrl">Generate URL</button>
		<button id="parseUrl">Parse URL</button>
		<button id="shortenUrl">Shorten</button>
		<pre class="shortedUrl" style="display: inline"><code></code></pre>
		<pre id="url" style="display: none"><code></code></pre>
	</div>
	<div id="genCode">
		<span class="formdescription">HTML Code for Box:</span> <a href="#code" class="fancybox" rel="group"><button id="showCode">Display</button></a>
		<div id="code" style="display: none; max-width: 800px; max-height: 500px; font-size: 0.8em"><pre></pre></div>
	</div>
</div>
<div id="seriesList" class="init">
	<h1>List of Series</h1>
	<select id="listSelect" size="3">
<!--
		<input type="button" class="up-button" value="&#9650;">
		<input type="button" class="down-button" value="&#9660;">
-->
	</select>
</div>

<div id="seriestriptychon">
	<div class="lowershadow purgatory"><span class="text">← not so good | good →</span></div>
	<h1 class="genres"><span id="comedy">Comedy</span><span id="drama">Drama</span><span id="crime">Crime/Law</span></h1>
	<ol id="shows"></ol>
</div>

Welcome to my **Series Categorizer**!

For the last few years I've been making my past-year review of TV shows in this form. The best show are more towards the upper border of the box, the worse ones further down. Horizontally, I roughly categorize the shows by their genre.

For this year (2015), I decided to create a tool for generating my series categorization box. Well, here it is. It is based 100 % on JavaScript and runs solely in your browser. If it's still slow, it's probably because I include a bunch of external JavaScript libraries. Although I hope I thought of everything, there's surely space for bugs in this page. It's my first project beyond a couple of lines in JavaScript. If you find a bug, I'd gladly like to hear about it.

I will explain all the features in the following (shorter explanations are available on a mouse over on the boxes/buttons).

Have fun with the tool!

-[Andreas](http://twitter.com/AndiH/)

## Features
The administration console can be shown or hidden with the upper right button. If you're accessing this page with a parseable **Series URL**, the admin panel is hidden by default. In all other cases it should fold out.

### Canvas
You can select the **height** of the box. Also, you can opt for having a *purgatory* area at the bottom of the box. Use it as you like. For me it's for shows which I objectively wouldn't watch anymore but for some reason do anyway. I also call it the Big-Bang-Theory-Area.

### Shows
The center-piece of this page is the series box in the center. Shows are created on the canvas and can be modified afterwards.

#### Creation
The *New Show* field creates a new show by the input name, when clicking »Create Show«. Setting a checkmark create the entry with an additional link (use for writing about the show further down on your own page). As soon as a show is created, it's placed in the center of the map and in the **List of Series** in the right margins of this page. The list is sorted alphabetically.

#### Modifications
A show can be modified if it's selected in the right box. *Modification* means:

* Changing the name with **Name of Current Show**;
* Changing **Vertical** and **Horizontal Position** with the respective sliders;
* Changing the **Font Size** of the current entry.

### Saving
The **Cookies** line deals with saving the current setup of shows. It can either write all current settings into a cookie or load it from there. **Saving** automatically overwrites any previously saved entry, be careful! **Loading** from cookie will append the current list of series by those stored in cookie.

### Linking
A URL for the current setup of shows can be generated. Since there is some data for every show, the URL can become long quite quickly. There's a button to be hit if you want to shorten the generated URL with Google's URL shortener. I haven't tried it yet for very long URLs – it might not work. If the *shorten* button does nothing for you, you probably have Google stuff blocked with a browser plugin (Disconnect, AdBlock). Add the current page to your white list.

If you're accessing the page with a parseable URL, the admin console will be hidden, since I expect you're an user coming here by someone else's instruction. 

### HTML Code
The current HTML code of the series box can be displayed with **HTML Code for Box**. The according <code>.css</code> file should be included, making the code self-containing. Use it on your own page! But, if you don't mind, backlink to my page.

## Known Bugs
* Sometimes, shows are not really selected, although they seem to be. You see that when you want to modify the show's position and nothing changes. Just re-select it in the right box.
* Deleting shows is not possible. Use *rename* instead! There's some implementation, code-wise, but since the shows are an array, not a map, deleting something will lead to the rest of the code to break. Solution: Use a map for the list of shows, not an array. Next version.

## Et Cetera
If you have any suggestions of improvements, ideally with the fitting code snippets, just sent them over.

The page, generally, is CC NC-BY-SA and made by Andreas Herten in May 2015.

<script>
var initialized = false;
var mapIsEmpty = true;
var urlMode = false;
var activeShowId;
var arrShows = [];
var defaultPosition = {horizontal: 50, vertical: 50};

function show(name) {
	this.name = name;
// 	this.number = arrShows.length > 0 ? arrShows[arrShows.length - 1].number + 1 : 0;
	this.number = arrShows.length;
	this.id = name.split(' ').join('').toLowerCase().replace(/[_\W]+/g, "");
	this.mapid = this.id + "_map";
	this.xpos = defaultPosition.horizontal;
	this.ypos = defaultPosition.vertical;
	this.fontsize = 1;
}
function sparseShow(show) {
	return {t: show.name, x: show.xpos, y: show.ypos, f: show.fontsize};
}
function generateExportArray() {
	var sparseArrShows = [];
	arrShows.forEach(function(currentShow) {
		sparseArrShows.push(sparseShow(currentShow));
	});
	return {h: $("#boxHeight").val(), pur: $(".purgatory").is(":visible"), shows: sparseArrShows};
}
function parseExportArray(arr) {
	// box height
	$("#seriestriptychon").css("height", arr['h']);
	$("#boxHeight").val(arr['h']);

	// purgatory
	if (arr['pur'] == false) {
		$(".purgatory").fadeToggle("fast");
		$("#displayPurgatory").prop('checked', false);
	}
	// parse shows
	arr['shows'].forEach(function(show){
// 		console.log("Show: ", show);
		loadShow(show);
	});
}
function sortSidelist() {
	$("#seriesList #listSelect").find("option").sort(function(left, right) {
		return $(left).text().toLowerCase().localeCompare($(right).text().toLowerCase());
	}).each(function() {
		$("#seriesList #listSelect").append(this);
	});
}
function createShowInSidelist(show) {
	$("#seriesList #listSelect").append('<option value="' + show.number + '" selected="selected">' + show.name + '</option>');
	sortSidelist();
	
	if (arrShows.length > 3 && arrShows.length < 20) {
		$("#seriesList #listSelect").attr("size", arrShows.length);
	}
}
function createShowOnMap(show) {
	var createLink = $("#withLink").is( ":checked" );
	var linkBefore = createLink ? '<a href="#' + show.id + '">' : '';
	var linkAfter = createLink ? '</a>' : '';
	
	$("#shows").append('\n\t\t<li id=' + show.mapid + ' style="top: ' + show.ypos + '%; left: ' + show.xpos + '%; font-size: ' + show.fontsize + 'em;" >' + linkBefore + show.name + linkAfter + '</li>');
}

function createShow(showname) {
	if (!initialized) initialize();
	var currentShow = new show(showname);
	arrShows.push(currentShow);
		
	activeShowId = currentShow.number;
	
	moveSliderToShowPosition(currentShow);
	createShowInSidelist(currentShow);
	createShowOnMap(currentShow);
}
function loadShow(currentSparseShow) {
	if (!initialized && !urlMode) initialize();
	var currentShow = new show(currentSparseShow.t);
	currentShow.xpos = currentSparseShow.x;
	currentShow.ypos = currentSparseShow.y;
	currentShow.fontsize = currentSparseShow.f;
// 	console.log(currentSparseShow);
// 	console.log(currentShow);
	arrShows.push(currentShow);
	
	createShowInSidelist(currentShow);
	createShowOnMap(currentShow);
	selectShow(currentShow);
}
function selectShow(show) {
	activeShowId = show.number;
	if (!urlMode) moveSliderToShowPosition(show);
	setFontsizeInInputField(show);
	fillShownameIntoInputField(show);
}
function deleteShow() {
	// delete from side list
	$("#listSelect option").filter(function() {
		return $(this).val() == activeShowId
	}).remove();
	// delete from map
	$("#" + arrShows[activeShowId].mapid).remove();
	// delete from show array
	arrShows.splice(activeShowId, 1);
	
	selectShow(arrShows[0]);
}

function initialize() {
	initialized = true;
	$(".init").css("opacity", 1);
	$("#verticalSlider").slider("option", "disabled", false);
	$("#horizontalSlider").slider("option", "disabled", false);
}

function toggleConsole() {
	$("#modifyconsole, #seriesList").toggle("slow", function() {
		if ($(this).is(':visible')) {
			$("#toggleAdminConsole button").text("Hide Admin Console");
		} else {
			$("#toggleAdminConsole button").text("Show Admin Console");
		}
	});
}

function moveShowHorizontal(value) {
	$('#' + arrShows[activeShowId].mapid)
	.css("left", value + "%");
	arrShows[activeShowId].xpos = value;
}
function moveShowVertical(value) {
	$('#' + arrShows[activeShowId].mapid)
	.css("top", value + "%");
	arrShows[activeShowId].ypos = value;
}
function modifyShow() {
	var s = $("#showModifier #size").val();
	
	$('#' + arrShows[activeShowId].mapid)
	.css("font-size", s + "em");
	arrShows[activeShowId].fontsize = s;
}
function setFontsizeInInputField(id) {
	$("#showModifier #size").val(id.fontsize);
}
function fillShownameIntoInputField(show) {
	$("#currentshowname").val(show.name);
}
function renameShow(show) {
	var oldname = arrShows[activeShowId].name;
	var newname = $("#currentshowname").val();
	if (oldname != newname) {
		arrShows[activeShowId].name = newname;
		// rename in side list
		$("#seriesList #listSelect option:selected").text(arrShows[activeShowId].name);
		// resort side list
		sortSidelist();
		// rename on map
		$("#" + arrShows[activeShowId].mapid).text(arrShows[activeShowId].name);
	}
// 	console.log(oldname == newname);
}
function moveSliderToShowPosition(show) {
	$("#verticalSlider").slider().slider("value", show.ypos);
	$("#horizontalSlider").slider().slider("value", show.xpos);
}
function writeCookie() {
	Cookies.set("seriescategorizer", JSON.stringify(generateExportArray()));
}
function loadCookie() {
	var tempArray = Cookies.getJSON("seriescategorizer");
	parseExportArray(tempArray);
}

function generateUrl() {
	var exportArray = generateExportArray();
	var currentUrlWithoutParams = location.protocol + '//' + location.host + location.pathname;
	return $.param.querystring(currentUrlWithoutParams, exportArray);
}
function displayUrl(url) {
	$("#urlInteraction #url code").text(url);
}
function parseUrl() {
	var parsedUrl = $.deparam.querystring();
	parseExportArray(parsedUrl);
}
var shortenedUrl;
function shortenUrl() {
// 	console.log($("#urlInteraction .url code").text());
	var longUrl = $("#urlInteraction #url code").text();
	var shortUrl = shorten(longUrl);
	console.log(shortUrl);
	shortenedUrl = shortUrl;
// 	$("#urlInteraction .shortedUrl code").text(shortUrl);
}


function shorten(url) {
  var request = gapi.client.urlshortener.url.insert({
	  'resource': {
		  'longUrl': url
	  }
  });
// 	  var shortUrl = "";
  request.execute(function(r) {
	  if (r.id != null) {
	  	$("#urlInteraction .shortedUrl code").text(r.id);
	  	return r.id;
	  } else {
		return "ERROR";
	  }
  });
// 	  return shortUrl;
}

function tryToParseUrl() {
	var parsedUrl = $.deparam.querystring();
	
	if (!$.isEmptyObject(parsedUrl['h'])
	 && !$.isEmptyObject(parsedUrl['pur'])
	 && !$.isEmptyObject(parsedUrl['shows'])) {
		urlMode = true;
		parseUrl();
	}
}

$(document).ready(function() {
	// Init
	$(".fancybox").fancybox();
	
	//^^^ Look for parsable URL present
	if (!$.isEmptyObject($.deparam.querystring())) {
		tryToParseUrl();
	}
	if (!urlMode) {
		$("#modifyconsole, #seriesList").delay(400).toggle("slow", function() {
// 			console.log($(this).is(':visible'));
			if ($(this).is(':visible')) {
				$("#toggleAdminConsole button").text("Hide Admin Console");
			} else {
				$("#toggleAdminConsole button").text("Show Admin Console");
			}
		});
	}
	// Admin Console
	$("#toggleAdminConsole").button()
	.click(function() {
		if (!initialized && urlMode) {
			urlMode = false;
			initialize();
		}
		toggleConsole();
	});
	// Box modifications
	$("#boxModifier #boxHeight").val($("#seriestriptychon").height());
	$("form#boxModifier").submit(function(event) {
		event.preventDefault();
		$("#seriestriptychon").css("height", $("#boxHeight").val());
	});
	$("#displayPurgatory").on("click", function() {
		$(".purgatory").fadeToggle("fast");
	});
	// Show modifications
	$("form#showinput").submit(function(event) {
		event.preventDefault();
		createShow($("#newshowname").val());
	});
	$("form#showModifier").submit(function(event) {
		event.preventDefault();
		modifyShow();
	});
	$("#renameshow").button()
	.click(function(event) {
		event.preventDefault();
		renameShow();
	});
	// Slider
	$("#verticalSlider").slider().slider("value", defaultPosition.vertical).slider("option", "disabled", true);
	$("#horizontalSlider").slider().slider("value", defaultPosition.horizontal).slider("option", "disabled", true);
	$("#horizontalSlider").on("slide", function(event, ui) {
		moveShowHorizontal(ui.value);
	});
	$("#verticalSlider").on("slide", function(event, ui) {
		moveShowVertical(ui.value);
	});
	
	// Side list
	$("#seriesList #listSelect").change(function(){
		activeShowId = $(this).val();
		selectShow(arrShows[activeShowId]);
	});
/* // Sorting in side list
	$("#seriesList .up-button").click(function() {
		$("#seriesList #listSelect option:selected:first-child").prop("selected", false);
		before = $("#seriesList #listSelect option:selected:first").prev();
		$("#seriesList #listSelect option:selected").detach().insertBefore(before);
	});
	$("#seriesList .down-button").click(function() {
		$("#seriesList #listSelect option:selected:last-child").prop("selected", false);
		after = $("#seriesList #listSelect option:selected:last").next();
		$("#seriesList #listSelect option:selected").detach().insertAfter(after);
	});
*/
	// Cookies
	$("#saveCookie").button()
	.click(function(){
		writeCookie();
	});
	$("#loadCookie").button()
	.click(function(){
		loadCookie();
	});
	$("#delete").button()
	.click(function(event) {
		event.preventDefault();
		deleteShow();
	});
	// URLs
	$("#urlInteraction #genUrl").button()
	.click(function(){
		var url = generateUrl();
		displayUrl(url);
		$("#url").css("display", "block");
		$("#urlInteraction #shortenUrl").button( "option", "disabled", false );
	});
	$("#urlInteraction #parseUrl").button()
	.click(function(){
		parseUrl();
	});
	$("#urlInteraction #shortenUrl").button({disabled: true})
	.click(function(){
// 		console.log("shorten");
		shortenUrl();
	});
	$("#showCode").button()
	.click(function(){
		var header = '<link rel="stylesheet" href="http://static.andreasherten.de/css/seriestriptychon.css" type="text/css" media="screen" />\n'.replace(/\</g,"&lt;").replace(/\>/g, "&gt;");
		var content = $("#seriestriptychon").prop('outerHTML').replace(/\</g,"&lt;").replace(/\>/g, "&gt;").replace(/(?:\r\n|\r|\n)/g, '<br />');
		$("#code pre").html(header + content);
	});

})
</script>