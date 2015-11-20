---
title: Textinhalte ausblenden mit CSS
author: hannenz
layout: post
permalink: /textinhalte-ausblenden-mit-css/
categories:
  - Blog
tags:
  - css
  - snippet
---
<p class="post-excerpt">
Ein Klassiker im Webworker-Alltag ist es, Textinhalte durch Grafiken zu ersetzen. Das kann man auf die unterschiedlicheste Art und Weise lösen, hier ist die beste.
</p>

From: <http://tympanus.net/codrops/2012/10/25/kick-start-your-project-a-collection-of-handy-css-snippets/>

Eine schöne Alternative zum Ausblenden von Textinhalten (zum Beispiel, um Text durch Bilder zu ersetzen, Logo im H1 usw..)

Anstatt

<pre><code class="language-css">
    .ir {
        text-indent:-9999em;
        overflow:hidden;
    }
</code></pre>
    

können wir schreiben:

<pre><code class="language-css">
    .ir {
        text-indent: 100%;
        white-space: nowrap;
        overflow: hidden;
    }
</code></pre>
    

was nicht nur weniger nach &#8220;Hack&#8221; aussieht sondern in der Tat auch performanter ist; und irgendwie ist es doch natürlicher und trotz seiner einen Zeile mehr auch — eleganter, oder?