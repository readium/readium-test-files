#!/bin/sh
#---------------------------------------------------
# This script is for setting all the labels for a 
# repo (the argument)
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
    printr "Usage: ./readium_label.sh <repo-name>"
    echo "${red} repo is the full github name, e.g. readium/readium-shared-js${NC}"
    exit 1
fi

# save the arguments, repo and user's password
REPO=$1
PASS=$2

USER=rkwright

# Delete default labels
# curl --user "$USER:$PASS" --include --request DELETE "https://api.github.com/repos/$USER/$REPO/labels/bug"

# Create labels
curl --user "$USER:$PASS" --include --request POST --data '{"name":"priority:Blocking","color":"ff0000"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"priority:High","color":"b6420"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"priority:Medium","color":"fbca04"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"priority:Low","color":"bfe5bf"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"priority:NeverFix","color":"bfdadc"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"priority:Unknown","color":"ff0000"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"type:Bug","color":"f7c6c7"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"type:Enhancement","color":"24ccc0"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"type:Question","color":"bb81cc"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"type:Discussion","color":"a96dcc"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"type:Request","color":"cccb7c"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"type:Task","color":"ccba20"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"type:None","color":"c6ccbe"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Packaging","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Encryption","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Metadata","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Navigation","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:CFI","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Resources","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Layout","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Rendering","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:UX","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Fonts","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Multimedia","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:QE","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:i18n","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:A11y","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Security","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Documentation","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Legal","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"platform:iOS","color":"d9d9d9"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"platform:OSX","color":"d9d9d9"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"platform:Android","color":"d9d9d9"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"platform:Windows","color":"d9d9d9"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"platform:Hybrid","color":"d9d9d9"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"platform:Linux","color":"d9d9d9"}' "https://api.github.com/repos/$REPO/labels"
