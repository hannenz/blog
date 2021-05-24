---
title: 'Typografie im Web: 90%'
author: hannenz
layout: post
permalink: /typografie-im-web/
categories:
  - Blog
tags:
  - css
  - typografie
bodyclass: blog
---
Auf einen interessanten Browserbug (?) bin ich neulich gestoßen, als ich für ein Projekt versale Headlines zentriert ausrichten wollte.

<!--more-->

Um die in versalen Lettern gesetzten, großen Überschriften typografisch ansprechend zu gestalten wurden diese mit einer relativ hohen Laufweite (letter-spacing) ausgezeichnet. Zusätzlich verlangt das Design, dass die Überschriften zentriert sind, es ergab sich also CSS in dieser Art:

<pre><code class="language-css">
font-size: 2.5em;
letter-spacing: 0.6em;
text-align: center;
</code></pre>

Eigentlich nichts, was einen in Besorgnis versetzen sollte. Was allerdings im Browser gerendert wurde, ließ mich dann doch stutzen: Das `letter-spacing` wird einfach nur nach jedem Buchstaben angehängt und *nicht* auf das `text-align:center` eingerechnet, wodurch der Text optisch (bei so hoher Laufweite eben deutlich) &#8220;aus der Mitte raus&#8221; versetzt wird. Hier ein Screenshot zur Anschauung:

![][1]

Warum der Text nun offensichtlich aus der Zentrierung rutscht wird deutlich, wenn man den Text mit der Maus markiert, wodurch die durchs `letter-spacing` verursachten Weißräume sichtbar werden:

![][2]

Die einzige einigermassen gangbare Lösung für dieses Problem, die ich bisher gefunden habe, wäre dem betreffenden Objekt ein `padding-left` in Höhe des verwendeten `letter-spacing`s mitzugeben:

<pre data-line="4"><code class="language-css">
font-size: 2.5em;
letter-spacing: 0.6em;
text-align: center;
padding-left: 0.6em;
</code></pre>

Das funktioniert und liefert das optisch richtige Ergebnis, es hängt jedoch wohl vom konkreten Einsatzzweck ab, ob die Verwendung eines Extra-Paddings eine Option ist oder nicht (Alternativ könnte man natürlich genausogut mit einem `margin-left` oder auch mit `position:relative` und `left:0.6em` experimentieren. Trotz allem &#8211; es bleibt ein Workaround und ein schaler Nachgeschmack&#8230; Typografie im Web? 90%.

 [1]: /media/letterspacing_aligncenter_1.jpg
 [2]: /media/letterspacing_aligncenter_2.jpg
