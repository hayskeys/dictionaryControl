# dictionaryControl
Easily add, remove, or search words in your LocalDictionary file (Mac)
######################################################################
Author: hayskeys (https://github.com/hayskeys)

This is a simple script to add, remove, or search words in your LocalDictionary.
This script assumes you are running Mac OS and are running a version that stores
the LocalDictionary file as ~/Library/Spelling/LocalDictionary. If that is not
where your dictionary is stored or not what the file is named, this script will
not work for you in it's default configuration, but you can change the default
dir and filename. I spend most of my time in the terminal or in IDE's that don't
always have the dictionary functions implemented, so I built this as a simple
solution to get around the annoyance of having to add words and remove words
using either the built in TextEdit functionality or manually going to the file
to edit it. If you find this useful, please enjoy! If you don't, I'm sorry, feel
free to modify however you'd like.

########
Install:
########
Copy the file dictionaryControl.sh to ~/bin/
Add the following alias to your .bash_profile file
    alias dict="~/bin/dictionaryControl.sh"
Run and enjoy!
