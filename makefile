pages: build
	mkdir tempdir
	cp -r build/web/* tempdir
	rm -rf build
	git checkout gh-pages
	cp -r tempdir/* .
	rm -rf tempdir
	git add -A
	git commit -m "Publishing gh-pages"
	git push origin gh-pages
	

build: clean
	pub build

clean:
	rm -rf build
	rm -rf tempdir
