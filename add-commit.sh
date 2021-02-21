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
	git add .
	read -r -p 'Commit description: ' desc
	git commit -m "$desc"
	echo "Your local branches: "
	git branch -a
	echo "Your remote branches: "
	git branch -r
	echo 'Enter local branch you wanna commit: '
	read localB
	echo "Enter remote branch you wanna commit: "
	read remote
	git push -u $localB $remote
	git status
	printf "\nEnd local commit on $localB; merge and push to branch $remote. Well done!\n"
fi
exec bash
