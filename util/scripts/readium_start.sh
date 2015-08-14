#!/bin/sh
#---------------------------------------------------
# This script is configured to start the release 
# process for each of the repos
# @rkwright, February 2015
#---------------------------------------------------

# make sure the supplied a version
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

function echo_pwd {
    printf "${green}"
    pwd
    printf "${NC}"
}

function init_repo {
    # remove old version, if any
    rm -rf $2
    git clone $1 $2
    cd $2
    # need to ensure that both master and develop branches are initialized on the client
    # or git-flow init will have a cow
    git checkout develop
    git checkout master
    # do the git flow start which creates a new branch from the current develop branch
    git flow init -fd
    git flow release start $VERSION
    git flow release publish $VERSION
    cd $ROOT_PWD
}

if [ $# -eq 0 ]
  then
    printr "No release tag supplied!  Exiting..."
    exit 1
fi

# save the argument - the release name
VERSION=$1

# see if the user supplied a suffix
SUFFIX=''
if [ $# -eq  2 ]
  then
    SUFFIX=$2
    printg "Using sufffix '$SUFFIX' on each app repo folder."
fi
# save the original folder
ROOT_PWD=$(pwd)
printg "Root folder = $ROOT_PWD"

printg "Initializing release $VERSION"

#-- Android --
init_repo  "https://github.com/readium/SDKLauncher-Android.git" "$ROOT_PWD/SDKLauncher-Android$SUFFIX"

#-- iOS --
init_repo "https://github.com/readium/SDKLauncher-iOS.git" "$ROOT_PWD/SDKLauncher-iOS$SUFFIX"

#-- OSX --
init_repo "https://github.com/readium/SDKLauncher-OSX.git" "$ROOT_PWD/SDKLauncher-OSX$SUFFIX"

#-- readium-js-viewer --
init_repo "https://github.com/readium/readium-js-viewer.git" "$ROOT_PWD/readium-js-viewer$SUFFIX"

# -- submodules --
# need to init each of the submodules too, but only in one main repo
init_repo "https://github.com/readium/readium-sdk.git" "$ROOT_PWD/readium-sdk$SUFFIX"
init_repo "https://github.com/readium/readium-shared-js.git" "$ROOT_PWD/readium-shared-js$SUFFIX"
init_repo "https://github.com/readium/readium-cfi-js.git" "$ROOT_PWD/readium-cf-js$SUFFIX"
init_repo "https://github.com/readium/readium-js.git" "$ROOT_PWD/readium-js$SUFFIX"


