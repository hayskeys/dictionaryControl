#!/bin/bash
#title          :dictionaryControl.sh
#description    :Easily add, remove, or search words in your LocalDictionary file
#author         :hayskeys (https://github.com/hayskeys)
#version        :1.0
#date           :20170711

dictionaryDir=~/Library/Spelling
dictionaryFileName=LocalDictionary
dictionaryFile=$dictionaryDir/$dictionaryFileName

function usageAndExit {
    echo "Usage: "
    echo "  dict -a newWord -- to add a word"
    echo "  dict -r oldWord -- to remove a word"
    echo "  dict -s aWord   -- to search for a word"
    echo "  dict -d         -- to display your dictionary"
    exit
}

function checkIfDictionaryExists {
    if [ ! -f $dictionaryFile ]; then
        echo "You do not have a dictionary file at"
        echo "$dictionaryFile"
        createResp=""

        while [ "$createResp" != "Y" ] && [ "$createResp" != "N" ]; do
            echo "Would you like to create one? [Y/N]"
            read createResp
        done

        if [ "$createResp" == "Y" ]; then
            echo "Dictionary file created. Continuing..."
            touch $dictionaryFile
        elif [ "$createResp" == "N" ]; then
            echo "Dictionary not created. Exiting..."
            exit
        fi
    fi
}

#check number of params passed in.
if [ $# -ne 2 ]; then
    if [ $# -ne 1 ] || [ "$1" != "-d" ]; then
        usageAndExit
    fi
fi

case "$1" in
    -a | --add)
        #add word
        checkIfDictionaryExists
        if grep -qw -- "$2" $dictionaryFile; then
            echo "$2 is already in your dictionary:"
            grep -w -- "$2" $dictionaryFile
        else
            echo "$2" >> $dictionaryFile
            echo "$2 was added to your dictionary"
        fi
        ;;
    -r | --remove)
        #remove word
        checkIfDictionaryExists
        if grep -qw -- "$2" $dictionaryFile; then
            grep -vw -- "$2" $dictionaryFile > $dictionaryDir/tempDict
            mv $dictionaryFile $dictionaryFile.bak
            mv $dictionaryDir/tempDict $dictionaryFile
            echo "$2 was removed from your dictionary"
        else
            echo "$2 was not found in your dictionary"
        fi
        ;;
    -s | --search)
        #search word
        checkIfDictionaryExists
        if grep -qw -- "$2" $dictionaryFile; then
            echo "$2 is in your dictionary:"
            grep -w -- "$2" $dictionaryFile
        elif grep -qwi -- "$2" $dictionaryFile; then
            echo "$2 is not in your dictionary, but case-insensitive match(es) are:"
            grep -wi -- "$2" $dictionaryFile
        else
            echo "$2 is not in your dictionary"
        fi
        ;;
    -d | --display)
        #display dictionary
        checkIfDictionaryExists
        echo "Your dictionary has the following words:"
        echo "#######################################"
        cat $dictionaryFile
        echo "#######################################"
        ;;
    --)
        usageAndExit
        ;;
    -*)
        usageAndExit
        ;;
    *)
        usageAndExit
        ;;
esac
