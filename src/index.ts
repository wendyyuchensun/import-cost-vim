import { importCost, JAVASCRIPT, TYPESCRIPT } from 'import-cost';

const fs = require('fs');

const args: String[] = process.argv.slice(2);
const fileTypeArg: JAVASCRIPT | TYPESCRIPT = args[1] === 'js' ? JAVASCRIPT : TYPESCRIPT;
const fileContents = fs.readFileSync(args[0], 'utf8'); 

args.splice(1, 1, fileContents, fileTypeArg);

const emitter = importCost(...args);

emitter.on('done', pack => console.log(pack));
