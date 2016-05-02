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
curl --user "$USER:$PASS" --include --request POST --data '{"name":"priority:High","color":"ff7878"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"priority:Medium","color":"ffb4b4"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"priority:Low","color":"ffd0d0"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"priority:NeverFix","color":"fff2cc"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"type:Bug","color":"ffb4b4"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"type:Enhancement","color":"93c47d"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"type:Question","color":"b4a7d6"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"type:Discussion","color":"6fa8dc"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"type:Request","color":"c27ba0"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"type:Task","color":"ffd966"}' "https://api.github.com/repos/$REPO/labels"
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
curl --user "$USER:$PASS" --include --request POST --data '{"name":"status:Reproducible","color":"cfe2f3"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"status:NotReproducible","color":"cfe2f3"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"status:Stale","color":"cfe2f3"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"status:Flaky","color":"cfe2f3"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"status:Blocked","color":"cfe2f3"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"status:NeedMoreInfo","color":"cfe2f3"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"status:Duplicate","color":"cfe2f3"}' "https://api.github.com/repos/$REPO/labels"
