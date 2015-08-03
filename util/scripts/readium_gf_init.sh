#!/bin/sh
#---------------------------------------------------
# This script performs the git-flow "init" process
# on each of the five main Readium repos and their 
# submodules
# @rkwright, February 2015
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
	printf %s "$1$2"
	printf "${NC}\n"
}

if [ $# -eq 0 ]
  then
    printr "No suffix supplied!  Exiting..."
    printr "Usage: ./readium_start.sh <version-tag>"
    exit 1
fi

# save the argument - the suffix, if any
SUFFIX=$1

# save the original folder
ROOT_PWD=$(pwd)

printg "Root folder = $ROOT_PWD"

# start the process 
printg "Initializing release $VERSION"

# init each repo, starting with Android
printg "Initializing SDKLauncher-Android --------"
cd $ROOT_PWD/SDKLauncher-Android$SUFFIX
echo_pwd
git flow init -fd

# need to init each of the submodules too, but only in one main repo
printg "Initializing readium-sdk --------"
cd readium-sdk
echo_pwd
git flow init -fd

printg "Initializing readium-shared-js --------"
cd ../readium-shared-js
echo_pwd
git flow init -fd

printg "Initializing SDKLauncher-iOS --------"
cd $ROOT_PWD/SDKLauncher-iOS$SUFFIX
echo_pwd
git flow init -fd

printg "Initializing SDKLauncher-OSX --------"
cd $ROOT_PWD/SDKLauncher-OSX$SUFFIX
echo_pwd
git flow init -fd

printg "Initializing readium-js-viewer --------"
cd $ROOT_PWD/readium-js-viewer$SUFFIX
echo_pwd
git flow init -fd

printg "Initializing readium-js --------"
cd readium-js
echo_pwd
git flow init -fd

printg "-------- git-flow init of release/$VERSION complete -----------"