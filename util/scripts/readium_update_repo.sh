#!/bin/sh
#---------------------------------------------------
# This script is configured to update the current 
# Readium repo and update all the submodules
# @rkwright, July 2016
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

function update_repo {
    printg "Updating branch '$BRANCH' in repo '$REPO'"
   
 	echo_pwd
 	git checkout $BRANCH

    init_subrepo
}

function init_subrepo {
  
    printg "Initializing submodules to branch '$BRANCH'"

    git submodule update --init --recursive
    git submodule foreach --recursive "git checkout $BRANCH"

   printg "Completed updating submodules in branch '$BRANCH'"
}
#-------------------------------------------------------

if [ $# -lt 1 ]
  then
    printr "No branch tag supplied!  Exiting..."
    printr "Usage: ./readium_update_repo.sh <branch>"
    printr "To update master: ./readium_update_repo.sh  master"
    exit 1
fi

# save the argument - the branch name
BRANCH=$1

# save the original folder
ROOT_PWD=$(pwd)
printg "Root folder = $ROOT_PWD" 

# now update the repo
update_repo

printg "-------- Update of branch '$BRANCH' complete -----------"
