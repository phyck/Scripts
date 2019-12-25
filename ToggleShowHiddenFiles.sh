#!/bin/bash
# ---------------------------------------------------------------------------------------------------
# Short script to quickly toggle Show Hidden Files true/false in Finder (macOS).
# You can use tools like Alfred to bind this script to a custom hotkey for ease of use!
# Author: Stephen Hermans
#
# Usage: ToggleShowHiddenFiles.sh
# ---------------------------------------------------------------------------------------------------

function is_int() { return $(test "$@" -eq "$@" > /dev/null 2>&1); }

showAll=$(defaults read com.apple.finder AppleShowAllFiles)
echo "old showAll: ${showAll}"

if $(is_int "${showAll}"); then
    echo "showAll: ${showAll}"
elif [[ "$showAll" == "true" || "yes" ]]; then
    showAll=1
    echo "showAll=true/yes converted to: ${showAll}"
elif [[ "$showAll" == "false" || "no" ]]; then
    showAll=0
    echo "showAll=false/no converted to: ${showAll}"
else
    echo "invalid showAll value: ${showAll}"
fi

showAll=$((1-showAll))   # Toggle value (only works if value is 0, 1, empty, unset or a string which doesn't represent a number)

echo "new showAll: ${showAll}"

defaults write com.apple.finder AppleShowAllFiles $showAll
defaults read com.apple.finder AppleShowAllFiles

killall Finder
sleep 3

# Checks if finder has restarted correctly
FinderProcs=$(ps -ef | grep "Finder" | grep -v "grep" | wc -l)
if [ $FinderProcs -lt 1 ]; then
	open -a Finder     # Finder failed to start, force open Finder
fi
