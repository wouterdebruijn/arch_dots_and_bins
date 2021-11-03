#!/bin/bash

# Music web player script by Wouter de Bruijn public@js.hedium.nl
# Added KDE connect at 26-10-2021

INSTANCE=$(playerctl --list-all 2> /dev/null | grep firefox)
INSTANCES=($INSTANCE)

MOBILEINSTANCE=$(playerctl --list-all 2> /dev/null | grep kdeconnect)

grep "local" /tmp/playerinstance &> /dev/null && PLAYERINSTANCE="local" || PLAYERINSTANCE="mobile"

[ "$PLAYERINSTANCE" == "mobile" ] && INSTANCES=($MOBILEINSTANCE)


[ "$PLAYERINSTANCE" == "mobile" ] && printf "  "

for i in "${INSTANCES[@]}"
do	
	STATUS=$(playerctl -p "$i" status 2> /dev/null)
	TITLE=$(playerctl -p "$i" metadata title 2> /dev/null)
	ARTIST=$(playerctl -p "$i" metadata artist 2> /dev/null)

	echo $ARTIST | grep -q Topic && ARTISTOUT="${ARTIST::-8}" || ARTISTOUT="$ARTIST"

	[ "$STATUS" == "Playing" ] && ICON= || ICON=
	[ "$STATUS" == "Stopped" ] || printf "$TITLE 🎤 ${ARTISTOUT}   $ICON"
done

[ "${INSTANCES[0]}" ] || printf " Stopped"
