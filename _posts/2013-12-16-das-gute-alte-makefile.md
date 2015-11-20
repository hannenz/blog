---
title: Das gute alte Makefile
author: hannenz
layout: post
permalink: /das-gute-alte-makefile/
categories:
  - Blog
tags:
  - workflow
---
In letzter Zeit liest man viel über [grunt][1] und andere &#8220;Taskmanager&#8221;, die einem als Web-Worker das Leben einfacher machen, z. Bsp. erst letztens ein (an sich super) Artikel im 24ways.com Adventskalender: [Grunt for People Who Think Things Like Grunt are Weird and Hard][2]. Ich selbst habe mit Grunt noch keine Erfahrungen gemacht und nach dem Lesen des Artikels beschlich mich das Gefühl, das hier doch eigentlich das Rad neu erfunden wird und heute vielleicht viel zu schnell vergessen wird, welche tools uns als Entwicklern schon seit Urzeiten zur Verfügung stehen. In diesem Fall spreche ich natüclich vom guten alten [`make`](http://linux.die.net/man/1/make).

<!--more-->

Alles, was in oben genanntem Artikel mit Grunt über eine doch nicht gerade unkomplexe Konfigurationsdatei (uuuuh JSON, wie funky!) bewerkstelligt wird, erschlage ich mit ein paar Zeilen in einem Makefile. Dazu brauche ich (zumindest in meiner Linux-Arbeitsumgebung) weder eine Installation (node.js, grunt) noch muss ich irgendeine neue Syntax lernen. Ok, ich gebe zu, die Syntax von Makefiles ist ebenfalls alles andere als intuitiv und einfach, aber wenn ich sie einmal gelernt hab, kann ich sie für Entwicklungsprozesse **aller** Art einsetzen. Make ist ausserdem seit über 30 Jahren erprobt und unter härtesten Bedingungen in unzähligen Projekten im Dauereinsatz, Dokumentation dazu ist zuhauf zu finden und das Format ist absoluter Standard, d.h. ich sollte eigentlich davon ausgehen können, dass jeder Entwickler (ob Web oder nicht) damit umzugehen versteht.

So zum Beispiel kann ein typisches Web-Projekt mit Sass und Javascript schon mal sehr umfassend automatisiert werden. Das Makefile entstammt einem aktuellen &#8220;real-life&#8221; Projekt, das ich im Moment umsetze:

<pre><code class="language-makefile">
    SASS=gsassc
    JSCOMP=yui-compressor
</code></pre>

Hier werden zunächst mal die &#8220;Compiler&#8221; als Variablen festgelegt, ich verwende als SASS-Compiler eine Eigenentwicklung namens [gsassc][3], die auf [libsass][4] basiert und in C implementiert ist, was für rasend schnelle Kompilierungszeiten sorgt. Hier könnte aber natürlich genausogut `SASS=sass` stehen. Für die Minifizierung der Javascript-Dateien benutze ich den [yui-compressor][5]

<pre><code class="language-makefile">
    SASSDIR=sass
    CSSDIR=css
    JSDIR=javascript
</code></pre>
    

Jetzt werden die Verzeichnisse definiert, in denen die Quelldateien liegen bzw. die Kompilate abgelegt werden. `SASSDIR` beschreibt den relativen Pfad zum Verzeichnis, in dem die SASS-Dateien liegen, `CSSDIR` zeigt auf das CSS-Verzeichnis und `JSDIR` schliesslich auf den Ordner mit den Javascript-Dateien.

Jetzt wirds interessant:

<pre class="line-numbers"><code class="language-makefile">
    CSS := $(addprefix $(CSSDIR)/, main.css main.min.css)
    MODULES := $(addprefix $(SASSDIR)/, main.scss _normalize.scss _typography.scss _shame.scss _fonts.scss _entypo.scss _mediaqueries.scss _offscreenmenu.scss _objects.scss neat/settings/_grid.scss)
    JSMIN   := $(addprefix $(JSDIR)/, main.min.js)
</code></pre>    

Ich gebe hier an, welche Dateien zum Projekt gehören. Hier ist leider noch ein bisschen Handarbeit notwendig, da man die Dateien einzeln und von Hand angeben muss, so dass hier etwas manueller Aufwand nötig ist, wenn Dateien zum Projekt hinzukommen oder gelöscht werden.

Das jeweilige <code class="language-makefile">$(addprefix ...)</code> Konstrukt hängt allen der durch Leerzeichen getrennten Dateinamen den Prefix vor dem Komma an, so das hier im Beispiel eine Liste wie `css/main.css css/main.min.css` entsteht. Unter `CSS` gebe ich alle CSS-Kompilate an, die generiert werden sollen. In diesem Fall ist das eine `main.css` (unkomprimiert zum debuggen) und die entsprechende komprimierte `main.min.css` für den Produktiveinsatz. Unter `MODULES` versammeln sich alle SASS-Quelldateien. Da die eigentliche Einbindung im SASS-Quelltext mit `@import` geschieht, hat diese Liste natürlich keinen Einfluss auf die tatsächliche Komilierung, aber die hier angegeben Dateien werden von `make` auf Änderungen überwacht. `JSMIN` schliesslich beinhaltet die Javascript-Kompilate.

Jetzt folgen die eigentlichen Make-targets und ihre Abhängigkeiten:

<pre><code class="language-makefile">
    all: $(CSSDIR) $(CSS) $(JSMIN) $(MODULES)
</code></pre>    

Das Target `all` soll alles kompilieren, hängt also ab von allen Modulen.

<pre><code class="language-makefile">
    $(CSSDIR)/%.css: $(SASSDIR)/%.scss $(MODULES)
        $(SASS) --style nested $< -o $@
</code></pre>

Diese Regel gibt an, wie aus \*.scss Dateien \*.css entstehen sollen, nämlich durch Aufruf von gsassc mit entspr. Paramteren. `$<` steht für input, `$@` für den Namen des targets

<pre><code class="language-makefile">
    $(CSSDIR)/%.min.css: $(SASSDIR)/%.scss $(MODULES)
        $(SASS) --style compressed $<  -o $@
</code></pre>    

Die nächste Regel beschreibt entsprchend das Vorgehen, wenn `*.min.css` Dateien enstehen sollen. Die Regel ist analog zur oberen, nur werden dem SASS-Compiler andere Parameter übergeben

<pre><code class="language-makefile">
    $(JSDIR)/%.min.js: $(JSDIR)/%.js
        $(JSCOMP) -o $@ $<
</code></pre>    

Und schliesslich das Ganze noch für die Minifizierung von Javascript Dateien.

<pre><code class="language-makefile">
    clean:
        rm -f $(CSSDIR)/*.css
</code></pre>    

Ein `clean`-Target ist auch immer ganz nützlich, um das Projekt von allen Objektdateien und evtl. entstandenen temporären Dateien zu bereinigen.

Und hier noch mal das komplette Makefile:

<pre><code class="language-makefile">
    SASS=gsassc
    JSCOMP=yui-compressor

    SASSDIR=sass
    CSSDIR=css
    JSDIR=javascript

    CSS := $(addprefix $(CSSDIR)/, main.css main.min.css)
    MODULES := $(addprefix $(SASSDIR)/, main.scss _normalize.scss _typography.scss _shame.scss _fonts.scss _entypo.scss _mediaqueries.scss _offscreenmenu.scss _objects.scss neat/settings/_grid.scss)
    JSMIN   := $(addprefix $(JSDIR)/, main.min.js)

    all: $(CSSDIR) $(CSS) $(JSMIN) $(MODULES)

    $(CSSDIR)/%.css: $(SASSDIR)/%.scss $(MODULES)
        $(SASS) --style nested $< -o $@

    $(CSSDIR)/%.min.css: $(SASSDIR)/%.scss $(MODULES)
        $(SASS) --style compressed $<  -o $@

    $(JSDIR)/%.min.js: $(JSDIR)/%.js
        $(JSCOMP) -o $@ $<

    clean:
        rm -f $(CSSDIR)/*.css
</code></pre>

Dieses Makefile zeigt schon mal, was möglich ist, hat aber natürlich noch viel Platz für Erweiterungen (PNGs mit OptiPNG komprimieren, Sprites automatisiert erstellen, Iconfonts generieren&#8230;) und Optimierungen (vor allem die händische Anpassung der Module ist noch suboptimal, Angabe von @PHONY Targets wäre sicher kein Fehler &#8230;) &#8211; über Anregungen und Verbesserungsvorschläge die ihr in den Kommentaren hinterlasst, freue ich mich schon.

### Automatisierung

Natürlich will man ja auch nicht jedes mal `make` eintippen, wenn sich etwas im Quelltext geändert hat, aber natürlich stellt UNIX auch dafür ein einfaches, uraltes aber solides und flexibles tool zur Verfügung: [`watch`](http://linux.die.net/man/1/watch)

Ein einfaches 

<pre><code class="language-bash">$ watch make -n 0,5 [target]</code></pre>

sorgt dafür das `make` alle 0,5 Sekunden aufgerufen wird, um nachzusehen, ob sich etwas geändert hat. Einfacher gehts nicht.

 [1]: http://gruntjs.com/
 [2]: http://www.24ways.org/2013/grunt-is-not-weird-and-hard/
 [3]: http://hannenz.de/gsassc-ein-sass-compiler/
 [4]: https://github.com/hcatlin/libsass
 [5]: http://yui.github.io/yuicompressor/