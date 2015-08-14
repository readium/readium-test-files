#!/bin/sh
#---------------------------------------------------
# This script is configured to zip up the specified 
# directory in the standard EPUB-compliant way
# @rkwright, July 2015
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

#-------------------------------------------------------

if [ $# -ne 2 ]
  then
    printr "No zipfile name or target specified! Exiting..."
    printr "Usage: ./zip-epub.sh <zipfilename> <target-dir>"
    exit 1
fi

# save the argument - the branch name
FOLDER=$1
ZIPNAME=$2
printg "Creating EPUB \"$ZIPNAME.epub\" from folder \"$FOLDER\""

# save the original folder
ROOT_PWD=$(pwd)

# go into the target folder
cd $FOLDER

# remove the old file, if any
rm $ZIPNAME.epub

# start the zip with the uncompressed mimetype file, per spec
zip -X -0 $ZIPNAME mimetype

# the zip all the rest, excluding the junk (.idea folder, .DS_Store, etc.)
zip -X -x "*/.idea/*" "*/.DS_Store" "*.epub" -r -u $ZIPNAME ./*
mv $ZIPNAME.zip $ZIPNAME.epub

printg "-------- Zip of folder $FOLDER into $ZIPNAME complete -----------"
ls -l $ZIPNAME.epub

echo "${green}Checking EPUB '$ZIPNAME.epub' against epubcheck 4.0.0.${NC}"

java -cp /Users/rkwright/Documents/github/readium-test-files/util/scripts/epubcheck/lib  -jar /Users/rkwright/Documents/github/readium-test-files/util/scripts/epubcheck/epubcheck.4.0.0.jar $FOLDER/$ZIPNAME.epub

# and return to the original folder
cd $pwd