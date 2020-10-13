export function whenMutated({el, selector, obs, withChild, disconnect}, callback) {
	const defaultObs = {
		attributes: false,
		characterData: false,
		childList: false,
		subtree: false,
		attributeOldValue: false,
		characterDataOldValue: false
	}

	const element = el || document.querySelector(selector)

	const observe = Object.assign(defaultObs, obs);

	const observer = new MutationObserver(function(mutations) {
		if (withChild) {
			const child = element.querySelector(withChild)

			if (child) {
				if (disconnect) observer.disconnect()
				callback({element, child, observer, mutations})
			}
		} else {
			if (disconnect) observer.disconnect()
			callback({element, mutations, observer});
		}
	});

	observer.observe(element, observe);
}
