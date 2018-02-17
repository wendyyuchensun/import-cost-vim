import { importCost, JAVASCRIPT, TYPESCRIPT } from 'import-cost';

const args: String[] = process.argv.slice(2);

const fileTypeArg: JAVASCRIPT | TYPESCRIPT = args[2] === 'javascript' ? JAVASCRIPT : TYPESCRIPT;
args.splice(2, 1, fileTypeArg);

const emitter = importCost(...args);

emitter.on('start', pack => console.log('start'));
emitter.on('calculated', pack => console.log(pack.size));
emitter.on('done', pack => console.log(pack.size));
