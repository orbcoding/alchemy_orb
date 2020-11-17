import { actionState } from './actionState';
import { hasTouch, watchForHover, touchEvent, hoverEvent } from './client/watchForHover';

export const client = actionState({
	touch: {
		el: document.documentElement,
		default: hasTouch,
		toggleClass: 'client-touch',
		callback: ({newVal}) => { if (newVal) document.dispatchEvent(touchEvent) }
	},
	hover: {
		el: document.documentElement,
		default: !hasTouch,
		toggleClass: 'client-hover',
		callback: ({newVal}) => { if (newVal) document.dispatchEvent(hoverEvent) }
	},
})

watchForHover()




