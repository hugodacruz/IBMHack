#!/bin/csh
# C-shell script pulls the html source from https://products.coastalscience.noaa.gov via curl 
# and filters out all the files containing the string "swfl.filt.tif" and sends the output to curlHAB.out

echo "==>Fetching HTML page source from https://products.coastalscience.noaa.gov using curl"

/usr/bin/curl "https://products.coastalscience.noaa.gov/habs_explorer/index.php?path=ajZiOVoxaHZNdE5nNytEb3RZdU5iWGNKSlhTQmVYUGUrb0piaTB5QnhOMXhuenIxN1FQU2orR0sxbkNwejhMaQ==&uri=VWtuM1UzbVNVN0RsZzJMeTJvNlNpM29OalF0WTFQQjVZVnpuS3o5bnh1Ym0vYWhtWEh4ck1hREVUamE4SDZ0M2tsd1M1OWg3UDJ0djIrNEkvbXliRUVkQkpRdFJDdjFkbTRoaUQ2L3J0UmpKYzNzMVVkc2ZCKy9nREM1R2FTcFU=&type=bllEUXA3TmhSK21RVDlqbFYxMmEwdz09" > curlHAB.out

echo "==>Processing html page source from https://products.coastalscience.noaa.gov for URLs"

cat curlHAB.out | grep "swfl.filt.tif" | grep "^<div class" | grep "coastalscience.noaa" | sed 's/<a href=/\n/g' | sed 's/ title=/\n/g' | grep "^'https" > HAB_IMGUrls.out

echo "==>Processing html page source from https://products.coastalscience.noaa.gov for image names"

cat curlHAB.out | grep "swfl.filt.tif" | sed "s/sentinel/\nsentinel/" | sed "s/\.tif/\.tif\n/" | grep "^sentinel" > HAB_IMGNames.out

echo "==>paste HAB_IMGNames.out with HAB_IMGUrls.out"

paste -d " " HAB_IMGNames.out HAB_IMGUrls.out > HAB_IMG_Name_URL.out
paste -d " " HAB_IMGUrls.out HAB_IMGNames.out > HAB_IMG_URL_Names.out

wc -l curlHAB.out
wc -l HAB_IMGUrls.out
wc -l HAB_IMGNames.out
wc -l HAB_IMG_Name_URL.out
wc -l HAB_IMG_URL_Names.out

echo "^^^ this many lines are contained in the output files ^^^"

echo "==> Creating image pull commands source file"

cat HAB_IMG_URL_Names.out | awk '{printf("curl %s -o %s\n", $1, $2)}' > HAB_images_curl.cmd

echo "==>Done processing Southwest Florida Filtered .tiff files"
