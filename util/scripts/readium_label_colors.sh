#!/bin/sh
#---------------------------------------------------
# This script is for changing the color of the 
# specified labels for a repo
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

# Delete default labels
# curl --user "$USER:$PASS" --include --request DELETE "https://api.github.com/repos/$USER/$REPO/labels/bug"

# Change the labels' color
curl --user "$USER:$PASS" "https://api.github.com/repos/$REPO/labels/type:Bug" -X PATCH -d '{"name":"type:Bug","color":"f00000"}' 
curl --user "$USER:$PASS" "https://api.github.com/repos/$REPO/labels/type:Enhancement" -X PATCH -d '{"name":"type:Enhancement","color":"d9d2e9"}' 
curl --user "$USER:$PASS" "https://api.github.com/repos/$REPO/labels/type:Feature" -X PATCH -d '{"name":"type:Feature","color":"d9d2e9"}' 
curl --user "$USER:$PASS" "https://api.github.com/repos/$REPO/labels/type:Question" -X PATCH -d '{"name":"type:Question","color":"d9d2e9"}' 
curl --user "$USER:$PASS" "https://api.github.com/repos/$REPO/labels/type:Discussion" -X PATCH -d '{"name":"type:Discussion","color":"d9d2e9"}' 
curl --user "$USER:$PASS" "https://api.github.com/repos/$REPO/labels/type:Request" -X PATCH -d '{"name":"type:Request","color":"d9d2e9"}' 
curl --user "$USER:$PASS" "https://api.github.com/repos/$REPO/labels/type:Task" -X PATCH -d '{"name":"type:Task","color":"d9d2e9"}' 
