#!/bin/sh
#---------------------------------------------------
# This script is just to initialize the new 
# repo/sandbox
# @rkwright, August 2015
#---------------------------------------------------
# make sure the supplied a version
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
#---------------------------------------------------
if [ $# -eq 0 ]
  then
    printr "No branch tag supplied!  Exiting..."
    printr "Usage: sandbox_init.sh <branch>"
    exit 1
fi

# save the argument - the branch name
BRANCH=$1
printg "Initializing sandbox to branch $BRANCH"

git submodule update --init --recursive
git submodule foreach --recursive "git checkout $BRANCH"
