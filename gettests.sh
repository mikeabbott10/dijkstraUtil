#!/bin/bash
# USAGE: bash gettests.sh X
lezione=$1
counter=1
input="testzips""$lezione"".txt"
while IFS= read -r line
do
	wget "$line"
	path="lez""$lezione""es""$counter""/testcase"
	zip=`echo "$line" | rev | cut -d/ -f1 | rev`
	unzip "$zip" -d $path
	rm "$zip"
	nDir=`find $path -type d | wc -l`
	if [ "$nDir" -gt 1 ]; then
		# entro qui solo se in $path è presente una sottocartella contenente i testcase (muoviamo i testcase nella directory $path e rimuoviamo la sottocartella)
	    cd "$path"
	    mv */*.txt .
	    rm -r */
	    cd ../..
	fi
	((counter++))
	sleep 3
done < "$input"
