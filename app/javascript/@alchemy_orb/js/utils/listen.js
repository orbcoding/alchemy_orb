import { client } from './client';

const listenerRegistry = [];
let offOnReloadListeners = [];

// off all offOnReloadListeners before turbolinks load again
on('turbolinks:visit', {}, () => {
	if (!offOnReloadListeners.length) return

	offOnReloadListeners.forEach(listener => {off(listener)});

	// AlchemyOrb.log('OffOnReloadListeners', offOnReloadListeners.map(listener => listenerDescription(listener)))
	AlchemyOrb.log('offOnReloadListeners', offOnReloadListeners.length)

	offOnReloadListeners = []
})

// Type eg: click/turbolinks:load, TODO MORE BUT also support multiple space separated
export function on(type, inputOps, // {
		// el = document, 		// Element to listen on
		// selector,					// Specify target for click/change
		// options, 					// Listener options
		// name, 							// Name of listener, if want to off({name}) without supplying listener. Can off multiple with same name!
		// runOnceFirst				// Use eg with resize if callback should run on load too
		// addOnce, 					// Dont add event twice, use together with name if listener not same variable
		// offOnReload, 			// Off on next turbolinks visit
		// offOnTrigger				// Off when event triggered
	//}
	callback) {

	const listener = Object.assign(inputOps, {
		type,
		el: inputOps.el || document,
		originalCallback: callback, // Save it so can be extended without looping itself
	})

	const listenerTypes = listener.type.split(' ')

	if (listenerTypes.length == 1) {
		// Handle and return single listener
		listener.originalType = listener.type // Save it as type can change eg click-outside => click
		return handleListener(listener)
	} else {
		// Handle and return multiple listeners
		return listenerTypes.map(t => {
			const subListener = Object.assign({}, listener)
			subListener.type = t
			subListener.originalType = t
			return handleListener(subListener)
		})
	}
}

// listener found by = { name, callback }
export function off(listener) {
	if (listenerIndex(listener) == -1) return false

	let offed = false;
	let i;
	while (i != -1) { // remove if multitype listeners with same name etc
		i = listenerIndex(listener)
		if (i != -1) {
			const rmListener = listenerRegistry[i]
			rmListener.el.removeEventListener(rmListener.type, rmListener.callback)
			listenerRegistry.splice(i, 1)
			offed = true
		}
	}

	return offed
}


// Helper functions
function handleListener(listener) {
	handleEventTypes(listener)

	listener.callback = extendCallback(listener)

	if (listener.runOnceFirst) {
		listener.callback(Object.assign(listener, listener.callbackParams()))
	}

	// Dont add new listener if add once and exists
	if (listener.addOnce && listenerIndex(listener) != -1) {
		return false
	}

	if (listener.offOnReload) {
		offOnReloadListeners.push(listener)
	}

	listener.el.addEventListener(listener.type, listener.callback, listener.options)

	listenerRegistry.push(listener)

	return listener;
}

// All event types
function handleEventTypes(listener) {
	if (listener.type == 'resize') {
		handleResize(listener)
	} else if (listener.type == 'client:hover') {
		handleClientHover(listener)
	} else if (listener.type == 'client:touch') {
		handleClientTouch(listener)
	} else if (listener.type == 'touch-inside' && listener.selector) {
		handleTouchInside(listener)
	} else if (listener.type == 'click-inside' && listener.selector) {
		handleClickInside(listener)
	} else if (listener.type == 'click-outside' && listener.selector) {
		handleClickOutside(listener)
	} else if (listener.type == 'touch-outside' && listener.selector) {
		handleTouchOutside(listener)
	} else if (listener.selector) { // Eg click/change events
		handleMatchEvent(listener)
	}

	if (!listener.callback) {
		listener.callback = e => {
			callOriginalCallback(e, listener)
		}
	}
}

// Individual event types
function handleResize(listener) {
	listener.el = window
	listener.callbackParams = () => ({
		width: document.documentElement.clientWidth,
		height: document.documentElement.clientHeight,
	})

	listener.callback = e => {
		callOriginalCallback(e, listener)
	}
}

function handleClientHover(listener) {
	if (client.hover) listener.originalCallback(listener) // Check if already set
	listener.type = 'client:hover' // Listen to any changes
}

function handleClientTouch(listener) {
	if (client.touch) listener.originalCallback(listener) // Check if already set
	listener.type = 'client:touch' // Listen to any changes
}

function handleClickInside(listener) {
	listener.type = 'click'
	listener.callback = e => {
		if (e.target.closest(listener.selector)) {
			callOriginalCallback(e, listener)
		}
	}
}

function handleTouchInside(listener) {
	listener.type = 'click'
	listener.callback = e => {
		if (e.target.closest(listener.selector)) {
			callOriginalCallback(e, listener)
		}
	}
}

function handleClickOutside(listener) {
	listener.type = 'click'
	listener.callback = e => {
		if (!e.target.closest(listener.selector)) {
			callOriginalCallback(e, listener)
		}
	}
}

function handleTouchOutside(listener) {
	listener.type = 'touchstart'
	listener.callback = e => {
		if (!e.target.closest(listener.selector)) {
			callOriginalCallback(e, listener)
		}
	}
}

function handleMatchEvent(listener) {
	listener.callback = e => {
		if (e.target.matches(listener.selector)) {
			callOriginalCallback(e, listener)
		}
	}
}


// General functions
function callOriginalCallback(e, listener) {
	let params = { el: e.target, event: e, listener }

	if (listener.callbackParams != undefined) {
		params = Object.assign(params, listener.callbackParams(e, listener))
	}

	listener.originalCallback(params)
}

// Extensions for all callbacks
function extendCallback(listener) {
	const baseCallback = listener.callback;
	return e => {
		baseCallback(e)
		if (listener.offOnTrigger) {
			off(listener)
		}
	}
}

// Finds listener based of name or callback
function listenerIndex({name, callback}) {
	return AlchemyOrb.findIndex(listenerRegistry, l =>
		name ? l.name == name :
			l.callback == callback
	);
}

// More human listener description
// function listenerDescription(listener) {
// 	return `${listener.name ? `${listener.name},` : ''}${listener.type}${listener.selector ? `,${listener.selector}` : ''}`
// }
