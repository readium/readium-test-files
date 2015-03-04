release #!/bin/sh
#---------------------------------------------------
# This script is configured to clone each of the five 
# main Readium repos and their submodules
# It sets each repo and submodule to the develop branch
# At completion it fetches the git hash for each submodule
# @rkwright, February 2015
#---------------------------------------------------

# make sure the supplied a version
red='\033[1;31m'
NC='\033[00m' # no color
if [ $# -eq 0 ]
  then
    echo "${red}No release tag supplied!  Exiting...${NC}"
    exit 1
fi

# save the argument - the release name
VERSION=$1

# save the original folder
ROOT_PWD=$(pwd)
echo "Root folder = " $ROOT_PWD

# save the argument - the release name
VERSION=$1
echo "Initializing release" $VERSION
# init each repo
cd $ROOT_PWD/SDKLauncher-Android
pwd
git flow init -fd
git flow release start $VERSION
git flow release publish $VERSION
# need to init each of the submodules too, but only in one main repo
cd readium-sdk
pwd
git flow init -fd
git flow release start $VERSION
git flow release publish $VERSION
#
cd ../readium-shared-js
pwd
git flow init -fd
git flow release start $VERSION
git flow release publish $VERSION
#
cd $ROOT_PWD/SDKLauncher-iOS
pwd
git flow init -fd
git flow release start $VERSION
git flow release publish $VERSION
#
cd $ROOT_PWD/SDKLauncher-OSX
pwd
git flow init -fd
git flow release start $VERSION
git flow release publish $VERSION
#
cd $ROOT_PWD/readium-js-viewer
pwd
git flow init -fd
git flow release start $VERSION
git flow release publish $VERSION
# need to init readium-js too
cd readium-js
pwd
git flow init -fd
git flow release start $VERSION
git flow release publish $VERSION

