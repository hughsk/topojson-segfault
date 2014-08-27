TOPOJSON=node_modules/.bin/topojson

.PHONY: clean

clean:
	rm -rf node_modules
	rm countries.json; true
	rm countries.zip; true
	rm -rf countries; true

countries.zip:
	curl -L "https://github.com/nvkelso/natural-earth-vector/raw/master/zips/110m_cultural/ne_110m_admin_0_countries_lakes.zip" -o countries.zip

countries/: countries.zip
	unzip -od ./countries/ countries.zip

$(TOPOJSON):
	npm install

countries.json: countries/ $(TOPOJSON)
	$(TOPOJSON) \
		-o ./countries.json \
		--force-clockwise \
		--id-property iso_a2 \
		./countries/*.shp -p name
