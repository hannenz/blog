---
title: 'gsassc &#8211; ein Sass Compiler'
author: hannenz
layout: post
permalink: /gsassc-ein-sass-compiler/
categories:
  - Blog
tags:
  - css
  - sass
bodyclass: blog
---
Gerne benutze ich <a href="http://sass-lang.com" title="Sass " target="_blank"><em>Sass</em></a>. Der CSS-Präprozessor stellt wirklich eine sinnvolle und erquickend umfassende Ergänzung zur Stylesheet-Entwicklung dar, die man schon bald nicht mehr missen will. <!--more-->

Wer *Sass* nicht kennt sollte sich schleunigst auf der <a href="http://sass-lang.com" target="_blank">offiziellen Website</a> informieren und anfangen es zu benutzen. Wieso die Welt so lange gebraucht hat, eine so statische &#8220;Sprache&#8221; wie CSS automatisiert generieren (komplilieren) zu lassen, ist sowieso irgendwie unbegreiflich. Ob nun Sass die ultimative und einzig wahre Implementierung für einen CSS-Präprozessor ist, sei mal dahingestellt, jedenfalls ist es sehr brauchbar und entwicklelt sich wohl auch zum Quasi-Standard &#8211; den Konkurennten <a href="http://lesscss.org" target="_blank"><em>LESS</em></a> hat *Sass* jedenfalls in Sachen Popularität schon weit abgehängt.

*Sass* hat jedoch einen gewichtigen Nachteil: In Ruby geschrieben und nicht gerade ein Paradeexmemplar effizienter Programmierkunst, ist es für den täglichen Einsatz oft unbrauchbar. Ich entwickle zum Beispiel gerne mal auf alten/ schwachbrüstigen Kisten die als Entwicklungsserver im LAN hängen &#8211; und wenn dann ein Compilerlauf 10 Sekunden und mehr braucht, ist das eine Workflow-Bremse, die es einem wirklich vermiesen kann, damit zu arbeiten…

## Introducing: libsass

…dachte ich mir und googelte frustriert ein bisschen in der Gegend herum — da stiess ich auf <a href="https://github.com/hcatlin/libsass" target="_blank"><em>libsass</em></a>. Scheinbar haben die Macher von *Sass* genau das Gleiche gedacht und &#8211; preiset und lobet sie dafür &#8211; den kompletten *Sass*-Compiler als C/C++ Bibliothek umgeschrieben und als Bibliothek zur Verfügung gestellt. Was Besseres kann einem alten C-Hasen ja nicht passieren. *Libsass* ist wie gesagt &#8220;nur&#8221; die Bibliothek. Eine lauffähige Referenzimplementierung (in C) gibt es auch gleich dazu: <a href="https://github.com/hcatlin/sassc" target="_blank"><em>sassc</em></a>.

## Gsassc &#8211; GLib Sass Compiler

Natürlich habe ich mich sofort dran gemacht, meine eigene Implementierung zu schreiben: Herausgekommen ist dabei <a href="https://github.com/hannenz/gsassc" target="_blank"><em>gsassc</em></a>. *Gsassc* wurde mit der *GLib* umgesetzt (daher das &#8216;g&#8217;) und verfügt im Gegensatz zu *sassc* über ein paar Optionen mehr, vor allem der Parameter `--watch` ist implementiert und überwacht, wie von *(Ruby-)Sass* gewohnt, einzelne Dateien oder ganze Verzeichnisse auf Veränderungen.

Natürlich ist `gsassc` noch in einem Anfangsstadium und von daher sowohl als &#8220;work-in-progress&#8221; zu verstehen als auch mit Sicherheit nicht bugfrei. Trotzdem benutze ich es bereits produktiv im täglichen Einsatz und es ist ein wahre Freude, wie auch komplexe Projekte mit vielen `@imports`, `@extends` und vielen Zeilen auf meinen alten Dev-Mühlen in sprichwörtlich Null-Komma-Nix kompilieren.

## Anmerkungen

*   So schön das alles ist: *Libsass* ist ebenfalls noch in Entwicklung und implementiert zum Einen (noch) nicht den kompletten *(Ruby-)Sass* Funktionsumfang und hat zum Anderen noch mit so manchen Kinderkrankheiten zu kämpfen
*   *Libsass* und damit implementierte Compiler können naturgemäß nix mit [*Compass*][1] und seinen in Ruby implementierten Mixins und Funktionen anfangen. <a href="http://foundation.zurb.com" target="_blank"><em>Foundation</em></a> und <a href="http://gumby-framework.com" target="_blank"><em>Gumby</em></a> fallen damit aus. (Macht&#8217;s einfach wie ich: Steigt gleich um auf <a href="http://bourbon.io/" target="_blank"><em>Bourbon</em></a>)
*   Den `--watch` Parameter find ich eigentlich eher doof und entspricht so gar nicht der Arbeitsweise eines Unix-Tools. Ich hab ihn nur implementiert, weil ich gerne mal einen <a href="https://developer.gnome.org/gio/unstable/GFileMonitor.html" target="_blank">GFileMonitor</a> benutzen wollte und es hat sich einfach sooo aufgedrängt. In der Praxis schreibe ich aber lieber ein Makefile das per `watch -n 0,5 make` zweimal pro Sekunde schaut ob es gerade was zu kompilieren gibt. Auch das scheint mir nicht gerade die sauberste Lösung — Auf Eure Anregungen in den Kommentaren bin ich sehr gespannt!

 [1]: https://github.com/hannenz/gsassc
