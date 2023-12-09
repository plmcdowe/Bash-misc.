#!/bin/bash

limit="$1"
if [ -z "$limit" ]; then
  echo "Usage: fibonacci <limit>"
fi

a=1
b=1
i=0
while ((i<limit)); do
  echo -n "$a "
  fn=$((a + b))
  a=$b
  b=$fn
  ((i++))
done;
echo
