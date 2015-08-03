#!/bin/sh
#---------------------------------------------------
# This script is configured to clone each of the five 
# main Readium repos and their submodules
# It sets each repo and submodule to the $BRANCH branch
# At completion it fetches the git hash for each submodule
# @rkwright, February 2015
#---------------------------------------------------
# make sure the supplied a version
red='\033[1;31m'
green='\033[0;32m'
NC='\033[00m' # no color
if [ $# -eq 0 ]
  then
    echo "${red}No target EPUB supplied!  Exiting...${NC}"
    echo "Usage: ./epubcheck.sh <target-epub>"
    exit 1
fi

# save the argument - the branch name
TARGET=$1
echo "${green}Checking EPUB '$TARGET' against epubcheck 4.0.0.${NC}"

java -cp /Users/rkwright/Documents/github/readium-test-files/util/scripts/epubcheck/lib  -jar /Users/rkwright/Documents/github/readium-test-files/util/scripts/epubcheck/epubcheck.4.0.0.jar $TARGET