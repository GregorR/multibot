#!/bin/bash
# 21 = !

# Get the command and arg separated
CMD=`echo "$3" | sed 's/^.\([^ ]*\).*/\1/'`
ARG=`echo "$3" | sed 's/^.[^ ]* *//'`

# Scrub the commands
CMD=`echo "$CMD" | sed 's/[^A-Za-z0-9]/_/g'`

# Look for a simple or complex version
if [ -x cmds/$CMD ]
then
    exec cmds/$CMD "$CMD" "$ARG" "$@"
elif [ -x scmds/$CMD ]
then
    scmds/$CMD "$CMD" "$ARG" "$@" |
        sed 's/^/PRIVMSG '$2' :/' |
        socat STDIN UNIX-SENDTO:"$IRC_SOCK"
fi
