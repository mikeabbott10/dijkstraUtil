#!/bin/bash
# USAGE: bash tester.sh [-gcc] lezXesY
gccFlag=$1
nomeEsercizio=$2
function dostuff(){
	counter=0
	while [ true ]
	do
		#echo -n "$counter "
		inputFilePath=$nomeEsercizio"/testcase/""input""$counter"".txt"
		if [ -f "$inputFilePath" ]; then
			echo -n "(*)$inputFilePath"
			printf " exists. diff cmd returns:\n"
			# do stuff
			exeFilePath=$nomeEsercizio"/output.out"
			outputFilePath=$nomeEsercizio"/testcase/""output""$counter"".txt"
			cat $inputFilePath | $exeFilePath | diff - $outputFilePath
		else
			if !(($counter==0)); then
				# stop execution
				break
			fi
		fi
		((counter++))
		printf "\n"
	done
}

if [ "$gccFlag" = "-gcc" ]; then
	if gcc $nomeEsercizio"/"$nomeEsercizio".c" -o $nomeEsercizio"/output.out"; then
		dostuff
	else
		echo "gcc failed, try it manually"
	fi
else
	nomeEsercizio=$gccFlag
	dostuff
fi
printf "\n"
