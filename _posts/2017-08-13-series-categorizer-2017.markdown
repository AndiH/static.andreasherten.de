---
layout: post
date: 13.8.2017 14:32
title: Series Categorizer 2017
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
	#horizontalSlider .ui-slider-handle:hover {
		cursor: ew-resize;
	}
	#verticalSlider .ui-slider-handle:hover {
		cursor: ns-resize;
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
	
	
	li.draggable.ui-draggable-dragging {
		border: 1px solid #C0C0FF;
		box-shadow: 0px 0px 3px #FFFFFF;
	}
	ol#shows li.draggable {
		border: 1px solid rgba(0,0,0,0);
	}

	.ui-resizable-handle {
	    position: absolute;
	    font-size: 0.1px;
	    display: block;
	    touch-action: none;
	}
	.ui-resizable-s {
	    cursor: s-resize;
	    height: 7px;
	    width: 100%;
	    bottom: -5px;
	    left: 0;
	}
	#keys {
		position: fixed;
		top: 30px;
		right: 30px;
		color: #909090;
		background: #fbfbfb;
		border: 1px solid #888888;
		padding: 5px;
		z-index: 23;
		opacity: 0.3;
	}
	#keys:hover, #keys:active {
		border-color: #525252;
		opacity: 1;
	}
	#keys .description, #keys .icons {
		display: inline-block;
		vertical-align: middle;
	}
	#keys .description {
		margin-right: 3px;
		font-size: 0.8em;
		text-align: right;
	}
	#keys .icons {
		text-align: center;
	}
	#keys #keys_up {
		display: block;
	    text-align: center;
	    margin-bottom: -5px;
	    margin-left: 1px;
	}
	#keys_size, #keys_focus {
		margin-top: 0.6em;
	}
</style>
<link rel="stylesheet" href="/css/seriestriptychon.css" type="text/css" media="screen" />
<!-- <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"> -->

<script
  src="https://code.jquery.com/jquery-3.2.1.min.js"
  integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
  crossorigin="anonymous"></script>
<script
  src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"
  integrity="sha256-VazP97ZCwtekAsvgPBSUwPFKdrwD3unUfSGVYrahUqU="
  crossorigin="anonymous"></script>
<script src="/assets/js/js.cookie.js"></script>
<script src="/assets/js/jquery.ba-bbq.browserFix.js"></script>
<script src="/assets/js/jquery.ba-bbq.min.js"></script>
<link rel="stylesheet" href="/assets/js/jquery.fancybox.css?v=2.1.5" type="text/css" media="screen" />
<script type="text/javascript" src="/assets/js/jquery.fancybox.pack.js?v=2.1.5"></script>
<script type="text/javascript" src="/assets/js/keypress-2.1.4.min.js"></script>
<script type="text/javascript" src="/assets/js/lz-string.min.js"></script>
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
<!-- 		<span class="formdescription">Map Height:</span> <input type="text" id="boxHeight" value="500" style="width: 35px" title="Height of the show box in px"> -->
<!-- 		<span class="formdescription">Max / Min Font Size:</span> <input type="text" id="maxFontSize" value="2.2" style="width: 25px" title="Maximum font size of a show on the map, in em"> <input type="text" id="minFontSize" class="rightInput" value="0.4" style="width: 25px" title="Minimum font size of a show on the map, in em"> -->
		<!-- <input type="submit" id="setBoxHeight" value="Set"> -->
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
		<form id="showModifier">
			<span class="formdescription">Font size / em:</span> <input type="text" id="size" style="width: 30px" value="1">
			<input type="submit" id="modifyShow" value="Set">
		</form>
	</div>
	<div id="cookieInteraction">
		<span class="formdescription" title="The current shows and their configuration can be saved to or retrieved from the current browser. If available, localStorage is used; Cookies are used otherwise. Note: Cookies have a size limit and can store only so many shows.">Save to browser:</span> <button id="saveCookie">Save</button>
		<button id="loadCookie">Load</button>
	</div>
	<div id="urlInteraction">
		<span class="formdescription" title="Shows can be parsed from URL or a URL for the current shows can be generated.">URLs:</span> 
		<button id="genUrl">Generate URL</button>
		<button id="parseUrl">Parse URL</button>
		<button id="shortenUrl" title="Try to shorten the URL. Does not work if you have many shows.">Shorten</button>
		<pre class="shortedUrl" style="display: inline"><code></code></pre>
		<pre id="url" style="display: none"><code></code></pre>
	</div>
	<div id="genCode">
		<span class="formdescription">HTML Code for Box:</span> <a href="#code" class="fancybox" rel="group"><button id="showCode">Display</button></a>
		<div id="code" style="display: none; max-width: 800px; max-height: 500px; font-size: 0.8em"><pre></pre></div>
	</div>
	<div id="keys">
		<div class="keys_hidden"><strong>?</strong></div>
		<div class="keys_shown" style="display: none;">
			<div id="keys_arrows">
				<span class="description">Move Show:</span>
				<span class="icons">
					<span id="keys_up">▲</span>
					<span id="keys_left">◀</span>
					<span id="keys_down">▼</span>
					<span id="keys_down">▶</span>
				</span>
			</div>
			<div id="keys_more">
				<span class="description">Move more:</span>
				<span class="icons">+ ⇧</span>
			</div>
			<div id="keys_size">
				<span class="description">Font size:</span>
				<span class="icons">⌥+/⌥-<br>
				+/-<span style="font-size: 0.8em">(Numpad)</span>
				</span>
			</div>
			<div id="key_nextprev">
				<span class="description">Select next/prev:</span>
				<span class="icons"><code>j</code>/<code>k</code></span>
			</div>
			<div id="keys_focus">
				<span class="description">Focus <em>New</em>:</span>
				<span class="icons">⌘i</span>
			</div>
		</div>
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
	<ol id="shows">
	</ol>
</div>

Welcome to my **Series Categorizer *2017***!

This year, nothing really changed compared to 2016's version, except for one thing: Use <code>j</code> and <code>k</code> to select the next or previous show in the side list, respectively. With that, pretty much everything is changeable quickly via the keyboard. No need to use the mouse!

<script>var initialized = false;
var mapIsEmpty = true;
var urlMode = false;
var activeShowId;
var arrShows = [];
var defaultPosition = {horizontal: 50, vertical: 50};

function show(name) {
	this.name = name;
	this.id = name.split(' ').join('').toLowerCase().replace(/[_\W]+/g, "");
	this.mapId = "map__" + this.id;
	this.sideId = "side__" + this.id;
	this.xpos = defaultPosition.horizontal;
	this.ypos = defaultPosition.vertical;
	this.fontsize = 1;
}
function sparseShow(show) {
	return {t: show.name, x: show.xpos, y: show.ypos, f: show.fontsize};
}
function generateExportArray() {
	var sparseArrShows = [];
	for (let key in arrShows) {
		let currentShow = arrShows[key];
		sparseArrShows.push(sparseShow(currentShow));
	}
	return {h: $("#seriestriptychon").height(), pur: $(".purgatory").is(":visible"), shows: sparseArrShows};
}
function parseExportArray(arr) {
	// box height
	$("#seriestriptychon").css("height", arr['h']);
	// $("#boxHeight").val(arr['h']);

	// purgatory
	if (arr['pur'] == false) {
		$(".purgatory").fadeToggle("fast");
		$("#displayPurgatory").prop('checked', false);
	}
	// parse shows
	arr['shows'].forEach(function(show){
// 		console.log("Show: ", show);
		loadShow(show);  // <- nope!
	});
}
function selectNextShowInSideList() {
	var currSelection = $("#seriesList #listSelect option:selected");
	if (typeof currSelection.next().val() !== "undefined")
		selectShow(currSelection
			.prop("selected", false)
			.next()
			.prop("selected", true)
			.val()
		);
	else
		console.log("No next show");
}
function selectPrevShowInSideList() {
	var currSelection = $("#seriesList #listSelect option:selected");
	if (typeof currSelection.prev().val() !== "undefined")
		selectShow(currSelection
			.prop("selected", false)
			.prev()
			.prop("selected", true)
			.val()
		);
	else
		console.log("No prev show");
}
function sortSidelist() {
	$("#seriesList #listSelect").find("option").sort(function(left, right) {
		return $(left).text().toLowerCase().localeCompare($(right).text().toLowerCase());
	}).each(function() {
		$("#seriesList #listSelect").append(this);
	});
}
function createShowInSidelist(show) {
	$("#seriesList #listSelect").find($('option')).attr('selected',false);  // deselect all other shows
	$("#seriesList #listSelect").append('<option value="' + show.sideId + '">' + show.name + '</option>');  // append current show to list of show
	sortSidelist();  // sort list
	$("#seriesList #listSelect option[value=" + show.sideId + "]").prop("selected", true);  // select current show
	
	var arrLength = Object.keys(arrShows).length;
	if (arrLength > 3 && arrLength < 20) {
		$("#seriesList #listSelect").attr("size", arrLength);
	}
}
var temp = 0;
function createShowOnMap(show) {
	var createLink = $("#withLink").is( ":checked" );
	var linkBefore = createLink ? '<a href="#' + show.id + '">' : '';
	var linkAfter = createLink ? '</a>' : '';
	
	$("#shows").append('\n\t\t<li id=' + show.mapId + ' style="top: ' + show.ypos + '%; left: ' + show.xpos + '%; font-size: ' + show.fontsize + 'em;" >' + linkBefore + show.name + linkAfter + '</li>');
	$("#" + show.mapId)
		.addClass("draggable")
		.addClass("draggable-active")
		.draggable({
			containment: $("#seriestriptychon"),
			start: function(event, ui) {
	     		$(ui.helper).width($(this).width() + 1);
	     	},
/*
			drag: function( event, ui ) {
			},
*/
			stop: function( event, ui ) {
				var $elm = $(this);
				var pos = $elm.position(),
					parentSizes = {
						height: $("#seriestriptychon").height(),
						width: $("#seriestriptychon").width()
					};
				var xpos = ((pos.left/parentSizes.width) * 100);
				var ypos = ((pos.top/parentSizes.height) * 100);
				xpos = Number(xpos.toFixed(2));
				ypos = Number(ypos.toFixed(2));
				$elm.css('top', ypos + '%').css('left', xpos + '%');
				
				showId = ui.helper[0]["id"].replace("map__","");
				arrShows[showId].xpos = xpos;
				arrShows[showId].ypos = ypos;
			}
	     });
}

function createShow(showname) {
	if (!initialized) initialize();
	var currentShow = new show(showname);
	arrShows[currentShow.id] = currentShow;
		
	activeShowId = currentShow.id;

	createShowInSidelist(currentShow);
	createShowOnMap(currentShow);
	selectShow(activeShowId);
}
function loadShow(currentSparseShow) {
	if (!initialized && !urlMode) initialize();
	var currentShow = new show(currentSparseShow.t);
	currentShow.xpos = currentSparseShow.x;  // ← why?
	currentShow.ypos = currentSparseShow.y;
	currentShow.fontsize = currentSparseShow.f;
// 	console.log(currentSparseShow);
// 	console.log(currentShow);
	arrShows[currentShow.id] = currentShow;
	activeShowId = currentShow.id;
	
	createShowInSidelist(currentShow);
	createShowOnMap(currentShow);
	selectShow(activeShowId);
}
function selectShow(showName) {
	activeShowId = cleanShowId(showName);
	currentShow = arrShows[activeShowId];
	setFontsizeInInputField(currentShow);
	fillShownameIntoInputField(currentShow);
}
function deleteShow() {
	// delete from side list
	$("#listSelect option").filter(function() {
		return $(this).val() == activeShowId
	}).remove();
	// delete from map
	$("#" + arrShows[activeShowId].mapId).remove();
	// delete from show array
	arrShows.splice(activeShowId, 1);
	
	selectShow(arrShows[0]);
}

function initialize() {
	initialized = true;
	$(".init").css("opacity", 1);
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

function fixJqueryDraggableWidth() {
	var currentObject = $("#" + arrShows[activeShowId].mapId);
	
	currentObject.css("width", "");
	currentObject.css("height", "");
	
	currentObject.css("width", currentObject.width() + 1);
	$("#" + arrShows[activeShowId].mapId).css("width", "");
	$("#" + arrShows[activeShowId].mapId).css("width", $("#" + arrShows[activeShowId].mapId));
}

function cleanShowId(showName) {
	return showName.replace("map__", "").replace("side__", "");
}
function resizeShow() {
	var size = $("#showModifier #size").val();
	
	$('#' + arrShows[activeShowId].mapId)
	.css("font-size", size + "em");
	arrShows[activeShowId].fontsize = size;
	fixJqueryDraggableWidth();
}
function setFontsizeInInputField(show) {
	$("#showModifier #size").val(show.fontsize);
}
function fillShownameIntoInputField(show) {
	$("#currentshowname").val(show.name);
}
function renameShow() {
	var oldname = arrShows[activeShowId].name;
	var newname = $("#currentshowname").val();
	if (oldname != newname) {
		arrShows[activeShowId].name = newname;
		// rename in side list
		$("#seriesList #listSelect option:selected").text(arrShows[activeShowId].name);
		// resort side list
		sortSidelist();
		// rename on map
		var element = $("#" + arrShows[activeShowId].mapId);
		if (element.children.length > 0) {
			 $("#" + arrShows[activeShowId].mapId + " a").text(arrShows[activeShowId].name);
		} else {
			 $("#" + arrShows[activeShowId].mapId).text(arrShows[activeShowId].name);
		}
		fixJqueryDraggableWidth();
	}
}
function writeCookie() {
	var expArray = JSON.stringify(generateExportArray());
	if (typeof(Storage) !== "undefined") {
		localStorage.setItem("seriescategorizer", expArray);
	} else {
		Cookies.set("seriescategorizer", expArray);
	}
	console.log("Stored " + Object.keys(arrShows).length + " shows.");
}
function loadCookie() {
	if (typeof(Storage) !== "undefined") {
		var tempArray = JSON.parse(localStorage.getItem("seriescategorizer"));
	} else {
		var tempArray = Cookies.getJSON("seriescategorizer");
	}
	var oldNumberOfShows = Object.keys(arrShows).length;
	parseExportArray(tempArray);
	var newNumberOfShows = Object.keys(arrShows).length;
	console.log("Loaded " + (newNumberOfShows - oldNumberOfShows) + " shows.");
}

function generateUrl() {
	var exportArray = generateExportArray();
// 	var encodedArray = window.btoa(JSON.stringify(exportArray).replace(/’/g, "'"));
	var encodedArray = LZString.compressToBase64(JSON.stringify(exportArray).replace(/’/g, "'"));
	var currentUrlWithoutParams = location.protocol + '//' + location.host + location.pathname;
// 	return $.param.querystring(currentUrlWithoutParams, encodedArray);
	return currentUrlWithoutParams + "?" + encodedArray;
}
function displayUrl(url) {
	$("#urlInteraction #url code").text(url);
}
function parseUrl() {
// 	var parsedUrl = $.deparam.querystring();
	var parsedUrl = window.location.search.substr(1);
// 	var decodedUrl = JSON.parse(window.atob(parsedUrl));
	var decodedUrl = JSON.parse(LZString.decompressFromBase64(parsedUrl));
	parseExportArray(decodedUrl);
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
	var parsedUrl = window.location.search.substr(1);
	try {
		// parsedUrl = JSON.parse(window.atob(parsedUrl));
		parsedUrl = JSON.parse(LZString.decompressFromBase64(parsedUrl));
	}
	catch(err) {return;}
	
	if (!$.isEmptyObject(parsedUrl)) {
		if (('h' in parsedUrl) && ('shows' in parsedUrl)) {
			urlMode = true;
			parseUrl();
		}
	}
	return;
/*
	if (!$.isEmptyObject(parsedUrl['h'])
// 	 && !$.isEmptyObject(parsedUrl['pur'])  // This does not work for some reason!? Super strange
	 && !$.isEmptyObject(parsedUrl['shows'])) {
		urlMode = true;
		parseUrl();
	}
*/
}

function toggleKeyshortcuts() {
	if ($(".keys_hidden").is(":visible")) {
		$(".keys_hidden").fadeToggle("800", function(){$(".keys_shown").fadeToggle("400")});
	} else {
		$(".keys_shown").fadeToggle("800", function(){$(".keys_hidden").fadeToggle("400")});
	}
}

$(document).ready(function() {
	// Init
	$(".fancybox").fancybox();
	
	// Look for parsable URL present
	if (window.location.search.substr(1) != "") {
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
		resizeShow();
	});
	$("#renameshow").button()
	.click(function(event) {
		event.preventDefault();
		renameShow();
	});	
	// Side list
	$("#seriesList #listSelect").change(function(){
		selectShow($(this).val());
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
		$("#seriestriptychon ol#shows li").draggable("disable");
		var header = '<link rel="stylesheet" href="//static.andreasherten.de/css/seriestriptychon.css" type="text/css" media="screen" />\n'.replace(/\</g,"&lt;").replace(/\>/g, "&gt;");
		var content = $("#seriestriptychon").
			prop('outerHTML');
		var content = content.
			replace(/class="draggable draggable-active ui-draggable ui-draggable-handle"/g, "").
			replace(/class="ui-resizable-handle ui-resizable-e"/g, "").
			replace(/class="ui-resizable-handle ui-resizable-se ui-icon ui-icon-gripsmall-diagonal-se"/g, "").
			replace(/\</g,"&lt;").
			replace(/\>/g, "&gt;").
			replace(/(?:\r\n|\r|\n)/g, '<br />');
		$("#code pre").html(header + content);
		$("#seriestriptychon ol#shows li").draggable("enable")
	});
	$("#keys")
	.click(function() {
		toggleKeyshortcuts();
	});

})
$(function() { // http://api.jqueryui.com/draggable/
	$(".draggable").draggable({
		containment: $("#seriestriptychon"),
// 		delay: 100
// 		scope: "tasks"
		opacity: 0.8,
		drag: function( event, ui ) {
			console.log(ui);
		}
		
	})
})
	
$("#seriestriptychon").resizable({
	maxWidth: 800,
	minWidth: 800
});

function moveLeft(amount = 0.2) {
	var newValue = arrShows[currentShow.id].xpos - amount;
	arrShows[currentShow.id].xpos = newValue;
	$('#' + arrShows[activeShowId].mapId).css("left", newValue + "%");
}

function moveUp(amount = 0.2) {
	var newValue = arrShows[currentShow.id].ypos - amount;
	arrShows[currentShow.id].ypos = newValue;
	$('#' + arrShows[activeShowId].mapId).css("top", newValue + "%");
}

function changeFontsize(amount = 0) {
	var newValue = parseFloat(arrShows[currentShow.id].fontsize) + amount;
	$("#showModifier #size").val(newValue);
	resizeShow();
}

// Key bindings
var listener = new window.keypress.Listener();

listener.simple_combo("num_add", function(e) {changeFontsize(0.05);});
listener.simple_combo("alt =", function(e) {changeFontsize(0.05);});  // German keyboard hack …
listener.simple_combo("alt +", function(e) {changeFontsize(0.05);});
listener.simple_combo("num_subtract", function(e) {changeFontsize(-0.05);});
listener.simple_combo("alt -", function(e) {changeFontsize(-0.05);});

listener.simple_combo("left", function(e) {moveLeft();});
listener.simple_combo("shift left", function(e) {moveLeft(1);});
listener.simple_combo("right", function(e) {moveLeft(-0.2);});
listener.simple_combo("shift right", function(e) {moveLeft(-1);});

listener.simple_combo("up", function(e) {moveUp();});
listener.simple_combo("shift up", function(e) {moveUp(1);});
listener.simple_combo("down", function(e) {moveUp(-0.2);});
listener.simple_combo("shift down", function(e) {moveUp(-1);});

listener.simple_combo("j", function(e) {selectNextShowInSideList();});
listener.simple_combo("k", function(e) {selectPrevShowInSideList();});

listener.simple_combo("meta i", function(e) {$("#newshowname").focus().select();});

listener.simple_combo("?", function(e) {toggleKeyshortcuts();}); 

</script>
