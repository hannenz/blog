---
title: fontcustom in elementaryOS (ubuntu 12.04)
author: hannenz
layout: post
permalink: /font-custom-in-elementary-ubuntu-12-04/
categories:
  - Blog
tags:
  - css
  - svg
  - webfont
  - workflow
bodyclass: blog
---
Inzwischen habe ich mich so an [elementaryOS][1] gewöhnt, dass ein Distributionswechsel gar nicht mehr in Frage kommt. Heute habe ich von [Font Custom][2] erfahren, einem in Ruby geschriebenen Kommandozeilentool zur Erstellung von (Icon-)Webfonts. Genau das was ich brauche, um von Webservices wie z. Bsp. [IcoMoon][3] unabhängig zu sein (wobei IcoMoon trotzdem ein sehr geniales Tool ist und bleibt) und ideal zur Integration in einen [Build-Prozeß mit Make][4].

<!--more-->

`FontCustom` benötigt &#8211; zwar nicht zwingend, aber man will ja auch nicht auf das Autohinting verzichten &#8211; das Programm [ttfautohint][5], welches leider erst ab Ubuntu 12.10 in den Paketquellen ist, das heisst: Selber kompilieren, das ist aber gar nicht schwierig.

Zunächst die Abhängigkeiten installieren, die zum Glück sehr überschaubar sind:

    sudo apt-get install qt4-qmake automoc
    

Dann laden wir den Quellcode bei SourceForge herunter:

<pre><code class="language-bash">
wget http://sourceforge.net/projects/freetype/files/ttfautohint/0.97/ttfautohint-0.97.tar.gz
tar xzvf ttfautohint-0.97.tar.gz
cd ttfautohint-0.97
</code></pre>

und kompilieren das Ganze:

    ./configure
    make
    sudo make install
    

Als nächstes brauchen wir noch eine Ruby Version > 1.9.1, Ubuntu 12.04 kommt jedoch noch mit Ruby 1.8.x. Mit der [Anleitung hier][6] ist das aber auch schnell erledigt.

Hat alles geklappt, können wir wie auf der [Website][2] beschrieben, font-custom installieren:

    sudo apt-get install fontforge
    wget http://people.mozilla.com/~jkew/woff/woff-code-latest.zip
    unzip woff-code-latest.zip -d sfnt2woff && cd sfnt2woff && make && sudo mv sfnt2woff /usr/local/bin/
    gem install fontcustom
    

Ich habe bisher nur kurz mit `Font Custom` herumgespielt, wobei mir leider aufgefallen ist, dass die Dokumentation ein bisschen wirr ist. Ich werde mich aber auf jeden Fal noch weiter mit `Font Custom` beschäftigen und vielleicht gibt es ja noch Stoff für einen weiteren Blog Post.

 [1]: http://elementaryos.org
 [2]: http://fontcustom.com
 [3]: http://icomoon.io
 [4]: http://hannenz.de/das-gute-alte-makefile/
 [5]: http://www.freetype.org/ttfautohint/
 [6]: http://leonard.io/blog/2012/05/installing-ruby-1-9-3-on-ubuntu-12-04-precise-pengolin
