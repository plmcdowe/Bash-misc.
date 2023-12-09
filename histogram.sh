#!/bin/bash

file="$1"
if [ -z "$file" ]; then
	echo "Usage: histogram <filename>"
	exit 1
fi
if [ ! -f "$file" ] || [ ! -r "$file" ]; then
	echo Error: "$file" is not readable
	exit 1
fi

scoreArray=($(cut -d ' ' -f2 "$file"))
echo "${#scoreArray[@]}" scores total...

sumA=0
for i in ${scoreArray[@]}; do
  let sumA=sumA+i 
  if [ $i -eq 100 ]; then
    ar100+=("=")
  fi 
  if [ $i -lt 100 ] && [ $i -ge 90 ]; then
    ar90+=("=")
  fi 
  if [ $i -lt 90 ] && [ $i -ge 80 ]; then
    ar80+=("=")
  fi
  if [ $i -lt 80 ] && [ $i -ge 70 ]; then
    ar70+=("=")
  fi
  if [ $i -lt 70 ] && [ $i -ge 60 ]; then
    ar60+=("=")
  fi
  if [ $i -lt 60 ] && [ $i -ge 50 ]; then
    ar50+=("=")
  fi
  if [ $i -lt 50 ] && [ $i -ge 40 ]; then
    ar40+=("=")
  fi
  if [ $i -lt 40 ] && [ $i -ge 30 ]; then
    ar30+=("=")
  fi
  if [ $i -lt 30 ] && [ $i -ge 20 ]; then
    ar20+=("=")
  fi
  if [ $i -lt 20 ] && [ $i -ge 10 ]; then
    ar10+=("=")
  fi
  if [ $i -eq 0 ]; then
    ar0+=("=")
  fi
done
let average=$sumA/${#scoreArray[@]}
echo Average: $average

printf %s "100: ${ar100[@]}" $'\n'
printf %s "90: ${ar90[@]}" $'\n'
printf %s "80: ${ar80[@]}" $'\n'
printf %s "70: ${ar70[@]}" $'\n'
printf %s "60: ${ar60[@]}" $'\n'
printf %s "50: ${ar50[@]}" $'\n'
printf %s "40: ${ar40[@]}" $'\n'
printf %s "30: ${ar30[@]}" $'\n'
printf %s "20: ${ar20[@]}" $'\n'
printf %s "10: ${ar10[@]}" $'\n'
printf %s " 0: ${ar0[@]}" $'\n'