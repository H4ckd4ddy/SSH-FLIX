#!/bin/bash

current_selection=0

display_center(){
	COLUMNS=$(tput cols) 
	texte="$1" 
	printf "%*s\n" $(((${#texte}+$COLUMNS)/2)) "$texte"
}

display_center_red(){
	COLUMNS=$(tput cols) 
	texte="$1" 
	printf "\e[31m%*s\n\e[0m" $(((${#texte}+4+$COLUMNS)/2)) "> $texte <"
}

display_image(){
	jp2a --colors $1
}

display_menu(){
	clear

	display_image /ssh-flix.jpg

	display_center "Use up/down keyboard arrows to make your choice, then play with right arrow"
	printf "\n\n\n\n\n"

	display_center '-------------------------------------------------'
	i=0
	movies_list=''
	for movie in /movies/*.mp4
	do
		echo ''
		movie_name="$(basename $movie .mp4)"
		if [ "$i" -eq "$current_selection" ];then
			display_center_red $movie_name
		else
			display_center $movie_name
		fi
		i=$((i+1))
		movies_list="$movies_list$movie,"
	done
	options_count=$i
	movies_list=${movies_list::-1}
	printf "\n"
	display_center '-------------------------------------------------'

	printf "\n\n\n\n\n"
	display_center "The first streaming video service over SSH"
	display_center "SSH-FLIX - Etienne Sellan - 2020"
}

play(){
	video-to-ascii -f "$1"
}

arrowup='\[A'
arrowdown='\[B'
arrowright='\[C'
arrowleft='\[D'
insert='\[2'
delete='\[3'
SUCCESS=0
OTHER=65

while true; do
	display_menu
	read -n3 key

	echo -n "$key" | grep "$arrowup"
	if [ "$?" -eq $SUCCESS ];then
		if [ "$current_selection" -gt "0" ];then
			current_selection=$((current_selection-1))
		fi
		continue
	fi

	echo -n "$key" | grep "$arrowdown"
	if [ "$?" -eq $SUCCESS ];then
		if [ "$current_selection" -lt "$(($options_count-1))" ];then
			current_selection=$((current_selection+1))
		fi
		continue
	fi

	echo -n "$key" | grep "$arrowright"
	if [ "$?" -eq $SUCCESS ];then
		play $(echo "$movies_list" | cut -d ',' -f $((current_selection+1)))
		continue
	fi

done

