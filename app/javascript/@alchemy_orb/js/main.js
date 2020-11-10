import { importDir } from "./utils/importDir";

// Not recursive
window.AlchemyOrb = importDir(require.context('./utils', false, /(?<!archive.*).js$/))

AlchemyOrb.log('loaded alchemy_orb.js');
