#!/bin/bash

options=""

# Actions
options="$options 1 ScreenLock"
action[1]="slock"

options="$options 2 Suspend"
action[2]="slock & sudo pm-suspend"

# Ask for option
selected=`zenity --list --column id --column action --title "dwm-menu" --text "Choose action" $options`

# Run it!
if [ "$selected" != "" ];then
    # Debug
    echo "Choosed option $selected"
    # Run it
    eval ${action[$selected]}
fi
