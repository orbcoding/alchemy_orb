import '../stylesheets/alchemy_orb.scss';

import { importDir } from "../alchemy_orb/utils/importDir";

window.AlchemyOrb = importDir(require.context('../alchemy_orb/utils', true, /(?<!archive.*).js$/))

AlchemyOrb.log('loaded alchemy_orb.js');
