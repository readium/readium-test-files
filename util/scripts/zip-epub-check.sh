#!/bin/sh
#---------------------------------------------------
# This script updates the OPF's dcterms:modified 
# field first, then zips up the specified directory 
# in the standard EPUB-compliant way. Finally, it runs 
# epucheck against the resulting EPUB.
# 
# @rkwright, July 2015
#---------------------------------------------------
red='\033[1;31m'
green='\033[0;32m'
NC='\033[00m' # no color
EPUBCHECKLIB='/Users/rkwright/Documents/github/readium-test-files/util/scripts/epubcheck/lib'
EPUBCHECKJAR='/Users/rkwright/Documents/github/readium-test-files/util/scripts/epubcheck/epubcheck.4.0.1.jar'

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
# make sure they supplied some args...
if [ $# -ne 2 ]
  then
    printr "No src-folder and/or zipfile name specified! Exiting..."
    printr "Usage: ./zip-epub.sh <src-dir> <zipfilename>"
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

# update the mod time of the OPF file
OPFFILE=$(find $FOLDER -name *.opf)
java  -jar /Users/rkwright/Documents/github/readium-test-files/util/scripts/UpdateModTime.jar $OPFFILE

# start the zip with the uncompressed mimetype file, per spec
zip -X -0 $ZIPNAME mimetype

# the zip all the rest, excluding the junk (.idea folder, .DS_Store, etc.)
zip -X -x "*/.idea/*" "*/.DS_Store" "*.epub" "non-epub/*" -r -u $ZIPNAME ./*
mv $ZIPNAME.zip $ZIPNAME.epub

printg "-------- Zip of folder $FOLDER into $ZIPNAME complete -----------"
ls -l $ZIPNAME.epub

echo "${green}Checking EPUB '$ZIPNAME.epub' against epubcheck 4.0.1${NC}"

java -cp $EPUBCHECKLIB -jar $EPUBCHECKJAR  $FOLDER/$ZIPNAME.epub

# and return to the original folder
cd $pwd