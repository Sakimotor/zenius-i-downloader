#!/bin/bash
if  [ $# -eq 0 ]
then
	echo "Input the pack id (contained in the URL as the categoryid, example : https://zenius-i-vanisher.com/v5.2/viewsimfilecategory.php?categoryid=34)";
	read id;
else
	id=$1;
fi
	mkdir -p ZeniusPacks;
	cd ZeniusPacks;

	title=$(curl https://zenius-i-vanisher.com/v5.2/viewsimfilecategory.php?categoryid=$id | grep "<h1>" | (sed -e 's/<h1>//' -e 's/<\/h1>//'));
	mkdir -p "$title";
	cd "$title";
	banner=$(curl https://zenius-i-vanisher.com/v5.2/viewsimfilecategory.php?categoryid=$id | grep "class=\"centre\".*img src=" | sed -e 's/^.*src=\"//' -e 's/png.*/png/' -e 's/\.\./https:\/\/zenius-i-vanisher.com/');
	wget --output-document=banner.png "$banner";


	curl https://zenius-i-vanisher.com/v5.2/viewsimfilecategory.php?categoryid=$id |      	
	grep -o "<a id=\"sim[0-9]*\"" | 
	sed  -e 's/<a id=\"sim//' -e 's/\"//' -e 's/^/https\:\/\/zenius\-i\-vanisher\.com\/v5\.2\/download\.php\?type\=ddrsimfilecustom\&simfileid\=/' -e 's/$/.zip/' |
	xargs -I '{}' wget -nc '{}';

	curl https://zenius-i-vanisher.com/v5.2/viewsimfilecategory.php?categoryid=$id |      	
	grep -o "<a id=\"sim[0-9]*\"" | 
	sed  -e 's/<a id=\"sim//' -e 's/\"//' -e 's/^/https\:\/\/zenius\-i\-vanisher\.com\/v5\.2\/download\.php\?type\=ddrsimfile\&simfileid\=/' -e 's/$/.zip/' |
	xargs -I '{}' wget -nc '{}';
	find . -type 'f' -size -5k -delete;
    
	dir=$(pwd);
    echo "Your files have been downloaded to $dir";   	
	
