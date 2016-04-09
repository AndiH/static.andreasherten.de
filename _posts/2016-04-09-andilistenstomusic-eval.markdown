---
layout: post
date: 9.4.2016 16:00
title: Statistics of andilistenstomusic.tumblr.com
---

About two years ago, I started listening to DJ mixes while working. They are are good background music and keep me motivated. Some months later, I started noting them down in a small tumblog called [andilistenstomusic.tumblr.com](http://andilistenstomusic.tumblr.com). Maybe someone also was interested in my curated musical background stuff? In addition, I noted down the length of the mix I listened to.

Yesterday, I posted the 1000th mix. Let's look at some stats!

## Totals

In total, I listened to about __64&thinsp;000&thinsp;min__ of music. That's 1065&thinsp;hours, or about 44 continuous days. Wow!

Most of the mixes come from Soundcloud (80&thinsp;%). Mixcloud is the second important source I use (about all of the rest). Only a small fraction is hosted somewhere else (~0.5&thinsp;%).

## Lengths of Mixes

A typical DJ set is, on average, 64&thinsp;min long. The median is at exactly 60&thinsp;min, by the way.

The distribution of the length of the mixes looks like this:
![Lengths of Sets](/img/altm/altm-length-of-set.svg "Lengths of Sets"){:width="100%"}
Again, you see that there's a clear peak at 60&thinsp;min (more [slightly less](/img/altm/altm-length-of-set-zoom.svg)) and an additional peak around 120&thinsp;min. If you look closely, you find an entry around the 350&thinsp;min mark. This is, with some distance, the longest mix. It's [Mr. Scruff's 6 Hour DJ Set from Amsterdam from January](http://andilistenstomusic.tumblr.com/post/138546231718/6-hour-dj-set-from-amsterdam-marktkantine-january). Crazy guy.

Save for different statistics, there's no real difference concerning Mixcloud and SoundCloud. Maybe Mixcloud mixes are not as much peaking around the 60 and 120&thinsp;min marks.
![Lengths of Sets per Hoster](/img/altm/altm-length-of-set-hoster.svg "Lengths of Sets per Hoster"){:width="100%"}
Mixes of the *Other* category tend to be a bit shorter. But remember the number of entries in this category…

## Distribution over Time

The reason I needed a lot of motivation when programming and writing stuff on the computer was my PhD thesis. Looking at the cumulative listening length per week, do you want to guess when I handed in my thesis?
![Length per Week](/img/altm/altm-length-per-day-1w.svg "Length per Week"){:width="100%"}
You're right: Mid of April! In the course of three weeks, the listening amount dropped from 2000&thinsp;min to 400&thinsp;min. Guess I was fed up sitting silently in front of the computer.  
Also of interest: There are weeks in which I listened to (barely) anything. They are called vacation.

## 15 O'Clock is Music Time

I seem to listen to most of the mixes from 14:00 to 15:00. 
![Hourly Number of Mixes](/img/altm/altm-hourly-number-of-mixes.svg "Hourly Number of Mixes"){:width="100%"}
It can be seen that a usual day starts somewhere around 8:00 and continues to about 19:00. There are also entries after midnight, because that's what writing a thesis does to you.  
Note: I always posted the mix after I listened to it. So these are end times. (Also, I did not adjust for daylight saving time…)

## Method

I used a Jupyter notebook to evaluate the the tumblog. It's available [here](https://gist.github.com/AndiH/471e87752e966feb4aac7237960850b0), you can play with the stuff yourself – it's explained how to run everything. Also, there are a few more graphs there.

If you come up with a cool feature, let me know!
