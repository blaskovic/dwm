#!/bin/bash

CONFIG_FILE=~/.dwm-menu

FONT="-*-terminus-medium-r-*-*-16-*-*-*-*-*-*-*"
DMENU="dmenu -fn $FONT"

ERROR="ERROR! Config file is missing!
Create $CONFIG_FILE file according to this template:

Name of command | command to execute
Another name | another command"

# If config file is missing
test -f $CONFIG_FILE || { echo "$ERROR" | $DMENU -l `echo "$ERROR" | wc -l`; exit 1;}

# Get it
selected=`cat $CONFIG_FILE | $DMENU -l "\`cat $CONFIG_FILE | wc -l\`" | awk -F'|' '{print $2}'`

# Run it!
eval "$selected"
