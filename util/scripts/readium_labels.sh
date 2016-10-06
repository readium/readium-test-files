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

# Create labels
#curl --user "$USER:$PASS" --data '{"name":"priority:Zot","color":"ffff00"}' "https://api.github.com/repos/$REPO/labels"
#exit 0

curl --user "$USER:$PASS" --include --request POST --data '{"name":"priority:Blocking","color":"ff0000"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"priority:High","color":"ff7878"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"priority:Medium","color":"ffb4b4"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"priority:Low","color":"ffd0d0"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"priority:NeverFix","color":"fff2cc"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"priority:NA","color":"fff2cc"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"type:Bug","color":"674ea7"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"type:Enhancement","color":"d9d2e9"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"type:Feature","color":"d9d2e9"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"type:Question","color":"d9d2e9"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"type:Discussion","color":"d9d2e9"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"type:Request","color":"d9d2e9"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"type:Task","color":"d9d2e9"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"type:Refactor","color":"d9d2e9"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Packaging","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Planning","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Encryption","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Metadata","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Navigation","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:CFI","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Content","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:EPUB","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:HTML","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Image","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:XML","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:C++","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:JavaScript","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Java","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:SVG","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:CSS","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:MathML","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Highlight","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Search","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Resources","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Layout","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Memory","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Rendering","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Plugins","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:UX","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Fonts","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Multimedia","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:MediaOverlay","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:QE","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:i18n","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:A11y","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:DRM","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Builds","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Network","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Performance","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Security","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Documentation","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Legal","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"func:Zip","color":"b6d7a8"}' "https://api.github.com/repos/$REPO/labels"
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
curl --user "$USER:$PASS" --include --request POST --data '{"name":"status:WIP","color":"cfe2f3"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"status:Duplicate","color":"cfe2f3"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"status:NotThisProduct","color":"cfe2f3"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"status:Proposal","color":"00cc00"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"status:Accepted","color":"00cc00"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"status:Rejected","color":"ff0000"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"status:FinalReview","color":"00cc00"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"browser:CloudReader","color":"d0e0e3"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"browser:Chrome","color":"d0e0e3"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"browser:Firefox","color":"d0e0e3"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"browser:Safari","color":"d0e0e3"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"browser:Opera","color":"d0e0e3"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"browser:IE","color":"d0e0e3"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"browser:Edge","color":"d0e0e3"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"difficulty:Guru","color":"f9cb9c"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"difficulty:Dev","color":"f9cb9c"}' "https://api.github.com/repos/$REPO/labels"
curl --user "$USER:$PASS" --include --request POST --data '{"name":"difficulty:Noob","color":"f9cb9c"}' "https://api.github.com/repos/$REPO/labels"
