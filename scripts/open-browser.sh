#!/bin/bash
regex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
link=`xsel -o | sed "s/^[ \t]*//"`
search="http://www.google.com/search?q="

if [[ $link =~ $regex ]]; then
    WEB_BROWSER "$link"
else
    WEB_BROWSER "${search}${link}"
fi
