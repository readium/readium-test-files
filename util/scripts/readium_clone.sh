#!/bin/sh
#---------------------------------------------------
# This script is configured to clone each of the five 
# main Readium repos and their submodules
# It sets each repo and submodule to the $BRANCH branch
# At completion it fetches the git hash for each submodule
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
	printf %s "$1"
	printf "${NC}\n"
}

function init_repo {
    rm -rf $2
    git clone --recursive $1 $2
    cd $2
	echo_pwd
    git flow init -fd
 	git checkout $BRANCH
    cd $ROOT_PWD
}

function init_subrepo {
    cd $1
    echo_pwd
    git flow init -fd
    git submodule init
    git submodule update
    git checkout $BRANCH
    cd $ROOT_PWD
}
#-------------------------------------------------------

if [ $# -eq 0 ]
  then
    printr "No branch tag supplied!  Exiting..."
    printr "Usage: ./readium_clone.sh <branch> [<repo-suffix>]"
    printr "To clone master: ./readium_clone.sh master [<repo-suffix>]"
    exit 1
fi

# save the argument - the branch name
BRANCH=$1
printg "Cloning from branch '$BRANCH' in each repo."

# see if the user supplied a suffix
SUFFIX=''
if [ $# -eq  2 ]
  then
    SUFFIX=$2
    printg "Appending sufffix '$SUFFIX' onto each app repo folder."
fi

# save the original folder
ROOT_PWD=$(pwd)
printg "Root folder = $ROOT_PWD" 

printg "Removing any pre-existing folders..."
# first get rid of the old repos, if any
rm -rf readium-js-viewer$SUFFIX
rm -rf SDKLauncher-Android$SUFFIX
rm -rf SDKLauncher-iOS$SUFFIX
rm -rf SDKLauncher-OSX$SUFFIX
# rm -rf SDKLauncher-Windows$SUFFIX

# now clone each repo then ensure the submodules are on the $BRANCH requested
# Note: git flow init won't work if the master branch doesn't exist locally so
# we have to clone the master then switch to $BRANCH rather than cloning directly 
# into only $BRANCH

printg "Cloning Android --------"
init_repo "https://github.com/readium/SDKLauncher-Android.git" "SDKLauncher-Android$SUFFIX"
init_subrepo "SDKLauncher-Android$SUFFIX/readium-sdk"
init_subrepo "SDKLauncher-Android$SUFFIX/readium-shared-js"
init_subrepo "SDKLauncher-Android$SUFFIX/readium-shared-js/readium-cfi-js"

printg "Cloning iOS --------"
init_repo "https://github.com/readium/SDKLauncher-iOS.git" "SDKLauncher-iOS$SUFFIX"
init_subrepo "SDKLauncher-iOS$SUFFIX/readium-sdk"
init_subrepo "SDKLauncher-iOS$SUFFIX/Resources/readium-shared-js"
init_subrepo "SDKLauncher-iOS$SUFFIX/Resources/readium-shared-js/readium-cfi-js"

printg "Cloning OSX --------"
cd $ROOT_PWD
init_repo "https://github.com/readium/SDKLauncher-OSX.git" "SDKLauncher-OSX$SUFFIX"
init_subrepo "SDKLauncher-OSX$SUFFIX/readium-sdk"
init_subrepo "SDKLauncher-OSX$SUFFIX/readium-shared-js"
init_subrepo "SDKLauncher-OSX$SUFFIX/readium-shared-js/readium-cfi-js"

printg "Cloning readium-js-viewer --------"
init_repo "https://github.com/readium/readium-js-viewer.git" "readium-js-viewer$SUFFIX" 
init_subrepo "readium-js-viewer$SUFFIX/readium-js"
init_subrepo "readium-js-viewer$SUFFIX/readium-js/readium-shared-js"
init_subrepo "readium-js-viewer$SUFFIX/readium-js/readium-shared-js/readium-cfi-js"

#printg "Cloning Windows --------"
# cd $ROOT_PWD
# git clone --recursive https://github.com/readium/SDKLauncher-Windows.git -b $BRANCH SDKLauncher-Windows$SUFFIX
# cd SDKLauncher-Windows$SUFFIX
# init_repo
# cd readium-sdk
# init_repo
# cd ../readium-shared-js
# init_repo

printg "Now verifying that the commit hashes are the same for each shared-js submodule -------"
echo "${green}Comparing shared-js submodules${NC}"
cd $ROOT_PWD/readium-js-viewer$SUFFIX/readium-js/readium-shared-js
echo_pwd
git log -n 1 --pretty=format:"%H" $BRANCH

cd $ROOT_PWD/SDKLauncher-Android$SUFFIX/readium-shared-js
echo_pwd
git log -n 1 --pretty=format:"%H" $BRANCH

cd $ROOT_PWD/SDKLauncher-iOS$SUFFIX/Resources/readium-shared-js
echo_pwd
git log -n 1 --pretty=format:"%H" $BRANCH

cd $ROOT_PWD/SDKLauncher-OSX$SUFFIX/readium-shared-js
echo_pwd
git log -n 1 --pretty=format:"%H" $BRANCH

# cd $ROOT_PWD/SDKLauncher-Windows$SUFFIX/readium-shared-js
# echo_pwd
# git log -n 1 --pretty=format:"%H" $BRANCH

printg "Now verifying that the commit hashes are the same for each readium-sdk submodules --------"
cd $ROOT_PWD/SDKLauncher-Android$SUFFIX/readium-sdk
echo_pwd
git log -n 1 --pretty=format:"%H" $BRANCH

cd $ROOT_PWD/SDKLauncher-iOS$SUFFIX/readium-sdk
echo_pwd
git log -n 1 --pretty=format:"%H" $BRANCH

cd $ROOT_PWD/SDKLauncher-OSX$SUFFIX/readium-sdk
echo_pwd
git log -n 1 --pretty=format:"%H" $BRANCH

# cd $ROOT_PWD/SDKLauncher-Windows$SUFFIX/readium-sdk
# echo_pwd
# git log -n 1 --pretty=format:"%H" $BRANCH

printg "-------- Clone of branch $BRANCH complete -----------"