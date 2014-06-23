---
layout: post
date: 23.6.2014 13:40
title: NTuple Analysis with ROOT
tags: ROOT, CERN, Tuple, Tree, TTree, TNTuple, Data Analysis, PANDA
---
<style type="text/css">
	.toc {
		width: 33%;
		float: right;
		font-size: 0.9em;
		background-color: #EEE;
		padding: 3px;
		margin: 3px;
		display: block;
		margin-top: 2.5em;
	}
	.toc a, .toc a:visited {
		color: rgb(37, 103, 150);
	}
	.toc a:hover, .toc a:active {
		color: rgb(66, 129, 173);
	}
	.toc h3 {
		font-size: 1.05em;
		margin-left: 8px;
		margin-top: 8px;
		margin-bottom: 2px;
	}
</style>
<div class="toc" style="display: block;">
	<h3>Table of Contents</h3>
	<ul>
		<li><a href="#about-tuples">About Tuples</a>
			<ul>
				<li><a href="#benefits-of-using-tuples--trees-over-other-means-of-data-storage">Benefits Of Using Tuples / Trees (Over Other Means Of Data Storage)</a></li>
			</ul>
		</li>
		<li><a href="#accessing-trees-and-tuples">Accessing Trees (and Tuples)</a>
			<ul>
				<li><a href="#prerequisites-generating-data-to-a-tree"><strong>Prerequisites</strong>: Generating Data to a Tree</a></li>
				<li><a href="#conservatively-an-explicit-variable-for-every-branch">Conservatively: An <strong>Explicit Variable</strong> for Every Branch</a>
					<ul>
						<li><a href="#branch-status">Branch Status</a></li>
					</ul>
				</li>
				<li><a href="#a-bit-more-fancy-using-structs-and-tidying-up">A Bit More Fancy: Using <strong>struct</strong>s and Tidying Up</a>
					<ul>
						<li><a href="#panda-special-case-bonus">PANDA Special Case Bonus</a></li>
					</ul>
				</li>
				<li><a href="#easier-roots-built-in-functionality">Easier: ROOT’s <strong>Built In</strong> Functionality</a>
					<ul>
						<li><a href="#project-is-double-chevron-draw">Project is Double Chevron <strong>Draw</strong></a>!</li>
						<li><a href="#conditional-projecting">Conditional Projecting</a></li>
						<li><a href="#limit-branch-entries-with-tentrylists">Limit Branch Entries with TEntryLists</a></li>
					</ul>
				</li>
				<li><a href="#performances"><strong>Performances</strong></a></li>
			</ul>
		</li>
		<li><a href="#summary">Summary</a></li>
	</ul>
</div>
A way to handle big chunks of physics data in ROOT is [NTuples](http://root.cern.ch/root/html/TNtuple.html). An NTuple (or Tuple, or **Tree**) usually contains quantities in form of branches ordered into different events. Trees are *the* data structure for accessing data with ROOT and are hence built very well into it. Once your data is in trees, ROOT offers very efficient means of accessing, manipulating and displaying them.

But there are different ways to do so, with different pros and cons, features, and different performances. This post gives a short overview about the techniques I know of.

It might well be that I'm missing an important way to handle tuples/trees. If so, please let me know and I will gladly add something about it.  
I'm illustrating with code snippets and provide self-running source files for every discussed method. The whole code [is available as a Gist](https://gist.github.com/AndiH/093cb9b2bc3334c475fb) – it just needs ROOT, nothing else.  
I'm as general as possible during the description, with a more specific example for my experiment (PANDA) [at one point](#panda-special-case-bonus).

If you feel like knowing everything basic about `TTree`s and `NTuple`s already, feel free to skip the next  introductory paragraph and go directly to [Accessing Trees (and Tuples)](#accessing-trees-and-tuples).  
If you feel like knowing everything else as well, take a look at the <a href="#performances">Performances</a> and <a href="#summary">Summary</a> at the end.

## About Tuples
ROOT's easiest way of handling files on harddisk is `TFile`. Used like this:
{% highlight c++ %}
TFile * file = new TFile("file.root", "RECREATE");
{% endhighlight %}
After initiating a file, objects inheriting from `TObject` (pretty much everything ROOT, e.g. `TH1`s) are saved to the file when calling `file->Write()`. See the [`basic2.C` tutorial](http://root.cern.ch/root/html/tutorials/tree/basic2.C.html) for an easy example.

As soon as a plain `TH1` histogram is saved, though, all information about where the filled-in quantity originates from is lost. Does the resolution deteriorate over time? What's the difference between two connected values, **per event** of course? Two counteract needing helper variables, ROOT offers aforementioned `TTree`s – or `TNTuple` for `float`-only data (I'm going to speak of the more general trees from now onwards).

Trees are initialized by:
{% highlight c++ %}
TTree * tree = new TTree("tree", "Much description");
{% endhighlight %}

Trees can be filled either by ROOT's handy `tree->ReadFile()` shortcut, or more general by creating a variable, creating a branch in the tree for it, and filling it (iteratively). Like this:
{% highlight c++ %}
float data;
tree->Branch("data", &data, "b_data/F"); // F for float (actually Float_t)
data = 10.2;
tree->Fill(); // …
{% endhighlight %}

From a ROOT shell, the data can now be looked at with ROOT's `TBrowser`. It will display everything per default as an one dimensional histogram, but offers ways to change that. You can even display manipulated data on-the-fly (e.g. `tree->Draw("data1 - data2")`) or display data under conditions (`tree->Draw("data1 - data2", "data2 > 15 && data2 < 100")`). More on that further down in **<a href="#conditional-projecting">Conditional Projecting</a>**

###  Benefits Of Using Tuples / Trees (Over Other Means Of Data Storage)
The good thing when running with trees is that you always have access to your original data. You're creating histograms of `diffdata = data1 - data2`, but you're not losing information about `data1` or `data2`.  
The way I'm working with trees at the moment is like this.

  1. I have an experiment's script creating simulation data in tree form as `sim.root`.
  1. By some standard experiment routines ([*qa*](https://subversion.gsi.de/trac/fairroot/browser/pandaroot/trunk/PndTools/AnalysisTools/PndRhoTupleQA.cxx)) inside a macro, `sim.root` gets analysed into `reco.root`. With lots of different branches, like mass, PDG ID, charge, momentum, …
  1. I run over this very general `reco.root`, generate interesting, proper-titled histograms and save these as `eval.root` (combined) and `interesting_histogram.{pdf,svg,eps}` (individually). Only in this last step I leave the realm of trees.

The idea behind this: I can work in small chunks and don't need to run the full chain if I decide to change something (e.g. no re-run of the simulation if used `TLaTeX` wrong again).  
Usually, before creating good-looking histograms for the last point, I have a look at the quantity in an interactive `TBrowser` window of the `reco.root` data. My working, hence, is a mix of using ROOT's quick but unreliable interactive abilities and programmable and reproducible macro mode.

## Accessing Trees (and Tuples)
There are a few different ways of how to work on trees, e.g. for generating my `eval.root` from above. And my unrepresentative survey among colleagues revealed different likings and knowings.

Following now the 3¼ methods of running over trees. Including pros, cons, recommendations and performances. The code is linked.  
Before, though, a small script to generate some random, but reality-like data.

### Prerequisites: Generating Data to a Tree
<span class="file">File: [generate.C](https://gist.github.com/AndiH/093cb9b2bc3334c475fb#file-generate-c)</span>
`generate.C` generates a number of events (first argument given when called, default 100&thinsp;000) with different recorded quantities each. It retrieves some D<sup>+</sup> particle information from ROOT's PDG database. From this, the following information is saved.

| *Quantity*					| *Variable Name* 						| *Description*	|
|:---:|:---:|:---:|
| m<sub>D<sup>+</sup></sub> 	| `dPlusMass` 							| Mass, as of ROOT's PDG db. Constant for every event.	|
| ~m<sub>D<sup>+</sup></sub> 	| `dPlusMassSmeared` 					| Above's original D<sup>+</sup> mass, but gaussian smeared with &sigma; = 0.1&thinsp;GeV; a different value for each event. (Yes, this make little sense.) 	|
| PDG(D<sup>+</sup>) 			| `dPlusPdgCode` 						| The D<sup>+</sup>'s PDG code. Same, for every event.  	|
| &Gamma;(D<sup>+</sup>&rarr;X) | `branchingRatioOfRandomDecayChannel` 	| One of the 68 decay channels of the D<sup>+</sup> built into ROOT is selected and the branching ratio to this channel saved.  	|

### Conservatively: An Explicit Variable for Every Branch
<span class="file">File: [analyze.C, lines 7 to 47](https://gist.github.com/AndiH/093cb9b2bc3334c475fb#file-analyze-c-L11-L47)</span>
The way, most people are using ROOT's trees. The way, ROOT's `tree->MakeClass("myclass")` also creates the data structure inside the `myclass.h` and `myclass.C`.

For every branch, a `float`-typed variable is created. Subsequently, the branch is connected to this variable. Like this:
{% highlight c++ %}
float dPlusMass;
tree->SetBranchAddress("dPlusMass", &dPlusMass);
{% endhighlight %}
Both steps have to be repeated for every branch.  
Now, you loop over all entries (`tree->GetEntry(i)`) and access your variable `dPlusMass` at every iteration of the loop, e.g. for filling it into a histogram.

 * **Pro**: You have lots of control over everything; it's explicit, every variable can be manipulated; it's easy
 * **Con**: Confusing code, cluttering variables (especially for many branches); no objects; lot's of unimportant-code-overhead;

#### Branch Status
With `tree->GetEntry(i)` the i<sup>th</sup> entry of the tree is retrieved *across all branches* – independently if there's an associated `float`-like variable to be filled. Every branch is read.  
Especially for a tree with lots of branches this can slow things down unnecessarily. To change this, there's [`tree->SetBranchStatus()`](http://root.cern.ch/root/html/TTree.html#TTree:SetBranchStatus).

Let's say, you're not interested in the PDG ID in our example tree. Disable it like this
{% highlight c++ %}
tree->SetBranchStatus("dPlusPdg*", 0); // Wildcards are ok
{% endhighlight %}

### A Bit More Fancy: Using `struct`s and Tidying Up
<span class="file">File: [analyze.C, lines 49 to 95](https://gist.github.com/AndiH/093cb9b2bc3334c475fb#file-analyze-c-L49-L95)</span>
Usually, you have some logical structures to your data. Take our example here: There's a mass of the D<sup>+</sup> meson, there's the same mass smeared, there's the D<sup>+</sup>'s PDG code and an associated branching ratio. Luckily we're using C++ which offers a functionality for this: `struct`s and `class`es. Let's take the former, as member variables are public by default.

For our example, a struct can look like this.:
{% highlight c++ %}
struct dMesonInfo {
	Float_t mass, massSmeared, branchingRatio;
	Int_t pdgCode;
};
{% endhighlight %}
Now, a combined container for a D<sup>+</sup> meson can be created with `dMesonInfo myDMeson` and it's member variables accessed like `myDMeson.mass = 10;`. Isn't that much more structured? And clear? And did I say structured?

You still have to set branch addresses:
{% highlight c++ %}
tree->SetBranchAddress("dPlusMass", &(dMeson.mass));
{% endhighlight %}
While we are at it: Probably you need to set branch addresses quite a few times during your analyses, probably from different macros. Why not extract this functionality to it's own method? In your macro, everything can then neatly look like:
{% highlight c++ %}
dMesonInfo dPlus;
setBranchAddresses(tree, dPlus);
{% endhighlight %}

A loop over all entries with `tree->GetEntry(i)` is still needed, this time filling not `dPlussMass` but `dPlus.mass` into histograms. 

 * **Pro**: You have lots of control over everything; it's explicit, every variable can be manipulated; it's structured clearly
 * **Con**: There's still that big loop…

#### PANDA Special Case Bonus
The power of using objects like this is even more obvious if you have decay chains. Let's say the D<sup>+</sup> decays like this: D<sup>+</sup> &rarr; K<sup>-</sup> &pi;<sup>+</sup> &pi;<sup>+</sup>. Our software produces branches for all particles' masses in the terminology of `dPlusm`, `dPlusd0m`, `dPlusd1m`, and `dPlusd2m` (`m` for mass, `d{0-2}` for the daughter particles). To bring that into a more structure code in accordance to my above `struct`-using approach, this looks like:
{% highlight c++ %}
struct dProperties {
	Float_t pt, px, py, pz, p, E;
	Float_t m, chg, pdg;
};

struct DInfoContainer {
	dProperties m; // actual d meson (m=mother)
	dProperties d0, d1, d2; // three daughters
};
{% endhighlight %}
With this, I can access the mass of the second daughter as `dMeson.d2.m`. Great!

### Easier: ROOT's Built In Functionality
<span class="file">File: [analyze.C, lines 97 to 121](https://gist.github.com/AndiH/093cb9b2bc3334c475fb#file-analyze-c-L97-L121)</span>
To bypass the messy variable declaration and loops, ROOT has some built-in functionality. It directly projects the content of a branch onto a (fitting) histogram. The method, thus, is `Project`. An example:
{% highlight c++ %}
TH1F * histDPlusMass = new TH1F("histDPlusMass", "D^{+} m", 100, 1.7, 2.0);
tree->Project("histDPlusMass", "dPlusMass");
{% endhighlight %}
Look! No loop! No `float` variables! Just the histogram, and projection onto that. This uses ROOT's usual string object identifier method – annoying when referencing objects, but handy, when relying on ROOT's string parser to plot under conditions (see below). To plot two-dimensionally, use a colon ("dPlusMass:dPlusMassSmeared") – of course our histogram has to be a `TH2F` as well.  
If that sounds awfully familiar to you, well, read on.

 * **Pro**: Very short; no intermediate variable definition
 * **Con**: Uses ROOT's string syntax; somewhat limited ability to manipulate data for histograms

#### `Project` is Double Chevron `Draw`!
Actually, `Project()` [is just a wrapper](http://root.cern.ch/root/html/src/TTree.cxx.html#ySJJiB) for calling a tree's `Draw` functionality with a double ">" *pipe-to* operator to a histogram. The previous code snippet example is equal to:
{% highlight c++ %}
TH1F * histDPlusMass = new TH1F("histDPlusMass", "D^{+} m", 100, 1.7, 2.0);
tree->Draw("dPlusMass >> histDPlusMass", "", "goff");
{% endhighlight %}
Notice the undocumented `goff` drawing option as a third parameter, which draws *silently* and does not open a new canvas while drawing – pretty handy if that's what you want.  
You can use `>>+` to append entries to the same histogram in another call.

#### Conditional Projecting
Both `Project()` and `Draw()` accept a third / second parameter to plot under conditions. This can either be a `string` directly or a `TCut` object. Some examples:
{% highlight c++ %}
tree->Project("histDPlusMass", "dPlusMass", "dPlusMassSmeared > 0");
TCut myCut = "(dPlusMass - dPlusMassSmeared) > 0";
tree->Project("histDPlusMassSmeared", "dPlusMassSmeared", myCut);
{% endhighlight %}

Drawing conditions can be everything understood by the [`TFormula` parser](http://root.cern.ch/root/html/TFormula.html) – and this is quite a lot. Here's a silly example to show you some functions.
{% highlight c++ %}
tree->Project("histDPlusMassSmeared", "dPlusMassSmeared", 
	"sin(sqrt(pow(dPlusMass,2)) - dPlusMassSmeared)/dPlusMassSmeared > 0");
{% endhighlight %}

To finalize this paragraph: If the condition does not evaluate to a boolean `0` or `1`, its result is taken as a weight when filling the branch's value to the histogram. To come back to the example from above:
{% highlight c++ %}
tree->Project("histDPlusMassSmeared", "dPlusMassSmeared", 
	"sin(sqrt(pow(dPlusMass,2)) - dPlusMassSmeared)/dPlusMassSmeared");
{% endhighlight %}
This output is as silly as the previous one, but at least its oscillating. Yay.

#### Limit Branch Entries with `TEntryLists`
To have even more control about individual events of a tree, ROOT offers `TEntryList`s. As the name suggests, these are lists, containing entry numbers of a tree. `TEntryList`s can be generated by a `Draw()` with cuts as above, can be extended manually, combined with other entrylists and finally used to do something useful, like drawing again.

Entrylists are generated, when the double-chevron `Draw()` is called without a preceeding branch name. The `TEntryList` then needs to be retrieved from ROOT's internal directory. Exampletime.
{% highlight c++ %}
tree->Draw(">> myList", "(dPlusMass - dPlusMassSmeared) > 0", "entrylist");
TEntryList * myList = (TEntryList*)gDirectory->Get("myList");
tree->SetEntryList(myList);
tree->Draw("dPlusMassSmeared");
myList->Enter(100); // Manually enter event number 100
tree->Draw("dPlussMassSmeared"); // (Maybe) one event more
{% endhighlight %}


### Performances
Interestingly, the different approaches have varying performances if run in ROOT's interpreted macro mode (the default, `root analyze.C`) or with ROOT's on-the-fly compilation capabilities (just adding a "+" sign after the macro filename, when starting root: `root analyze.C+`).

To summarize: Running in macro mode, using `Project()` (or `Draw()`) is more than two times faster than the explicit or `struct` version. Running compiled, though, the explicit / `struct` version is faster – twice as fast as the compiled `Project()`/`Draw()` method.

The numbers follow in the next table. For 10 million events. Timed with ROOT's `TStopwatch` and `time` (calling `time root -q -l -b analyze.C`). On my MacBook (Intel Core i7 at 2.3 GHz).

<table style="width: 100%;">
	<thead>
		<tr>
			<th> </th>
			<th colspan="3">Interpreted Macro Mode</th>
			<th colspan="3">Compiled Mode</th>
		</tr>
		<tr>
			<th style="text-align: center;"><em>Method</em></th>
			<th style="text-align: center;"><em>Real Time</em></th>
			<th style="text-align: center;"><em>CPU Time</em></th>
			<th style="text-align: center;"><em>Total ROOT Runtime</em></th>
			<th style="text-align: center;"><em>Real Time</em></th>
			<th style="text-align: center;"><em>CPU Time</em></th>
			<th style="text-align: center;"><em>Total ROOT Runtime</em></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><em><strong>1)</strong> Explicit Variables</em></td>
			<td style="text-align: right">23.8&thinsp;s</td>
			<td style="text-align: right">23.8&thinsp;s</td>
			<td rowspan="4" style="text-align: right">79&thinsp;s</td>
			<td style="text-align: right">5.2&thinsp;s</td>
			<td style="text-align: right">5.2&thinsp;s</td>
			<td rowspan="4" style="text-align: right">32&thinsp;s</td>
		</tr>
		<tr>
			<td><em><strong>2)</strong> Struct</em></td>
			<td style="text-align: right">29.8&thinsp;s</td>
			<td style="text-align: right">23.8&thinsp;s</td>
			<td style="text-align: right">5.3&thinsp;s</td>
			<td style="text-align: right">5.3&thinsp;s</td>
		</tr>
		<tr>
			<td><em><strong>3)</strong> Project</em></td>
			<td style="text-align: right">10.8&thinsp;s</td>
			<td style="text-align: right">10.7&thinsp;s</td>
			<td style="text-align: right">10.8&thinsp;s</td>
			<td style="text-align: right">10.8&thinsp;s</td>
		</tr>
		<tr>
			<td><em><strong>4)</strong> Draw</em></td>
			<td style="text-align: right">10.7&thinsp;s</td>
			<td style="text-align: right">10.6&thinsp;s</td>
			<td style="text-align: right">10.8&thinsp;s</td>
			<td style="text-align: right">10.8&thinsp;s</td>
		</tr>
	</tbody>
</table>

## Summary
ROOT's TTree / TNTuple data structure is great for working on event-wise data. There are different ways to do so, tough.

The simplest one is creating a variable for each branch of the tree and connecting it to the corresponding branch by means of *setting the branch address*. It's really quite explicit, verbose and lets the analyst manipulate the data fully during processing. But especially for many branches, it's a bunch of possibly confusing code with lots of possible mistypes.  
To unclutter your code, I suggest creating small `struct`s to structurize your data. And, remember: Typing things twice is the programmer's enemy – you should probably create a function!

ROOT also offers built-in functionality to directly transfer a branch's content onto a histogram. Use `tree->Draw()` or the wrapper function `tree->Project()` for this. You may use arbitrarily sophisticated cut criteria on the way.

In terms of performance it is strongly depending on how you run ROOT. Do you run in macro, uncompiled, interpreted mode? Use `Project` and `Draw`! Do you run compiled, consider taking the *explicit* approach.  
Of course, your use case might interfere with that: Creating a Lorentz vector from four variables, adding it to a different Lorentz vector and plotting its mass will not work in ROOT's `Project`.

Be clever.