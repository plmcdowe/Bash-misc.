#!/bin/bash
input="$1"
if [ -n "$input" ]; then
  echo "Usage: finduser"
  exit 0
fi

echo "Welcome to User Finder!"
read -p "Please enter part or all of a username to search for: " uname
result=$(ypcat passwd | grep "$uname")
line_count=$(echo "$result" | wc -l)
first=$(echo "$result" | grep -o -m 1 "[[:alpha:]].*" | tee save_first)
uname=$(cut -d ':' -f1 save_first)
name=$(cut -d ':' -f5 save_first | grep -Eo "[[:upper:]].*[[:lower:]]+")
home=$(cut -d ':' -f6 save_first)
shell=$(cut -d ':' -f7 save_first)

if [ -z $uname ]; then
  echo Sorry, I could not find that username.
  exit 0
fi
if [ $line_count -gt 1 ]; then
  echo I found "$line_count" matches! You might want to be more specific.
  echo The first of these matches is:
  echo Username: "$uname"
  echo Name: "$name"
  echo Home Directory: "$home"
  echo Shell: "$shell"
  date '+Search complete on %a %b %d %T EDT %Y'  
fi
if [ $line_count -eq 1 ]; then
  echo Match Found! Username: "$uname"
  echo Name: "$name"
  echo Home Directory: "$home"
  echo Shell: "$shell"  
  date '+Search complete on %a %b %d %T EDT %Y'
fi

