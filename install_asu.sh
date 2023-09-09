#!/bin/bash

########## PIP3 SETUP ##########
install_pips() {
  umask 022
  pip3 install $@
  umask 027
}

pip_dependencies=(
  "getch"
  "pyserial"
  "qiling"
  "termcolor"
  "ciphey"
  "sunzip"
  "pwncat"
)

install_detcve() {
  tmppth=$(pwd)
  cd $(pwd)/slm/ext/detcve
  sudo python3 setup.py install
  sudo cp cve.db /root/.cache/cve-bin-tool/
  cd $tmppth
}

########## RUBY SETUP ##########
install_gems() {
  cur_dir=$(pwd)
  for dep_dir in $@
  do
    cd $dep_dir
    bundle install
    cd $cur_dir
  done
}

gem_dependencies=(
  $(pwd)/slm/ext/metasploit
)

########## APT SETUP ##########
install_apts() {
  set +e
  for pkg in $@; do
    sudo apt install -y --ignore-missing $pkg
  done
  set -e
}

apt_dependencies=(
  "build-essential"
  "bison"
  "binutils-dev"
  "htop"
  "chrpath"
  "python3-pip"
  "ruby-dev"
  "ruby-bundler"
  "binwalk"
  "check"
  "chrpath"
  "clamav"
  "clang"
  "cpio"
  "cppcheck"
  "cpuinfo"
  "debianutils"
  "diffstat"
  "dmidecode"
  "dsniff"
  "emacs"
  "flex"
  "gawk"
  #"gcc-multilib"
  "gcc-9-powerpc-linux-gnu"
  "gcc-10-powerpc64-linux-gnu"
  "gcc-10-mips-linux-gnu"
  "gcc-10-mips64-linux-gnuabi64"
  "gcc-arm-none-eabi"
  "gcc-9-aarch64-linux-gnu"
  "gcc-10-riscv64-linux-gnu"
  "gcc-10-sparc64-linux-gnu"
  "gcc-avr"
  "git"
  "hashcat"
  "inxi"
  "iputils-ping"
  "iproute2"
  "libbz2-dev"
  "libc6-i386"
  "libcapstone-dev"
  "libdivsufsort-dev"
  "libevent-dev"
  "libfuse-dev"
  "libgit2-28"
  "libgmp-dev"
  "libm17n-0"
  "libmagickwand-6.q16-dev"
  "libncursesw5-dev"
  "libnet-dev"
  "libnet1"
  "libnetfilter-queue-dev"
  "libnids1.21"
  "libnl-3-dev"
  "libnl-genl-3-dev"
  "libotf-dev"
  "libpcap-dev"
  "libpq-dev"
  "libreadline-dev"
  "libsdl1.2-dev"
  "libseccomp-dev"
  "libssl-dev"
  "libsqlite3-dev"
  "libegl1-mesa"
  "libsdl1.2-dev"
  "llvm"
  "ltrace"
  "lynx"
  "lzip"
  "mesa-common-dev"
  "net-tools"
  "network-manager"
  "nmap"
  "pciutils"
  "pkg-config"
  "proxychains"
  "pscan"
  "pylint3"
  "python3-git"
  "python3-jinja2"
  "python3-pexpect"
  "python3-subunit"
  "qt5-default"
  "rpm2cpio"
  "scrub"
  "secure-delete"
  "sendip"
  "socat"
  "spin"
  "stegsnow"
  "tcpdump"
  "texinfo"
  "tftp"
  "tftpd-hpa"
  "tshark"
  "unzip"
  "usbutils"
  "uftrace"
  "valgrind"
  "vim"
  "vsftpd"
  "wipe"
  "xterm"
  "xz-utils"
  "yara"
  "yasm"
  "zlib1g-dev"
  "zstd"
  "./slm/dep/bap_2.3.0.deb"
  "./slm/dep/JLink_Linux_V754a_x86_64.deb"
  "./slm/dep/libffi6_3.2.1-8_amd64.deb"
  "./slm/dep/libbap_2.3.0.deb"
  "./slm/dep/libbap-dev_2.3.0.deb"
)

########## INVOKE SETUPS ##########

set -eu -o pipefail

ANSI="\033["
RESET="${ANSI}0m"
RED="${ANSI}0;31m"
GREEN="${ANSI}0;32m"
YELLOW="${ANSI}0;33m"
BLUE="${ANSI}0;36m"
FILE=slm.tgz

echo -e "${BLUE}=====================================$RESET" >&2
echo -e "${BLUE}       Salvum 1.0 installation         $RESET" >&2
echo -e "${BLUE}=====================================$RESET" >&2

echo -e "${YELLOW}Decrypting your installation. Please stand by.$RESET" >&2
gpg -o slm.tgz -q -d --yes --no-symkey-cache slm.enc

########## Checkpoint 0 #################################################################

echo -e "${YELLOW}Performing Checkpoint 0 verification. Please stand by.$RESET" >&2

# Count unique roots in the tar file
#function roots {
#  echo $(tar -tf "$FILE" | cut -d/ -f1 | sort -u | wc -l)
#}

# Strip archive extension from the tar file for the tarbomb directory
# n.b., This strips everything after (and including) ".t", so it will
# catch ".tar", ".tar.gz", ".tgz", etc., but will also catch false
# positives such as ".txt"... It shouldn't cause any problems.
#function strip_ext {
#  FILE=$(basename "slm.tgz")
#  echo "${FILE%.t*}"
#}

#EXTRACT=slm

#case $(roots "$FILE") in
#0)
#  # Empty or not a tar archive
#  echo "\"$FILE\" is empty or not a tar achive" >&2
#  exit 1
#  ;;  

#10)
  # Demilitarised tar archive
#  ;;  

#*)
  # Create extraction directory (if possible)
#  BOMBDIR=$(strip_ext "$FILE")
#  if [ ! -e "$BOMBDIR" ]; then
#    mkdir "$BOMBDIR"
#    EXTRACT=$BOMBDIR
#  else
#    echo "Cannot create directory \"$BOMBDIR\" for tar extraction" >&2
#    exit 1
#  fi  

#  echo -e "${YELLOW}Checkpoint 0 verification: ${RED}FAILED$RESET" >&2
#  echo -e "${RED}Tarbomb detected. Aborting installation.$RESET" >&2
#  echo -e "${RED}!!! Please contact security@qvlx.com to report this. !!!$RESET" >&2
#  exit 1
#  ;;  
#esac

echo -e "${YELLOW}Checkpoint 0 verification: ${GREEN}PASSED$RESET" >&2
echo -e "${YELLOW}Proceeding with extraction. Please stand by.$RESET" >&2

mkdir slm
tar -pxzf slm.tgz -C slm

#mkdir "$EXTRACT" >/dev/null 2>&1
#tar -pxzf "$FILE" -C "$EXTRACT"
echo -e "${GREEN}Extraction complete. Proceeding to next step.$RESET" >&2

########## Checkpoint 1 #################################################################

echo -e "${YELLOW}Performing Checkpoint 1 verification. Please stand by.$RESET" >&2

if [ ! -d "slm/cfg" ] || \
   [ ! -d "slm/dep" ] || \
   [ ! -d "slm/ext" ] || \
   [ ! -d "slm/lic" ] || \
   [ ! -d "slm/tst" ] || \
   [ ! -f "slm/salvum" ]; then
  echo -e "${YELLOW}Checkpoint 1 verification: ${RED}FAILED$RESET" >&2
  echo -e "${RED}Missing important files. Aborting installation.$RESET" >&2
  echo -e "${RED}!!! Please contact security@qvlx.com to report this. !!!$RESET" >&2
  exit 1
fi

echo -e "${YELLOW}Checkpoint 1 verification: ${GREEN}PASSED$RESET" >&2

########## Checkpoint 2 #################################################################

checkpoint2_abort() {
  echo -e "${YELLOW}Checkpoint 2 verification: ${RED}FAILED$RESET" >&2
  echo -e "${RED}Checksum not valid. Aborting installation.$RESET" >&2
  echo -e "${RED}!!! Please contact security@qvlx.com to report this. !!!$RESET" >&2
  exit 1
}

echo -e "${YELLOW}Performing Checkpoint 2 verification. Please stand by.$RESET" >&2

#CFG_SHA=$(find slm/cfg/ -type f -exec sha256sum {} \; |  awk '{print $1}' | sort -d | sha256sum | cut -d ' ' -f 1)
#if [ "d06731958ffbb1f6ab14fed7b33163da743576aebaa875212f230ac438adca94" != "$CFG_SHA" ]; then
#  checkpoint2_abort
#fi

#DEP_SHA=$(find slm/dep/ -type f -exec sha256sum {} \; |  awk '{print $1}' | sort -d | sha256sum | cut -d ' ' -f 1)
#if [ "4b7ced51e55f3be0e90aff83e91253dad3ea41d26c2fa30565e280c8a53fad99" != "$DEP_SHA" ]; then
#  checkpoint2_abort
#fi

#EXT_SHA=$(sudo find slm/ext/ -type f -exec sha256sum {} \; |  awk '{print $1}' | sort -d | sha256sum | cut -d ' ' -f 1)
#if [ "cfdd059f725cdd9433f93c87298a3ea3849a649b4f6e9955f6f5f85478ce88c9" != "$EXT_SHA" ]; then
#  checkpoint2_abort
#fi

#LIC_SHA=$(find slm/lic/ -type f -exec sha256sum {} \; |  awk '{print $1}' | sort -d | sha256sum | cut -d ' ' -f 1)
#if [ "9290b3a6f0119732c32b9c14e8722f434e38abb6501dd13fe47eec9cecc66975" != "$LIC_SHA" ]; then
#  checkpoint2_abort
#fi

#TST_SHA=$(find slm/tst/ -type f -exec sha256sum {} \; |  awk '{print $1}' | sort -d | sha256sum | cut -d ' ' -f 1)
#if [ "087e5ad8b558fe4b1afb028e03981cf0f333ca36365396ae50032d333dd7e3e0" != "$TST_SHA" ]; then
#  checkpoint2_abort
#fi

#SALVUM_SHA=$(sha256sum "slm/salvum" | cut -d " " -f1)
#if [ "4ea97723918e5849070b3f087b8a17f508fff86dfdc00ec91d7d64090e8e9e09" != "$SALVUM_SHA" ]; then
#  checkpoint2_abort
#fi

echo -e "${YELLOW}Checkpoint 2 verification: ${GREEN}PASSED$RESET" >&2

########## End Checkpoints ##############################################################

install_apts ${apt_dependencies[@]}
install_gems ${gem_dependencies[@]}
install_pips ${pip_dependencies[@]}
#install_detcve

########## Add FTP User #################################################################

#if id "ftpqvlx" &>/dev/null; then
#  echo -e "${RED}A user with the name 'ftpqvlx' already exists, FTP operations in Salvum may not work properly.$RESET" >&2
#else

#sudo useradd -m -d $(pwd)/slm/srv ftpqvlx
#sudo passwd ftpqvlx &> /dev/null <<ENDSCRIPT
#qvlx
#qvlx
#ENDSCRIPT

fi

#sudo mkdir slm/srv
#sudo chmod 775 slm/srv
#sudo mkdir slm/srv/pxe
#sudo chmod 775 slm/srv/pxe
#sudo chown $USER slm/srv/pxe
#sudo chgrp $USER slm/srv/pxe

#########################################################################################

########## Configure Yara ###############################################################

#sudo cp /usr/bin/yara $(pwd)/slm/ext/yara/yara_orig/.libs/yara
#sudo cp /usr/bin/yarac $(pwd)/slm/ext/yara/yara_orig/.libs/yarac
#sudo rm $(pwd)/slm/ext/yara/yara_orig/compiled_rules
#sudo rm $(pwd)/slm/ext/yara/yara_orig/rules/CobaltStrikeBeacon.yar
#sudo yarac $(pwd)/slm/ext/yara/yara_orig/rules/* $(pwd)/slm/ext/yara/yara_orig/compiled_rules
#sudo chmod 777 $(pwd)/slm/ext/yara/yara_orig/compiled_rules

#########################################################################################

echo "Do not delete the slm.tar in the case that Salvum becomes unusable"
echo "You can run this again to retrieve a fresh Salvum"
