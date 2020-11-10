import { importDir } from './utils/importDir';

window.AlchemyOrb = importDir(require.context('./utils', false, /(?<!archive.*).js$/))
Object.assign(window.AlchemyOrb, importDir(require.context('./utils/admin', false, /(?<!archive.*).js$/)))

// All admin js
AlchemyOrb.importDir(require.context('./admin', true, /(?<!_archive.*).js$/));

AlchemyOrb.log('loaded alchemy_orb/alchemy/admin.js');
