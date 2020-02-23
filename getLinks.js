const puppeteer = require('puppeteer');
const fs = require('fs');

if((process.argv).length != 4){
    console.log('USAGE: node getLinks.js X nY ');
}else{
    var zipLinks = '';
    const lez = process.argv[2];
    const n_es = process.argv[3];
    (async () => {
        const browser = await puppeteer.launch();
        const page = await browser.newPage();
        var url;
        var zipLink;
        for(var es = 1; es<=n_es; es++){
        	if(es<10){
        		url = 'http://prl1920b.dijkstra.di.unipi.it/#/task/Lez'+lez.toString()+'Es0'+es.toString()+'c81___dup/attachments'; // check this link
        	}else{ // per le lezioni che contengono meno di 10 esercizi non è necessaria la modifica della riga 19.
        		url = 'http://prl1920b.dijkstra.di.unipi.it/#/task/Lez'+lez.toString()+'Es'+es.toString()+'c81___dup/attachments'; // check this link
        	}
            try{
            	await page.goto(url, { waitUntil: 'load' });
	            await page.waitForSelector('.list-group-item');
	            zipLink = await page.evaluate(() => {
	                return document.querySelector('.list-group-item').href
	            });
	            zipLinks += zipLink+'\n';
	            console.log(es.toString() + '\n');
	            await page.waitFor(2000); 
            }catch(e){
            	console.error(e);
            }
        }
        //console.log(zipLink);
        fs.writeFileSync('testzips'+lez.toString()+'.txt', zipLinks, function(err) {
            if(err) {
                return console.log(err);
            }
        });
        browser.close();
    })();
}
