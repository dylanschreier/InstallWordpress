#!/bin/bash

getLastestVersionUrl() {
	echo "Checking lastest wordpress version..."
	wget https://fr.wordpress.org/txt-download/ -O wordpressDownload.html -o /dev/null
	WORDPRESS_URL=$(grep -o "download-button.*"\S*" " wordpressDownload.html | grep -o "href=\S*")
	WORDPRESS_URL=${WORDPRESS_URL:6:-1}
	WORDPRESS_VERSION=$(echo "$WORDPRESS_URL" | grep -o "[[:digit:]]*\.[[:digit:]]")
}

installWordpress() {
	echo "Downloading Wordpress v$WORDPRESS_VERSION..."
	wget $1 -O wordpress.zip -o /dev/null
}

unzipWordpress() {
	echo "Unzipping Wordpress..."
	unzip wordpress.zip -d wordpressTemp >> /dev/null
	mv wordpressTemp/wordpress $1
}

clean() {
	rm -rf wordpressDownload.html wordpress.zip wordpressTemp/
}

if [ $# -ge 1 ]; then
	echo "----------------- $(date)"
	echo "------------- WORDPRESS INSTALLATION"
	WORDPRESS_URL=""
	WORDPRESS_VERSION=""
	getLastestVersionUrl
	installWordpress $WORDPRESS_URL
	unzipWordpress $1
	clean
	echo "------------- DONE"
fi
