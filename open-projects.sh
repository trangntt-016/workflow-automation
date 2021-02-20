#!/usr/bin/env bash
echo "Gimme name of the project you wanna open : "
read input

echo "Searching project with this pattern '${input}' under $PWD directory"
array=(`find ~/Projects/* -type d -name '*'${input}'*'`)

for ((i=0;i<${#array[@]};i++))
do :
	    echo "$i: ${array[$i]}"
    done

    echo "Which project you want to go to? Pick a number"
    read number

    echo "Let's go to ${array[$number]}"

    cd ${array[$number]}
    exec bash
