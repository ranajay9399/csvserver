#!/bin/bash

read -p "Please insert the first number as first entry: " entry1
read -p "Please insert the second number as last entry: " entry2

entry1=$((entry1))
entry2=$((entry2))

while [ $entry1 -le $entry2 ]
do
	rand=$((RANDOM%1000))
	echo "$entry1, $rand" >> inputFile
	entry1=$(($entry1+1))
done
