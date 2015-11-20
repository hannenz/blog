---
title: DAAP Server auf dem Raspberry Pi
author: hannenz
layout: post
permalink: /daap-server-auf-dem-raspberry-pi/
categories:
  - Blog
tags:
  - daap
  - raspberry pi
---
Schon seit langem beschäftigt mich die Frage, wie ich am besten meine Musiksammlung verwalten lasse. Im Moment liegt die komplette Sammlung auf einer externen USB-Festplatte, die an einem Raspberry Pi hängt. Dieser wiederum ist an die Wohnzimmer-Stereoanlage angeschlossen. Meine Musik möchte ich natürlich über die Stereoanlage hören, aber auch &#8220;nach extern&#8221; streamen, z. Bsp. bei der Arbeit oder beim Joggen auf dem Smartphone.

<!--more -->

Zunächst schien mir MPD der richtige Kandidat, aber inzwischen bin ich doch wieder eher zu einer DAAP Lösung geneigt. ich möchte eben die Musiksammlung sowohl über die Stereoanlage abspielen als auch von jedem Gerät aus (Smartphone, PC, Laptop) darauf zugreifen können, also muss eine Streaming-Lösung her. MPD kann zwar auch Streamen und das funktioniert im Prinzip auch, jedoch ist das alles ein wenig umständlich und auch &#8220;wackelig&#8221;, sprich instabil. Es fühlt sich irgendwie nicht richtig an. Also wieder mt-daapd installieren, hatte ich früher schon am Laufen, lief immer gut. Pustekuchen. Mt-daapd läuft nicht auf der ARM-Platform des Raspberry. Es gibt eine geforkte Version namens <a title="forked-daapd auf GitHub" href="https://github.com/jasonmc/forked-daapd" target="_blank">forked-daapd</a>, die auf Raspbian läuft. Leider verhält es sich nur so, dass ein großer Teil meiner Musiksammlung im Ogg-Vorbis Format vorliegt und forked-daapd sich weigert, dies abzuspielen. <a title="forked-daapd with Remote 3.0 support" href="http://www.raspberrypi.org/phpBB3/viewtopic.php?f=66&#038;t=34825" target="_blank">Hier</a> bin ich auf die Möglichkeit gestossen, das ursprüngliche mt-daapd in einer stabilen Version doch noch kompiliert zu bekommen. Die Anleitung in obigem Link ist schon mal sehr gut, ich habe noch ein paar Kleinigkeiten ergänzt, die hauptsächlich die OGG Unterstützung betreffen. So hab ich es schliesslich hinbekommen:

<pre><code class="language-bash">
    sudo apt-get install libsqlite3-dev libgdbm-dev libflac-dev flac libvorbis-dev libid3tag0-dev
    wget http://pkgs.fedoraproject.org/repo/pkgs/mt-daapd/mt-daapd-svn-1696.tar.gz/42ba1f432bb88e18a8cb4ce0fc52eb64/mt-daapd-svn-1696.tar.gz
    tar xvzf mt-daapd-svn-1696.tar.gz
    cd mt-daapd-svn-1696/ ./configure --enable-oggvorbis --enable-flac --enable-sqlite3
    make
    sudo make install
    sudo cp contrib/mt-daapd.conf /usr/local/etc/
</code></pre>

Edit `/usr/local/etc/mt-daapd.conf`: Setup mp3dir, add &#8220;.ogg,.flac&#8221; to `extensions` and change `sqlite` to `sqlite3`

Ganz reibungslos funktioniert das irgendwie zwar immer noch nicht &#8211; z.Bsp. bekomme ich kurioserweise in Rhythmbox auf der Arbeit keinen Sound bei Ogg-Dateien, zu Hause aber schon. (Die Fortschritsanzeige läuft brav aber es kommt einfach kein Ton).