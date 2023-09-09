#!/bin/bash

cp /home/shared/slm/target/release/salvum .

# Inner tar of salvum
sudo tar -czvf slm.tgz --exclude=ext/TODO --exclude=ext/selinux --exclude=ext/wrlinux --exclude=tst/selinux --exclude=tst/wrlinux cfg dep ext lic out tst salvum 
gpg -o slm.enc -c --no-symkey-cache slm.tgz

# Flagship with the scripts
sudo tar -czvf fld.tgz slm.enc repair_salvum.sh install_salvum.sh

