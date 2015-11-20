---
title: DrWright Typing Monitor auf elementaryOS
author: hannenz
layout: post
permalink: /drwright-typing-monitor-auf-elementaryos/
categories:
  - Blog
---
Wenn man den ganzen Arbeitstag an der Tastatur sitzt, sollte man &#8211; zum einen eine hochwertige mechanische Tastatur, wie z. Bsp. ein [Cherry Board][1] oder noch besser ein [DASKeyboard][2] benuzten &#8211; und sich zum anderen regelmässige Tipp-Pausen gönnen, um die Finger zu entlasten.

<!--more-->

Das Gnome-Tool für Tipp-Pausen nennt sich &#8220;DrWright&#8221; und tut was es soll: Es erinnert einen in konfigurierbaren Intervallen an eine Pause und hindert einen nach drei &#8220;Warnungen&#8221; effektiv am weitertippen, indem es den Bildschirm für eine ebenfalls konfiugurierbaer Pausenzeit sperrt.

DrWright läuft auch unter elementaryOS, und lässt sich über ein PPA installieren:

<pre><code class="language-bash">
    $ sudo add-apt-repository ppa:drwright/stable
    $ sudo apt-get update
    $ sudo apt-get install drwright
</code></pre>
    

Jedoch muss man hier die Einstellungen von Hand im dconf Editor (oder mit gsettings) vornehmen. Unter folgendem Pfad findet man alle Einstellungen, die eigentlich selbsterklärend sind:

<pre><code class="language-none">org.gnome.settings-daemon.plugins.typing-break</code></pre>
    

[<img src="http://hannenz.de/wp-content/uploads/2014/04/dconf-typing-break-263x300.jpg" alt="dconf-typing-break" width="263" height="300" class="alignnone size-medium wp-image-268" />][3]

 [1]: http://www.cherry.de/cid/tastaturen_CHERRY_MX-Board_30.htm
 [2]: http://daskeyboard.com
 [3]: http://hannenz.de/wp-content/uploads/2014/04/dconf-typing-break.jpg