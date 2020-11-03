import { importDir } from "../alchemy_orb/javascript/utils/importDir";

window.AlchemyOrb = importDir(require.context('../alchemy_orb/javascript/utils', false, /(?<!archive.*).js$/))

AlchemyOrb.log('loaded alchemy_orb.js');
