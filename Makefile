clean:
	rm -rf build dist
build:
	mkdir -p build
	mkdir -p dist
	pip install -r requirements.txt -t build/
	cp -R src/consumer-report build/
zip:build
	cd build && zip -r9 ../dist/consumer-reports-lambda.zip ./*
