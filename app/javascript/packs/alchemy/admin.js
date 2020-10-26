import '../../stylesheets/alchemy/admin.scss';

import { importDir } from '../../alchemy_orb/utils/importDir';

window.AlchemyOrb = importDir(require.context('../../alchemy_orb/utils', false, /(?<!archive.*).js$/))
Object.assign(window.AlchemyOrb, importDir(require.context('../../alchemy_orb/utils/admin', false, /(?<!archive.*).js$/)))

AlchemyOrb.log('loaded alchemy_orb/alchemy/admin.js');
