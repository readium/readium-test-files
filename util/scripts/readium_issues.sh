#!/bin/sh
#---------------------------------------------------
# This script is for setting all the issues for a 
# repo (the first argument). Second arg is the 
# password.  Default user is rkwright.
# Subsequent arguments are the labels, e.g. 
# bug blocking etc.  
# @rkwright, May 2016
#---------------------------------------------------

red='\033[1;31m'
green='\033[0;32m'
NC='\033[00m' # no color

function echo_pwd {
    printf "${green}"
    pwd
    printf "${NC}"
}

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

if [ $# -lt 1 ]
  then
    printr "No repo or password supplied!  Exiting..."
    printr "Usage: readium_label.sh <repo-name> <password>"
    echo "${red} repo is the full github name, e.g. readium/readium-shared-js${NC}"
    exit 1
fi

if [ $# -lt 2 ]
  then
    printr "No password supplied!  Exiting..."
    printr "Usage: readium_label.sh <repo-name> <password>"
    echo "${red} repo is the full github name, e.g. readium/readium-shared-js${NC}"
    exit 1
fi

# save the arguments, repo and user's password
REPO=$1
PASS=$2

USER=rkwright

STATE="all"

# read the labels now and concatenate them into the label string
LABELS=""
args=("$@")

for ((i=2; i<${#args[@]}; i++)); 
do
    echo "$i  ${args[i]}"
    LABELS=${LABELS}","${args[i]}
done

#for var in "$@"
#do
 #   echo "$var"
  #  LABELS=LABELS"$var"
#done

echo $LABELS
LABELS="priority:Question"

#exit 0


curl --user "$USER:$PASS" https://api.github.com/repos/$REPO/issues\?label:$LABELS

 
 
# Delete default labels
# curl --user "$USER:$PASS" --include --request DELETE "https://api.github.com/repos/$USER/$REPO/labels/bug"

# Create labels
#curl --user "$USER:$PASS" --data '{"name":"priority:Zot","color":"ffff00"}' "https://api.github.com/repos/$REPO/labels"
#exit 0

# curl --user "$USER:$PASS" --include --request POST --data '{"name":"priority:Blocking","color":"ff0000"}' "https://api.github.com/repos/$REPO/labels"
