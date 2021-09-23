#!/bin/csh
# this C-shell script pulls the html source from https://products.coastalscience.noaa.gov via curl 
# and filters out all the files containing the string "swfl.filt.tif" and sends the output to curlHAB.out

echo "Processing html page at https://products.coastalscience.noaa.gov"

/usr/bin/curl "https://products.coastalscience.noaa.gov/habs_explorer/index.php?path=ajZiOVoxaHZNdE5nNytEb3RZdU5iWGNKSlhTQmVYUGUrb0piaTB5QnhOMXhuenIxN1FQU2orR0sxbkNwejhMaQ==&uri=VWtuM1UzbVNVN0RsZzJMeTJvNlNpM29OalF0WTFQQjVZVnpuS3o5bnh1Ym0vYWhtWEh4ck1hREVUamE4SDZ0M2tsd1M1OWg3UDJ0djIrNEkvbXliRUVkQkpRdFJDdjFkbTRoaUQ2L3J0UmpKYzNzMVVkc2ZCKy9nREM1R2FTcFU=&type=bllEUXA3TmhSK21RVDlqbFYxMmEwdz09" | grep "swfl.filt.tif" | grep "^<div class" | grep "coastalscience.noaa" | sed 's/<a href=/\n/g' | sed 's/ title=/\n/g' | grep "^'https" > curlHAB.out

echo "Filtered URLs for Southwest Florida Filtered .tiff files send to output file named curlHAB.out"
wc -l curlHAB.out
echo "^^^ this many lines are contained in the output file ^^^"
