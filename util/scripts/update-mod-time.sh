#!/bin/sh
#---------------------------------------------------
# This script is intended to find the dcterms:modified
# line in a OPF file and update the actual date/time
# with the current time, in the correct format
#
# The approach is 
#     - find the right line in the file
#     - find the > and < delimiting the time
#     - generate the current time string in DC format
#     - replace the old time with the new string 
#
# @rkwright, February 2016
#---------------------------------------------------

red='\033[1;31m'
green='\033[0;32m'
NC='\033[00m' # no color

function printg {
	printf "${green}"
	printf %s "$1"
	printf "${NC}\n"
}

function printr {
	printf "${red}"
	printf %s "$1"
	printf "${NC}\n"
}

#-------------------------------------------------------

if [ $# -ne 1 ]
  then
    printr "No OPF target specified! Exiting..."
    printr "Usage: update-mod-time.sh <opf-package-name>"
    exit 1
fi

# save the argument - the branch name
OPFNAME=$1
printg "Updating file $OPFNAME"

# save the original folder
ROOT_PWD=$(pwd)

# backup the original file
cp $OPFNAME "$OPFNAME.backup"

# find the correct line in the specified file
grep "dcterms:modified" $OPFNAME 
