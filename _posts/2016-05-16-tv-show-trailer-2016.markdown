---
layout: post
date: 16.5.2016 16:00
title: Trailers of TV Shows starting in the 2016/2017 Season
---
<style>
	button.embed {
		margin-left: 8px;
		opacity: 0.4;
	}
	button.embed:hover {
		opacity: 0.6;
	}
	button i {
		margin-right: 4px;
	}
</style>

Legend: `(m)` is for midseason (whatever this means), `(s)` is for summer (usually summer 2016). Hit the `Video Embed` button to show (and hide) the embeds of the videos.

* **ABC**
    
* **CBS**
    
* **The CW**
    
* **FOX**
    
* **NBC**
    - The Good Place: [https://www.youtube.com/watch?v=UMf24rEsMOs](https://www.youtube.com/watch?v=UMf24rEsMOs)
    - Timeless: [https://www.youtube.com/watchmv=4glJzvUunOE](https://www.youtube.com/watch?v=4glJzvUunOE)
    - This Is Us: [https://www.youtube.com/watch?v=rfUiKg28r_M](https://www.youtube.com/watch?v=rfUiKg28r_M)
    - *Without trailers yet (all (m)):* The Blacklist: Redemption, Chicago Justice, Emerald City, Great News, Marlon, Powerless, Midnight, Texas, Taken, Trial & Error
    - *More on NBC's 2016 schedule*: [Metacritic](http://www.metacritic.com/feature/nbc-new-shows-and-schedule-fall-2016), [Wikipedia](https://en.wikipedia.org/wiki/2016%E2%80%9317_United_States_network_television_schedule#NBC)
    
* Others
    - **USA**
        - Falling Water: [https://www.youtube.com/watch?v=m4InXOM3PmA](https://www.youtube.com/watch?v=m4InXOM3PmA)
        - Shooter: [https://www.youtube.com/watch?v=X2x6IR3FhbQ](https://www.youtube.com/watch?v=X2x6IR3FhbQ)

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script>
function generateButtonYt(obj) {
    var link = obj.find("a").attr("href"); 
    var id = link.split('watch?v=')[1];
	return '<button class="embed notActive youtube" id="' + id + '"><i class="fa fa-caret-square-o-down"></i>Video Embed</button>';
}
function generateButtonIgn(obj) {
    var link = obj.find("a").attr("href");
    var id = link.split("/");
    id = id[id.length - 1];
    return '<button class="embed notActive ign" id="' + id + '" rel="' + link + '"><i class="fa fa-caret-square-o-down"></i>Video Embed</button>';
}

function generateEmbedCode(obj) {
    var embedString;
    if (obj.hasClass("youtube")) embedString = generateEmbedCodeYt(obj);
    if (obj.hasClass("ign")) embedString = generateEmbedCodeIgn(obj);

    return embedString;
}
function generateEmbedCodeYt(obj) {
    var id = obj.attr("id");
    return '<iframe id="if' + id + '" width="560" height="315" src="//www.youtube.com/embed/' 
    + id + '" frameborder="0" allowfullscreen></iframe>';
}
function generateEmbedCodeIgn(obj) {
    var id = obj.attr("id");
    var url = obj.attr("rel");
    return '<iframe id="if' + id + '" width="560" height="315" src="http://widgets.ign.com/video/embed/content.html?url=' 
    + url + '" frameborder="0" allowfullscreen></iframe>';
}

jQuery(document).ready(function($) {
	$("ul li ul li").each(function() {
		var elementContent = $(this).text();
		if (elementContent.indexOf('youtube') > -1) {
			$(this).append(generateButtonYt($(this))) ;
		}
        if (elementContent.indexOf('ign') > -1) {
            $(this).append(generateButtonIgn($(this)));
        }
	});
	$("button.embed").on("click", function() {
		if ( $(this).is(".notActive") ) {
			$(this).after(generateEmbedCode($(this)));
		}
		else {
			$("iframe#if" + $(this).attr("id") ).remove();
		}
		$(this).toggleClass("notActive active");
		$(this).find("i").toggleClass("fa-caret-square-o-down fa-caret-square-o-up");
	});
});
</script>
