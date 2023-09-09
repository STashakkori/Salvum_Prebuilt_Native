#!/bin/bash

# Grab a fresh salvum
rm -rf "slm_repair"
mkdir "slm_repair"
tar -xzvf "slm.tgz" -C "slm_repair" --no-same-owner

# Repair all of salvum
if [ "$1" = "all" ];
then
	rm -rf "slm/ext" "slm/tst"
	cp -r "slm_repair/slm/ext" "slm/ext"
	cp -r "slm_repair/slm/tst" "slm/tst"
	rm -rf "slm_repair"
# Repair a single tool
else
	rm -rf "slm/ext/$1" "slm/tst/$1"
	cp -r "slm_repair/slm/ext/$1" "slm/ext/$1"
	cp -r "slm_repair/slm/tst/$1" "slm/tst/$1"
	rm -rf "slm_repair"
fi

