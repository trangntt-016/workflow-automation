#!/usr/bin/env bash

echo "Gimme name of the project you wanna commit : "
read input

echo "Searching project with this pattern '${input}' under $PWD directory"
array=(`find ~/* -type d -name '*'${input}'*'`)

if [ $(find ~/* -type d -name '*'${input}'*'|wc -l) -gt 0 ]  
then
	for ((i=0;i<${#array[@]};i++))
	do :
		echo "$i: ${array[$i]}"
	done
	
	echo "Which project you want to go to? Pick a number"
	read number
	echo "Let's go to ${array[$number]}"
	
	cd ${array[$number]}
fi

projectName="$(basename ${array[$number]})"

echo "I will commit project $projectName at path ${array[$number]}"

cd ${array[$number]}

echo "Files in this project: "
ls

echo "Are you sure to commit? Y or N"
read yNO

if [ $yNO == "Y" ]
then
	echo "I need your git remote address"
	read addr
	git add .
	read -r -p 'Commit description: ' desc
	git commit -m "$desc"
	git remote -v
	git branch -a
	git push -u origin main
	git status
	printf "\nEnd local commit on $local; merge and push to branch $remote. Well done!\n"
fi
exec bash
