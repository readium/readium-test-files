#!/bin/sh
#---------------------------------------------------
# This script is configured to clone each of the eight
# repos.  It then runs gitstats against each repo
# with the output going to the appropriate folder
# in the dashboard pages.
# At completion it deletes the cloned repos
# @rkwright, June 2015
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

function gitstats {
	printg "Cloning $1 --------"
	rm -rf $1$SUFFIX
	git clone https://github.com/readium/$1.git $1$SUFFIX
	gitstats/gitstats -c project_name=$1 $1$SUFFIX readium.github.io/gitstats/$1

	cd readium.github.io/gitstats/$1
    git add --all
    git commit -a -m "$1 gitstats update"
    git push
    cd $ROOT_PWD
	rm -rf $1$SUFFIX
}

#-------------------------------------------------------

SUFFIX='-gst'

# save the original folder
ROOT_PWD=$(pwd)
printg "Root folder = $ROOT_PWD"

# now clone each repo then run gitstats, pushing the results to the correct folder
# then commit and push the results to the appropriate folder on readium.github.io

gitstats "readium-js-viewer"
gitstats "readium-js"
gitstats "readium-shared-js"
gitstats "readium-cfi-js"
gitstats "readium-sdk"
gitstats "SDKLauncher-iOS"
gitstats "SDKLauncher-Android"
gitstats "SDKLauncher-OSX"
gitstats "SDKLauncher-Windows"

exit 1

printg "Cloning Android --------"
cd $ROOT_PWD
git clone --recursive https://github.com/readium/SDKLauncher-Android.git SDKLauncher-Android$SUFFIX 
cd SDKLauncher-Android$SUFFIX
init_repo
cd readium-sdk
init_repo
cd ../readium-shared-js
init_repo

printg "Cloning iOS --------"
cd $ROOT_PWD
git clone --recursive https://github.com/readium/SDKLauncher-iOS.git  SDKLauncher-iOS$SUFFIX
cd SDKLauncher-iOS$SUFFIX
init_repo
cd readium-sdk
init_repo
cd ../Resources/readium-shared-js
init_repo

printg "Cloning OSX --------"
cd $ROOT_PWD
git clone --recursive https://github.com/readium/SDKLauncher-OSX.git SDKLauncher-OSX$SUFFIX
cd SDKLauncher-OSX$SUFFIX
init_repo
cd readium-sdk
init_repo
cd ../readium-shared-js
init_repo

#printg "Cloning Windows --------"
# cd $ROOT_PWD
# git clone --recursive https://github.com/readium/SDKLauncher-Windows.git SDKLauncher-Windows$SUFFIX
# cd SDKLauncher-Windows$SUFFIX
# init_repo
# cd readium-sdk
# init_repo
# cd ../readium-shared-js
# init_repo

printg "Now verifying that the commit hashes are the same for each shared-js submodule -------"
echo "${green}Comparing shared-js submodules${NC}"
cd $ROOT_PWD/readium-js-viewer$SUFFIX/readium-js/epub-modules/epub-renderer/src/readium-shared-js
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