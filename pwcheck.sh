#!/bin/bash

#function that runs in "else" condition of if; elif which checks password length.
lengthCheck_success () {
	#on passing -gt and -lt checks, add points for character length to the running score total.
	((scoreTotal+=charLength))

	#using case https://www.gnu.org/software/bash/manual/bash.html#Conditional-Constructs
		#to perform Pattern Matching https://www.gnu.org/software/bash/manual/bash.html#Pattern-Matching
		#the '*' is used to unbound the positional nature of pattern match - allowing # to match anywhere in string $password
		#matching a pattern utilizes arithmetic notation of double parentheses to add points to running total.
		#using ;;& allows all conditions of the case to be tested, with the arithmetic command being executed if a match is found.

	case "$password" in
 		*#* | *\$* | *+* | *%* | *@* ) ((scoreTotal+=5));;&
 		*[0-9]* ) ((scoreTotal+=5));;&
 		*[A-Z]* | *[a-z]* ) ((scoreTotal+=5));;&
	esac

	#grep with extended and quiet flags to permit use of meta-charcters without escaping each, and suppressing the regex output to cli:
	#back reference numeric and upper/lower alpha to fulfill check on repetition of the same character.
	if echo "$password" | grep -Eq '([0-9a-zA-Z])\1+'; then
		((scoreTotal-=10))
	fi

	#using quantifier to match on any combination of lower alpha characters ocurring 3 or more times consecutively. 
	if echo "$password" | grep -Eq '([a-z]){3,}'; then
		((scoreTotal-=3))
	fi

	#using quantifier to match on any combination of upper alpha characters ocurring 3 or more times consecutively.
	if echo "$password" | grep -Eq '([A-Z]){3,}'; then
		((scoreTotal-=3))
	fi

	#using quantifier to match on any combination of numeric characters ocurring 3 or more times consecutively.
	if echo "$password" | grep -Eq '([0-9]){3,}'; then
		((scoreTotal-=3))
	fi

	echo "Password Score: $scoreTotal"
}
#end function 
#begin script

#variable to store running-score updates.
scoreTotal=0

#using cat to append the password string from [ arguement $1 (.file/path/to/passwordfile.txt)] into the variable "password".
password="$(cat $1)"

#using expansion EXPRESSION [ length ] to return string length of password into variable charLength
charLength="$(expr length "$password")"

#using if [ command 1 ] OR [ command 2 ] to verify password length is less than 32 and greater than 5. 
if [ $charLength -gt 32 ] || [ $charLength -lt 6 ]; then
	echo "Error: Password length invalid"

#password length correct, call function to perform scoring.
else
	lengthCheck_success
fi



