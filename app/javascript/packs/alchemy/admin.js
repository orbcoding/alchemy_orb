import { importDir } from '../../alchemy_orb/javascript/utils/importDir';

window.AlchemyOrb = importDir(require.context('../../alchemy_orb/javascript/utils', false, /(?<!archive.*).js$/))
Object.assign(window.AlchemyOrb, importDir(require.context('../../alchemy_orb/javascript/utils/admin', false, /(?<!archive.*).js$/)))

AlchemyOrb.importDir(require.context('../../alchemy/javascript/admin', true, /(?<!_archive.*).js$/));

AlchemyOrb.log('loaded alchemy_orb/alchemy/admin.js');
