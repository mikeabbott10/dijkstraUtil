# djikstraUtil
Strumenti utili per dijkstra.di.unipi.it

Gli strumenti presenti sono 3:
## 1. getLinks.js
* Ottiene i link relativi ai testcase (.zip) di una determinata lezione e genera un file di nome _testzipsX.txt_ che li contiene.
* #### USAGE: `node getLinks.js X nY`
_dove `X` è il numero relativo alla lezione e `nY` è il numero totale di esercizi presenti all'interno della lezione._\
**ATTENZIONE**: deve essere installato e funzionante l'ambiente nodejs. Non è necessario inserire questo script ad un percorso particolare per il suo corretto funzionamento, ricorda però che il file di testo generato va posizionato allo stesso livello dello script **gettests.sh** per poter, poi, essere utilizzato.

* **Questo script necessita di un controllo seguito da un'eventuale modifica al codice (righe 17 e 19) per il suo corretto funzionamento su alcune lezioni:**\
la definizione di url, infatti, deve essere modificata per alcune lezioni (si invita inoltre a fare attenzione al link, alcune lezioni non partono dall'esercizio numero 1!!).\
Cosa fare:
  * entrare nel primo esercizio della lezione `X`, della quale si vogliono ottenere i testcase;
  * cliccare col destro sul tab "Allegati" in alto e selezionare "Copia indirizzo";
  * controllare che le istruzioni alle righe 17 e 19 dello script soddisfino la "forma" del link copiato;
  * nel caso si riscontrino incongruenze è necessario modificare le definizioni di `url` alle righe 17 e 19, ad esempio:\
`url = 'http://prl1920b.dijkstra.di.unipi.it/#/task/Lez'+lez.toString()+'Es0'+es.toString()+'c81___dup/attachments';`\
non soddisfa la forma della lezione 9, che presenta il seguente link:\
`http://prl1920b.dijkstra.di.unipi.it/#/task/Lez9Es01c90/attachments`\
è necessario dunque modificare le definizioni di url (righe 17 e 19) in modo da non avere problemi:
```
[17] url = 'http://prl1920b.dijkstra.di.unipi.it/#/task/Lez'+lez.toString()+'Es0'+es.toString()+'c90/attachments';
[19] url = 'http://prl1920b.dijkstra.di.unipi.it/#/task/Lez'+lez.toString()+'Es'+es.toString()+'c90/attachments';
```
*Attenzione*: La lezione 9, in realtà, non parte da `Lez9Es01c90/attachments`, bensì da `Lez9Es00c90/attachments`. Sarà necessaria dunque una modifica ulteriore, che lascio immaginare... :)


## 2. gettests.sh
* Dato un file di testo contenente i link relativi ai testcase da scaricare, li scarica, estrae gli archivi dentro alla cartella _testcase_ corrispondente all'esercizio e rimuove gli archivi.
* #### USAGE: `bash gettests.sh X`
_dove `X` è il numero relativo alla lezione._
Si assume che siano presenti, allo stesso percorso di **gettests.sh**, il file **testzipsX.txt** (creato automaticamente dopo l'esecuzione dello script **getLinks.js**) e le cartelle di nome **lezXesY**.

## 3. tester.sh
* Serve per effettuare tutti i test di un esercizio attraverso un unico comando. Esegue, infatti, il comando diff iterativamente su ogni testcase (input-output).
* #### USAGE: `bash tester.sh [-gcc] lezXesY`
_dove `lezXesY` è la cartella relativa alla lezione numero X e l'esercizio numero Y._
Si assume che **tester.sh** sia allo stesso percorso della cartella **lezXesY**. Si assume inoltre che il file sorgente (con estensione .c) sia nominato **lezXesY.c** e sia all'interno della cartella **lezXesY**. E' possibile compilare il file sorgente direttamente dallo script grazie all'argomento **-gcc**, in caso di compilazione fallita si otterrà un messaggio di errore. Nel caso non sia presente l'argomento **-gcc**, si assume che l'eseguibile relativo all'esercizio sia nominato **output.out** e sia all'interno della cartella **lezXesY**.



### Attenzione:
Le cartelle devono essere strutturate come l'esempio mostrato più avanti. Lo script **mkesfolder.sh** permette, tramite 
`bash mkesfolder.sh X nY` di creare **ny** cartelle di nome *lezXesY* (con X numero lezione e Y da 1 a nY). Ognuna di queste nY cartelle avrà all'interno una cartella nominata "testcase".

Chiunque volesse contribuire effettuando modifiche ai codici o per qualsiasi chiarimento, anche in merito a disfunzioni, si senta libero di scrivermi.


# Esempio 1, download dei testcase della lezione 8:
L'esempio include solo gli esercizi della lezione 8, il procedimento per le altre lezioni è analogo.

**Struttura iniziale della cartella:**\
📦esercizi\
┣ 📜gettests.sh\
┣ 📜mkesfolder.sh\
┣ 📜tester.sh\
┗ 📜getLinks.js

_Primo passo:_
* Controllo su djikstra il numero di esercizi della lezione 8 e creo le cartelle tramite lo script **mkesfolder.sh**: da terminale `~/esercizi$ bash mkesfolder.sh 8 5`

**Struttura attuale della cartella:**\
📦esercizi\
┣ 📂lez8es1\
┃ ┗ 📂testcase\
┣ 📂lez8es2\
┃ ┗ 📂testcase\
┣ 📂lez8es3\
┃ ┗ 📂testcase\
┣ 📂lez8es4\
┃ ┗ 📂testcase\
┣ 📂lez8es5\
┃ ┗ 📂testcase\
┣ 📜gettests.sh\
┣ 📜mkesfolder.sh\
┣ 📜tester.sh\
┗ 📜getLinks.js

_Secondo passo:_
* Copio da djikstra il link relativo agli allegati e controllo le righe 17 e 19 del file getLinks.js (come spiegato qua: https://github.com/mikeabbott10/dijkstraUtil#1-getlinksjs )
* Da terminale: `~/esercizi$ node getLinks.js 8 5`
* E' stato dunque creato il file _testzips8.txt_. Utiliziamolo per scaricare gli archivi della lezione 8.
* Da terminale: `~/esercizi$ bash gettests.sh 8`

**Struttura attuale della cartella:**\
📦esercizi\
┣ 📂lez8es1\
┃ ┣ 📂testcase\
┃ ┃ ┣ 📜input0.txt\
┃ ┃ ┣ 📜input1.txt\
┃ ┃ ┣ 📜input2.txt\
┃ ┃ ┣ 📜input3.txt\
┃ ┃ ┣ 📜output0.txt\
┃ ┃ ┣ 📜output1.txt\
┃ ┃ ┣ 📜output2.txt\
┃ ┗ ┗ 📜output3.txt\
┣ 📂lez8es2\
┃ ┣ 📂testcase\
┃ ┃ ┣ 📜input0.txt\
┃ ┃ ┣ 📜input1.txt\
┃ ┃ ┣ 📜input2.txt\
┃ ┃ ┣ 📜input3.txt\
┃ ┃ ┣ 📜output0.txt\
┃ ┃ ┣ 📜output1.txt\
┃ ┃ ┣ 📜output2.txt\
┃ ┗ ┗ 📜output3.txt\
┣ 📂lez8es3\
┃ ┣ 📂testcase\
┃ ┃ ┣ 📜input1.txt\
┃ ┃ ┣ 📜input2.txt\
┃ ┃ ┣ 📜input3.txt\
┃ ┃ ┣ 📜output1.txt\
┃ ┃ ┣ 📜output2.txt\
┃ ┗ ┗ 📜output3.txt\
┣ 📂lez8es4\
┃ ┣ 📂testcase\
┃ ┃ ┣ 📜input0.txt\
┃ ┃ ┣ 📜input1.txt\
┃ ┃ ┣ 📜input2.txt\
┃ ┃ ┣ 📜output0.txt\
┃ ┃ ┣ 📜output1.txt\
┃ ┗ ┗ 📜output2.txt\
┣ 📂lez8es5\
┃ ┣ 📂testcase\
┃ ┃ ┣ 📜input0.txt\
┃ ┃ ┣ 📜input1.txt\
┃ ┃ ┣ 📜input2.txt\
┃ ┃ ┣ 📜input3.txt\
┃ ┃ ┣ 📜output0.txt\
┃ ┃ ┣ 📜output1.txt\
┃ ┃ ┣ 📜output2.txt\
┃ ┗ ┗ 📜output3.txt\
┣ 📜gettests.sh\
┣ 📜mkesfolder.sh\
┣ 📜tester.sh\
┣ 📜getLinks.js\
┗ 📜testzips8.txt

Abbiamo scaricato tutti i testcase relativi agli esercizi della lezione 8. Possiamo eliminare il file testzip8.txt e spostare l'attenzione su un esercizio per capire come utilizzare _tester.sh_.

# Esempio 2, utilizzo di tester.sh:
La struttura della cartella è da considerarsi uguale alla struttura che abbiamo lasciato alla fine dell'esempio 1. Ci focussiamo, stavolta, su un unico esercizio (lez8es1) sul quale useremo il tester:

**Struttura attuale della cartella:**\
📦esercizi\
┣ 📂lez8es1\
┃ ┣ 📂testcase\
┃ ┃ ┣ 📜input0.txt\
┃ ┃ ┣ 📜input1.txt\
┃ ┃ ┣ 📜input2.txt\
┃ ┃ ┣ 📜input3.txt\
┃ ┃ ┣ 📜output0.txt\
┃ ┃ ┣ 📜output1.txt\
┃ ┃ ┣ 📜output2.txt\
┃ ┗ ┗ 📜output3.txt\
┗ 📜tester.sh

* Scriviamo il codice e nominiamo il file sorgente come la cartella dentro la quale andiamo a posizionarlo, ovvero _lez8es1.c_

**Struttura attuale della cartella:**\
📦esercizi\
┣ 📂lez8es1\
┃ ┣ 📂testcase\
┃ ┃ ┣ 📜input0.txt\
┃ ┃ ┣ 📜input1.txt\
┃ ┃ ┣ 📜input2.txt\
┃ ┃ ┣ 📜input3.txt\
┃ ┃ ┣ 📜output0.txt\
┃ ┃ ┣ 📜output1.txt\
┃ ┃ ┣ 📜output2.txt\
┃ ┣ ┗ 📜output3.txt\
┃ ┃ 📜lez8es1.c\
┗ 📜tester.sh

* Proviamo il tester, da terminale: `~/esercizi$ bash tester.sh -gcc lez8es1`\
Se la compilazione è andata a buon fine è stato creato il file eseguibile _output.out_ all'interno della cartella _lez8es1_ ed è stato eseguito `diff` su ogni testcase.\
Se la compilazione non è andata a buon fine viene visualizzato un messaggio di errore (ATTENZIONE: se si utilizza la libreria math.h si consiglia di compilare e creare l'eseguibile, nominandolo _output.out_, manualmente col comando _gcc_ e l'aggiunta dell'argomento _-lm_ finale). Se si compila manualmente non è necessario l'argomento _-gcc_ e dunque il comando diventa `~/esercizi$ bash tester.sh lez8es1`

**Output dello script tester.sh**\
(viene restituito ciò che ritorna il comando `diff`):\
Buon fine:
```
(*)lez8es1/testcase/input0.txt exists. diff cmd returns:

(*)lez8es1/testcase/input1.txt exists. diff cmd returns:

(*)lez8es1/testcase/input2.txt exists. diff cmd returns:

(*)lez8es1/testcase/input3.txt exists. diff cmd returns:
```

Errore nel test 3:
```
(*)lez8es1/testcase/input0.txt exists. diff cmd returns:

(*)lez8es1/testcase/input1.txt exists. diff cmd returns:

(*)lez8es1/testcase/input2.txt exists. diff cmd returns:

(*)lez8es1/testcase/input3.txt exists. diff cmd returns:
2c2
< -2.56
\ Manca newline alla fine del file
---
> -2.56
```
