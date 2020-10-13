import { set } from './set';

export function reactiveProp(inputreactiveProps
	// reactiveProp: {
	// 	selector: null, // selector
	// 	selectors: null, // selectors
	// 	el: null, // el
	// 	els: null, // els
	// 	prop: null, // dataset.someprop
	//  default: null // default value which triggers reactiveProp
	// 	localStorage: null, // connect to localstorage prop
	// 	toggleClass: null, // toggles class on truthy
	// 	callback: null // ({obj, el, newVal}) => {} run on value update
	// }
) {
	const reactiveProps = {}

	Object.keys(inputreactiveProps).forEach(reactiveProp => {
		const valueKey = `${reactiveProp}__value`;
		const props = inputreactiveProps[reactiveProp];

		// Get init value
		const initValue = props.localStorage ?
			JSON.parse(window.localStorage.getItem(props.localStorage)) :
			props.default

		Object.defineProperty(reactiveProps, reactiveProp, {
			// Getter
			get: function() {
				return reactiveProps[valueKey];
			},

			// Setter
			set: function(newVal) {
				this[valueKey] = newVal

				// Localstorage
				if (props.localStorage) {
					if (newVal) {
						window.localStorage.setItem(props.localStorage, JSON.stringify(newVal));
					} else {
						window.localStorage.removeItem(props.localStorage);
					}
				}

				// Get element
				const els = []
				if (props.selector) els.push(document.querySelector(props.selector))
				if (props.selectors) els.push(...document.querySelectorAll(props.selectors))
				if (props.el) els.push(props.el)
				if (props.els) els.push(props.els)

				els.forEach(el => {
					if (el) handleEl(el, props, newVal)
				})

				if (props.callback) {
					props.callback({obj: reactiveProps, el: props.el, els: props.els, newVal})
				}
			},
		});

		// Set init value
		if (initValue != undefined) reactiveProps[reactiveProp] = initValue
	})

	return reactiveProps;
}

function handleEl(el, props, newVal) {
	// Set el props
	if (props.prop) {
		set(el, props.prop, newVal);
	}

	// Toggle el class
	if (props.toggleClass) {
		newVal ?
			el.classList.add(props.toggleClass) :
			el.classList.remove(props.toggleClass)
	}
}
