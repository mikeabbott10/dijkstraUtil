lezione=$1
n_esercizi=$2
for i in $(seq 1 $n_esercizi); do 
	mkdir "lez""$lezione""es""$i"
	cd "lez""$lezione""es""$i"
	mkdir "testcase"
	cd ..
done
