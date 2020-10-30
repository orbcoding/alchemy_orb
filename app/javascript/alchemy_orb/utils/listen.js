// import {log} from './log';

import { contentEditorsLoaded } from "./admin/contentEditorsLoaded";

const registry = [];
let offOnReloadRegs = [];

// off all offOnReloadListeners before turbolinks load again
on('turbolinks:visit', {}, () => {
	if (!offOnReloadRegs.length) return

	offOnReloadRegs.forEach(reg => {off(reg)});

	// AlchemyOrb.log('OffOnReloadListeners', offOnReloadRegs.map(reg => listenerDescription(reg)))
	AlchemyOrb.log('offOnReloadListeners', offOnReloadRegs.length)

	offOnReloadRegs = []
})

// Type eg: click/turbolinks:load
export function on(type, {
		selector,					// Specify target for click/change
		el = document, 		// Element to listen on
		options, 					// Listener options
		runOnceFirst,     // Use eg with resize if callback should run on load too
		name, 						// Name of listener, if want to off({name}) without supplying listener
		addOnce, 					// Use together with name if listener not same variable
		offOnReload, 			// Off on next turbolinks visit
		offOnTrigger			// Off when event triggered
	}, callback) {
	let listener;

	if (type == 'resize') {
		el = window

		if (runOnceFirst) callback({
			width: document.documentElement.clientWidth,
			height: document.documentElement.clientHeight,
		})
		listener = e => {
			callback({
				event: e,
				listener,
				width: document.documentElement.clientWidth,
				height: document.documentElement.clientHeight,
			})
			if (offOnTrigger) off({el, name, listener})
		}
	} else if (selector) { // Eg click/change events
		listener = e => {
			if (e.target.matches(selector)) {
				callback({el: e.target, event: e, listener})
				AlchemyOrb.log('event triggered', listenerDescription({name, type, selector}))
			}

			if (offOnTrigger) off({name, listener})
		}
	} else {
		listener = e => {
			callback({el: e.target, event: e, listener})
			if (offOnTrigger) off({name, listener})
		}
	}

	// Dont add new listener if add once and exists
	if (addOnce && listenerIndex({name, listener}) != -1) {
		return false
	}

	const reg = {name, type, el, listener, selector}

	if (offOnReload) {
		offOnReloadRegs.push(reg)
	}

	el.addEventListener(type, listener, options)
	registry.push(reg)

	return listener;
}

// Can off based on name or listener function
export function off({el = document, name, listener}) {
	const i = listenerIndex({name, listener})

	if (i == -1) return false

	el.removeEventListener(registry[i].type, listener)
	registry.splice(i, 1)

	return true
}


// Helper function
function listenerIndex({name, listener}) {
	return AlchemyOrb.findIndex(registry, reg =>
		name ? reg.name == name :
			reg.listener == listener
	);
}

function listenerDescription(reg) {
	return `${reg.name ? `${reg.name},` : ''}${reg.type}${reg.selector ? `,${reg.selector}` : ''}`
}
