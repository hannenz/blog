project=hannenz
project_dir:=/home/hannenz/hannenz.de
DIST:=./dist
JEKYLL:=/usr/bin/jekyll


.PHONY: clean blog $(DIST)/js/vendor $(DIST)/css/vendor fonts deploy

build: clean $(DIST)/css/main.css $(DIST)/js/main.js $(DIST)/css/vendor $(DIST)/js/vendor fonts blog

fe: $(DIST)/css/main.css $(DIST)/js/main.js


clean:
	rm -rf $(DIST)/*



blogfiles:=$(wildcard posts/*.md)
blog: $(blogfiles) fe
	$(JEKYLL) build


# SASS > CSS
css_src_files:=$(shell find src/css/ -type f -iname '*.scss')
$(DIST)/css/main.css: $(css_src_files)
	mkdir -p $(DIST)/css
	sass --style compressed src/css/main.scss > $@


# Javascript
js_src_files:=\
	src/js/main.js\
	src/js/test.js
$(DIST)/js/main.js: src/js/main.js src/js/test.js
	mkdir -p $(DIST)/js
	cat $^ | terser --compress --mangle > $@


$(DIST)/js/gallery.js: src/js/gallery.js
	mkdir -p $(DIST)/js
	terser --compress --mangle -- $^ > $@


js_vendor_files=$(shell find src/js/vendor/ -type f -name '*.js')
$(DIST)/js/vendor: $(js_vendor_files)
	mkdir -p $@
	cp -ra $^ $@/


css_vendor_files=$(shell find src/css/vendor/ -type f -name '*.css')
$(DIST)/css/vendor: $(css_vendor_files)
	mkdir -p $@
	cp -ra $^ $@/



# SVG
# svgfiles=$(shell find src/svg/ -type f -name '*.svg')
# build/svg/symbol-defs.svg: $(svgfiles)
# 	svgmerge $^ | svgo -- - > $@
#

font_files:=$(shell find src/fonts/ -type f)
fonts: $(font_files)
	mkdir -p $(DIST)/fonts
	rsync -a src/fonts/ $(DIST)/fonts/


deploy: build
	rsync --delete -ave ssh $(project_dir)/_site/ hannenz.de:/www/blog/
	ssh hannenz.de "cache-purge hannenz.de && cache-purge blog.hannenz.de"

watch:
	browser-sync start --proxy "https://hannenz.hannenz.localhost" --files "_site/dist/*" --files "_site/**/*.html"

