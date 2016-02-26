#!/bin/sh
#---------------------------------------------------
# This script checks the supplied EPUB target with
# epubcheck.
# If a second string is supplied the output of epubcheck 
# is redirected into that file
#
# @rkwright, February 2015
#---------------------------------------------------
# make sure the supplied a version
red='\033[1;31m'
green='\033[0;32m'
NC='\033[00m' # no color

EPUBCHECKLIB='/Users/rkwright/Documents/github/readium-test-files/util/scripts/epubcheck/lib'
EPUBCHECKJAR='/Users/rkwright/Documents/github/readium-test-files/util/scripts/epubcheck/epubcheck.4.0.1.jar'

if [ $# -eq 0 ]
  then
    echo "${red}No target EPUB supplied!  Exiting...${NC}"
    echo "Usage: ./epubcheck.sh <target-epub>"
    exit 1
fi

# save the argument - the EPUB name
TARGET=$1
echo "${green}Checking EPUB '$TARGET' against epubcheck 4.0.0.${NC}"

# see if the user asked to pipe the output to a file
if [ $# -eq 2 ]
  then
   java -cp $EPUBCHECKLIB -jar $EPUBCHECKJAR $TARGET > $2 2>&1
else
   java -cp $EPUBCHECKLIB -jar $EPUBCHECKJAR $TARGET
fi