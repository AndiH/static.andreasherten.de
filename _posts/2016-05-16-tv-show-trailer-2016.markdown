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
    - American Housewife: [https://www.youtube.com/watch?v=A9JRoZsnINw](https://www.youtube.com/watch?v=A9JRoZsnINw)
    - Conviction: [https://www.youtube.com/watch?v=KJqg6J4JeLg](https://www.youtube.com/watch?v=KJqg6J4JeLg)
    - Designated Survivor: [https://www.youtube.com/watch?v=N_f1v0Nx5Sw](https://www.youtube.com/watch?v=N_f1v0Nx5Sw)
    - Downward Dog: [https://www.youtube.com/watch?v=M3_bDWTTLWc](https://www.youtube.com/watch?v=M3_bDWTTLWc)
    - Imaginary Mary: [https://www.youtube.com/watch?v=15vywGIjvPk](https://www.youtube.com/watch?v=15vywGIjvPk)
    - Notorious: [https://www.youtube.com/watch?v=yZBP6wb3xmI](https://www.youtube.com/watch?v=yZBP6wb3xmI)
    - Speechless: [https://www.youtube.com/watch?v=4u55WK6AbaM](https://www.youtube.com/watch?v=4u55WK6AbaM)
    - Still Star-Crossed: [https://www.youtube.com/watch?v=LllK0jMn_hs](https://www.youtube.com/watch?v=LllK0jMn_hs)
    - Time After Time: [https://www.youtube.com/watch?v=VN4C4Ar5BLo](https://www.youtube.com/watch?v=VN4C4Ar5BLo)
    
* **CBS**
    
* **The CW**
    
* **FOX**
    - 24: Legacy (m): [https://www.youtube.com/watch?v=sOWpUB_Xdqs](https://www.youtube.com/watch?v=sOWpUB_Xdqs)
    - APB (m): [https://www.youtube.com/watch?v=bsbVnrOkcr8](https://www.youtube.com/watch?v=bsbVnrOkcr8)
    - The Exorcist: [https://www.youtube.com/watch?v=5NH3ffAp9aA](https://www.youtube.com/watch?v=5NH3ffAp9aA)
    - Lethal Weapon: [https://www.youtube.com/watch?v=cXZdEmvcFdU](https://www.youtube.com/watch?v=cXZdEmvcFdU)
    - Making History (m): [https://www.youtube.com/watch?v=Z-TVyOqCkr0](https://www.youtube.com/watch?v=Z-TVyOqCkr0)
    - The Mick (m): [https://www.youtube.com/watch?v=MQ6Jg5i_pqc](https://www.youtube.com/watch?v=MQ6Jg5i_pqc)
    - Pitch (m): [https://www.youtube.com/watch?v=k0wLCGwYZ3g](https://www.youtube.com/watch?v=k0wLCGwYZ3g)
    - Prison Break (m): [https://www.youtube.com/watch?v=x9T-9fZn_oA](https://www.youtube.com/watch?v=x9T-9fZn_oA)
    - The Rocky Horror Picture Show: [https://www.youtube.com/watch?v=outmDIi29Bo](https://www.youtube.com/watch?v=outmDIi29Bo)
    - Shots Fired (m): [https://www.youtube.com/watch?v=1RmkAihHeJg](https://www.youtube.com/watch?v=1RmkAihHeJg)
    - Son of Zorn: [https://www.youtube.com/watch?v=kPnlQTi8heM](https://www.youtube.com/watch?v=kPnlQTi8heM)
    - Star (m): [https://www.youtube.com/watch?v=T2snL9QUIZI](https://www.youtube.com/watch?v=T2snL9QUIZI)
    
* **NBC**
    - The Good Place: [https://www.youtube.com/watch?v=UMf24rEsMOs](https://www.youtube.com/watch?v=UMf24rEsMOs)
    - Timeless: [https://www.youtube.com/watchmv=4glJzvUunOE](https://www.youtube.com/watch?v=4glJzvUunOE)
    - This Is Us: [https://www.youtube.com/watch?v=rfUiKg28r_M](https://www.youtube.com/watch?v=rfUiKg28r_M)
    - *Without trailers yet (all (m)):* The Blacklist: Redemption, Chicago Justice, Emerald City, Great News, Marlon, Powerless, Midnight, Texas, Taken, Trial & Error
    - *More on NBC's 2016 schedule*: [Metacritic](http://www.metacritic.com/feature/nbc-new-shows-and-schedule-fall-2016), [Wikipedia](https://en.wikipedia.org/wiki/2016%E2%80%9317_United_States_network_television_schedule#NBC)
    
* **USA**
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
