#!/bin/bash

range=( "$1" "$2" )
if [ -z "$range" ] || [ $2 -gt 20 ] || [ $2 -lt $1 ]; then
	printf "Usage: xkcd_downloader start_range end_range range,\ni.e. end_range - start_range,\ncannot be greater than 20 start_range cannot be after end_range\n"
	exit 1
fi

$(mkdir xkcd_comics)
grab=($(curl https://xkcd.com/[$1-$2]/ | grep -Po '(?<=">)https://imgs.*.jpg'))

for i in ${grab[@]}; do
  get=$(wget -P ./xkcd_comics "$i")
done

$(tar -cvf xkcd_comics.tar ./xkcd_comics)
$(rm -rf xkcd_comics)
 


