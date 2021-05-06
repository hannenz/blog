project=hannenz
project_dir:=/home/hannenz/hannenz.de

build: css/main.css blog

clean:
	rm -rf build/*

rebuild: clean build 


blogfiles:=$(wildcard posts/*.md)
blog: $(blogfiles)
	jekyll build



# SASS > CSS

css_src_files:=$(shell find _sass/ -type f -iname '*.scss')
css/main.css: $(css_src_files)
	mkdir -p css
	sass _sass/main.scss > $@

# Javascript

# jsfiles=$(shell find src/js/ -type f -name '*.js')
# js/main.js: $(jsfiles)
# 	mkdir -p build/js
#
# 	cat $(jsfiles) | yui-compressor --type js > $@

# SVG

# svgfiles=$(shell find src/svg/ -type f -name '*.svg')
# build/svg/symbol-defs.svg: $(svgfiles)
# 	svgmerge $^ | svgo -- - > $@
#
	
# Copy files directly
copy: $(COPYDIRS)
$(COPYDIRS):
	mkdir -p build
	rsync -rupE src/$@ build
	cp src/index.html build/index.html

deploy:
	rsync -ae ssh $(project_dir)/_site/ hannenz.de:/www/blog/


.PHONY: frontend clean rebuild copy $(COPYDIRS) deploy
