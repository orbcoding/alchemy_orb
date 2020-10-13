const list = [];

export function on(type, selector, callback) {
	if (typeof selector === 'function') {
		document.addEventListener(type, selector)
		return selector;
	} else if (AlchemyOrb.isElement(selector)) {
		selector.addEventListener(type, callback)
		return callback
	}

	const key = `${type}>>${selector.replace(/ +/g, '>')}`

	const listener = event => {
		const el = event.target;
		console.info('on event', el);
		if (el.matches(selector)) {
			callback({el, event, listener})
		}
	}

	document.addEventListener(type, listener)

	list.push([key, listener])

	return listener;
}

export function off(listener) {
	const i = AlchemyOrb.findIndex(list, item => item[1] == listener);
	const type = list[i][0].split('>>')[0]
	document.removeEventListener(type, listener)
	list.splice(i, 1)
}
