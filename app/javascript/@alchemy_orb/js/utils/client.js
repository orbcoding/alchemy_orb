import { actionState } from './actionState';
import { hasTouch, watchForHover, touchEvent, hoverEvent } from './client/watchForHover';

export const client = actionState({
	touch: {
		el: document.documentElement,
		toggleClass: 'client-touch',
		default: hasTouch,
		callback: ({newVal}) => { if (newVal) document.dispatchEvent(touchEvent) }
	},
	hover: {
		el: document.documentElement,
		toggleClass: 'client-hover',
		default: !hasTouch,
		callback: ({newVal}) => { if (newVal) document.dispatchEvent(hoverEvent) }
	},
})

watchForHover()




