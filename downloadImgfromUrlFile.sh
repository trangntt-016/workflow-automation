#!/usr/bin/env bash

echo "What's the filename?"
read filename

echo "Start finding ${filename} in the Downloads Windows"
array=(`find /mnt/c/Users/trang/Downloads/ -maxdepth 1 -type f -name '*'${filename}'*'`)

for ((i=0;i<${#array[@]};i++))
do :
	echo "$i: ${array[$i]}"
done

echo "Which file contain the URL? Pick a number."
read number
filename=$(basename ${array[$number]})
echo "Start copying ${filename} from your Downloads Windows to $PWD directory"

pathname="/mnt/c/Users/trang/Downloads/${filename}"
cp ${pathname} .

echo "Create a temp folder to store them. Enter the folder name"
read folder
mkdir ${folder}
cd ${folder}

echo "Move ${filename} to ${folder}"
mv ../${filename} .
echo "Image completed will have format: firstName_lName.jpg. Start downloading... "

while IFS=, read -r one two three four five; do 
	    imgName="${one}_${two}.jpg";
	 curl -o $imgName $five;  
	      done < ${filename}

	      echo "Encounter errors (URL is not found) when downloading these images: "
	      find . -type f -size -4096c > errors.txt
	      echo "Total of error images: "
	      find . -type f -size -4096c | wc -l

	      echo "Now I will move $folder to Downloads in your Windows"
	      count=$(find /mnt/c/Users/trang/Downloads/ -maxdepth 1 -type d -name ${folder} |wc -l)
	      echo $count
	      if [ ${count}>0 ]
	      then
	      echo "There are ${count} folders in Downloads with this name ${folder}."
	      find /mnt/c/Users/trang/Downloads/ -maxdepth 1 -type d -name ${folder}
	      echo "Please change another name:"
	      cd ..
	      read newFolder
	      mv ${folder} ${newFolder}
	      fi
	      mv ${newFolder} /mnt/c/Users/trang/Downloads
	      echo "Download completed. Check ${newFolder} in your Downloads Windows"
	      exec bash
