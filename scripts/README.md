---------------------------------------------
## Commons
---------------------------------------------
### download.sh
#### downloadLogs

download application logs and remove data that is not on input time range

Parameters

1. alias for pool name
2. pool size
3. log path
4. log gz path
5. log pattern
	* #FILE# -> placeholder for filename
	* #DATE# -> placeholder for input date
	* #VOL# -> placeholder for log gz path
	* #VAR# -> placeholder for log path
	* #TIMELOG# -> placeholder for input hour
6. log name

Eg.
```sh
downloadLogs prod-sellerapi-orders 3 /var/log/sellerapi /vol/log_gz/napsao-nix-checkout-sellerapi "#VAR#/#FILE#-#TIMELOG#.log #VAR#/#FILE#-#TIMELOG#.log.gz #VOL#/#DATE#/#FILE#-#TIMELOG#.log.gz" "access requests redis metrics"
```

---------------------------------------------
### plots.sh

---------------------------------------------

---------------------------------------------
### confluence.sh

---------------------------------------------
#### confluenceUploadImage

upload image to confluence page id

Parameters

1. filename

Eg.
```sh
confluenceUploadImage test.png
```

#### confluenceUpdateImage

find image on confluence and update it

Parameters

1. filename

Eg.
```sh
confluenceUpdateImage test.png
```
#### confluenceImageId

finds image id on confluence

Parameters

1. filename

Eg.
```sh
confluenceImageId test.png
```

---------------------------------------------