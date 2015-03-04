#!/bin/sh
VERSION=$1
# init each repo
cd ../SDKLauncher-Android
git flow init -fd
git flow release start $VERSION
git flow release publish $VERSION
cd readium-sdk
git flow init -fd
git flow release start $VERSION
git flow release publish $VERSION
cd ../readium-shared-js
git flow init -fd
git flow release start $VERSION
git flow release publish $VERSION
cd ../../SDKLauncher-iOS
git flow init -fd
git flow release start $VERSION
git flow release publish $VERSION
cd ../SDKLauncher-OSX
git flow init -fd
git flow release start $VERSION
git flow release publish $VERSION
cd ../readium-js-viewer
git flow init -fd
git flow release start $VERSION
git flow release publish $VERSION
cd readium-js
git flow init -fd
git flow release start $VERSION
git flow release publish $VERSION
cd readium-js-viewer/readium-js
git flow init -fd
git flow release start $VERSION
git flow release publish $VERSION

