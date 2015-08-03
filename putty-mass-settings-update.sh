#!/usr/bin/env bash
#
# This script mass updates all putty registry entries with a set of default values

SESSIONS=$( REG QUERY 'HKEY_CURRENT_USER\Software\SimonTatham\PuTTY\Sessions' | tail -n +2 | tr -d '\r' )

# This is a selected values from
# REG EXPORT 'HKEY_CURRENT_USER\Software\SimonTatham\PuTTY\Sessions\Default%20Settings' putty-default.reg
SETTINGS=(
"Colour0"="131,148,150"
"Colour1"="147,161,161"
"Colour2"="0,43,54"
"Colour3"="7,54,66"
"Colour4"="0,43,54"
"Colour5"="238,232,213"
"Colour6"="7,54,66"
"Colour7"="0,43,56"
"Colour8"="220,50,47"
"Colour9"="203,75,22"
"Colour10"="133,153,0"
"Colour11"="88,110,117"
"Colour12"="181,137,0"
"Colour13"="101,123,131"
"Colour14"="38,139,210"
"Colour15"="131,148,150"
"Colour16"="211,54,130"
"Colour17"="108,113,196"
"Colour18"="42,161,152"
"Colour19"="147,161,161"
"Colour20"="238,232,213"
"Colour21"="253,246,227"
"Present"=dword:00000001
"Protocol"="ssh"
"CloseOnExit"=dword:00000001
"WarnOnClose"=dword:00000001
"PingInterval"=dword:00000000
"PingIntervalSecs"=dword:0000003b
"TerminalType"="xterm+256color"
"SshProt"=dword:00000003
"HideMousePtr"=dword:00000001
"Beep"=dword:00000001
"ScrollbackLines"=dword:0007A120
"TermWidth"=dword:00000050
"TermHeight"=dword:00000028
"Font"="Consolas"
"FontHeight"=dword:0000000c
"FontQuality"=dword:00000003
"UseSystemColours"=dword:00000000
"TryPalette"=dword:00000000
"ANSIColour"=dword:00000001
"Xterm256Colour"=dword:00000001
"BoldAsColour"=dword:00000000
"MouseIsXterm"=dword:00000001
"RectSelect"=dword:00000000
"MouseOverride"=dword:00000001
"LineCodePage"="UTF-8"
"UTF8Override"=dword:00000001
"ScrollBar"=dword:00000001
"ScrollOnKey"=dword:00000001
"ScrollOnDisp"=dword:00000000
"X11Forward"=dword:00000000
"NoRemoteResize"=dword:00000001
"NoAltScreen"=dword:00000001
"ConnectionSharing"=dword:00000000 )


for SESSION in $SESSIONS; do
    echo Processing $SESSION...
    for SETTING in "${SETTINGS[@]}" ; do
        KEY="${SETTING%%=*}"
        VALUE="${SETTING##*=}"

        DWORDKEY="${VALUE%%:*}"
        DWORDVALUE="0x${VALUE##*:}"
        if [ "$DWORDKEY" == "dword" ]; then
            REG ADD $SESSION /f /v $KEY /t REG_DWORD /d $(( $DWORDVALUE )) > /dev/null
        else
            REG ADD $SESSION /f /v $KEY /d $VALUE > /dev/null
        fi
    done
done
