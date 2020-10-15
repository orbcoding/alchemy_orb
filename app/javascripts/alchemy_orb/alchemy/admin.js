import '../../stylesheets/alchemy/admin.scss';

import { importDir } from '../G/importDir';

window.AlchemyOrb = importDir(require.context('../G', true, /(?<!archive.*).js$/))
Object.assign(window.AlchemyOrb, importDir(require.context('../G/admin', true, /(?<!archive.*).js$/)))

console.info('alchemy_orb/alchemy/admin loaded');
