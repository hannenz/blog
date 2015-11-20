---
title: CSS-Triangles the right way
author: hannenz
layout: post
permalink: /css-triangles-the-right-way/
categories:
  - Blog
tags:
  - css
---
Heute bin ich auf einen sehr interessanten Sachverhalt gestossen, den ich kurz hier in Blogform festhalten möchte.

<!--more-->

Wir alle kennen die Möglichkeit mit <a href="http://css-tricks.com/snippets/css/css-triangle/" title="CSS Tricks CSS-Triangles" target="_blank">purem CSS Dreiecke zu erzeugen</a>.

Auch in vielen Sass-Frameworks gibt es Mixins dafür, z. Bsp. auch in <a href="http://bourbon.io" title="Bourbon Sass Framework" target="_blank">Bourbon</a>, das ich zur Zeit gerne benutze. Ich habe mich schon immer gefragt, wieso es manchmal vorkommt, dass bei diesen CSS-Triangles an den Kanten schwarze, hässliche &#8220;Treppen&#8221; entstehen. Nun, in den Kommentaren zu obigem CSS-Tricks Artikel ist die Antwort versteckt und Dank gebührt hier <a href="http://chrismorgan.info/" title="Chris Morgan" target="_blank">Chris Morgan</a>, der erklärt, was hier vor sich geht.

Alle Implementationen die ich bisher gesehen habe – und das schliesst die Mixins in den gängigen Sass-Frameworks mit ein – erzeugen CSS in der Art von [css] border:20px solid transparent; border-top:20px solid #ffffff; [/css] Das Problem dabei ist nun, das moderne Browser <a href="http://de.wikipedia.org/wiki/Antialiasing_%28Computergrafik%29" target="_blank">Anti-Aliasing </a> anwenden, um Kanten zu glätten. Das ist eine Super Sache. Schwierig wird es in diesem speziellen Fall nur, weil – und jetzt kommts – die CSS-Eigenschaft &#96;transparent&#96; technisch einem &#96;rgba(0, 0, 0, 0);&#96; entspricht — also volltransparentem **schwarz**. Es treffen hier nun also eine weisse Rahmenkante auf eine (transparent-)schwarze, und durch das an dieser Schnittstelle angewandte Anti-Aliasing entstehen die schwarzen Treppchen.

Das erklärt auch, warum das Phänomen nicht in jedem Browser auftritt: Es tritt natürlich nur dort auf wo a) RGBA Werte und b) Anti-Aliasing unterstützt werden. Welche das genau sind liesse sich sicher leicht rausfinden, aber ich denke besser wäre es doch einfach, auf folgende Schreibweise umzusteigen:

<pre><code="language-css">
border:20px solid rgba(255, 255, 255, 0);
border-top:20px solid rgba(255, 255, 255, 1.0);
</code></pre>

Wobei die RGB Farbe in beiden Fällen der gewünschten Dreiecksfarbe entspricht, nur eben mit auf-null-gesetztem Alpha-Kanal für die transparenten Kanten.

Ein Sass Mixin könnte dann entsprechend so aussehen (dreist geklaut, angepasst und für Demonstrationszwecke gekürzt aus den <a href="http://bourbon.io" title="Bourbon Sass Framework" target="_blank">Bourbon</a> Addons) :

<pre><code class="language-sass">
@mixin triangle ($size, $color, $direction) {
    height: 0;
    width: 0;
    @if ($direction == up) or ($direction == down) or ($direction == right) or ($direction == left) {
        border-color: rgba($color, 0);
        border-style: solid;
        border-width: $size / 2; 
        @if $direction == up {
             border-bottom-color: rgba($color, 1.0);
        }
        @else if $direction == right {
             border-left-color: rgba($color, 1.0);
        }
        @else if $direction == down {
             border-top-color: rgba($color, 1.0); 
        }
        @else if $direction == left {
             border-right-color: rgba($color, 1.0);
        }
    }
}
</code></pre>

Was hier noch fehlt ist natürlich ein Fallback für Browser, die kein RGBA verstehen. Das überlasse ich dem geneigten Leser selbst. Im Prinzip geht es nur darum zuerst eben doch &#96;transparent&#96; und &#96;soliden&#96; Farbwerten (rgb(), #abcdef) anzugeben und dann mit den RGBA-Werten zu überschreiben.