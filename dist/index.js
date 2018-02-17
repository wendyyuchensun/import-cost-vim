"use strict";
exports.__esModule = true;
var import_cost_1 = require("import-cost");
var args = process.argv.slice(2);
var fileTypeArg = args[2] === 'javascript' ? import_cost_1.JAVASCRIPT : import_cost_1.TYPESCRIPT;
args.splice(2, 1, fileTypeArg);
var emitter = import_cost_1.importCost.apply(void 0, args);
emitter.on('start', function (pack) { return console.log('start'); });
