import 'stylesheets/application.scss';

import { importDir } from "./alchemy_orb/G/importDir";

window.AlchemyOrb = importDir(require.context('./alchemy_orb/G', true, /(?<!archive.*).js$/))

console.log('alchemy_orb/application loaded');
