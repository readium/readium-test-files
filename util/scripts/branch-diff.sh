#!/bin/sh
#---------------------------------------------------
# This script diffs two specified branches and 
# pretty-prints them.
# @rkwright, May 2015
#---------------------------------------------------
# make sure the user supplied the two branches
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

if [ $# -eq 0 ]
  then
    printr "No branch tags supplied!  Exiting..."
    printr "Usage: ./branch-diff.sh <branch1> <branch2>"
    exit 1
fi


# save the argument - the branch name
BRANCH1=$1
BRANCH2=$2
printg "Diffing branch '$BRANCH1' against '$BRANCH2'."
git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative $BRANCH1..$BRANCH2
printg "Diffing branch '$BRANCH2' against '$BRANCH1'."
git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative $BRANCH2..$BRANCH1
printg "Diff complete"
