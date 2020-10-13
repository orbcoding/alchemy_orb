console.info('alchemy_orb/alchemy/admin loaded');

import { importDir } from '../G/importDir';

window.AlchemyOrb = importDir(require.context('../G', true, /(?<!archive.*).js$/))
window.AlchemyOrb = importDir(require.context('../G/admin', true, /(?<!archive.*).js$/))
