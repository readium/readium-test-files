#!/bin/sh
#---------------------------------------------------
# This script fetches the issues from the specified
# repo at github.  If state is not specified it 
# fetches only the open issues.  If no filename is 
# specified, then it is spewed out onto the console
#
# @rkwright, March 2015
#---------------------------------------------------
red='\033[1;31m'
green='\033[0;32m'
NC='\033[00m' # no color

if [ $# -eq 0 ]
  then
    echo "${red}No repo supplied!  Exiting...${NC}"
    echo "${red}Usage: ./get-issues.sh repo <filename> <state>${NC}"
    echo "${red} repo is the full github name, e.g. readium/readium-shared-js${NC}"
    echo "${red} where state=all|closed|open${NC}"
    exit 1
fi

# save the argument - the REPO name
REPO=$1

STATE="all"
if [ $# -gt 2 ]
then
    STATE=$3
fi
# remove the old file, if any
if [ $# -ge 2 ]
then
    rm -f $2
fi

# make 10 passes of 100 each - should be enough
for i in `seq 1 10`;
do
    # see if the user asked to pipe the output to a file
    if [ $# -ge 2 ]
    then
        curl https://api.github.com/repos/$REPO/issues\?state\=$STATE\&filter\=all\&page=$i\&per_page\=100 >> $2 
    else
        curl https://api.github.com/repos/$REPO/issues\?state\=$STATE
    fi
done