import { set } from './set';

export function actionState(stateProps
	// reactiveProp: {
	// 	selector, 			// selector
	// 	selectors, 			// selectors
	// 	el, 						// el
	// 	els, 						// els
	// 	attribute,			// eg. style.minHeight (accepts dot notation)
	// 	data 						// sets data attributes
	//  default  	  	  // default value which triggers actions
	//  defaultNoAction	// default value which doesnt trigger actions
	//  getter					// Define another getter with ({value}) param
	// 	localStorage, 	// connect to localstorage prop which will be retrieved and trigger state
	// 	toggleClass, 		// toggles class on truthy
	// 	callback 				// ({obj, el, newVal}) => {} run on value update
	//  callbackBefore  // callback before other handlers are set
	// }
) {
	const actionState = {}

	Object.keys(stateProps).forEach(prop => {
		const valueKey = `${prop}__value`;
		const props = stateProps[prop];

		// Get init value
		const initValue = props.localStorage ?
			JSON.parse(window.localStorage.getItem(props.localStorage)) :
			props.default

		Object.defineProperty(actionState, prop, {
			// Getter
			get: function() {
				if (stateProps.getter) {
					return getter({value: actionState[valueKey]})
				} else {
					return actionState[valueKey];
				}
			},

			// Setter
			set: function(newVal) {
				// TODO CLONE for array/object...
				const oldVal = this[valueKey]
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

				let el = props.el
				if (!el && props.selector) el = document.querySelector(props.selector)

				if (props.callbackBefore) {
					props.callbackBefore({obj: actionState, el, els: props.els, newVal})
				}

				els.forEach(el => {
					if (el) handleEl(el, props, newVal)
				})

				if (props.callback) {
					props.callback({obj: actionState, el, els: props.els, newVal, oldVal})
				}
			},
		});

		// Set init value
		if (props.defaultNoAction != undefined) actionState[valueKey] = props.defaultNoAction
		if (initValue != undefined) actionState[prop] = initValue
	})

	return actionState;
}

function handleEl(el, props, newVal) {
	// Set el props
	if (props.attribute) {
		set(el, props.attribute, newVal);
	}

	// Set data
	if (props.data) {
		el.setAttribute(`data-${props.data}`, newVal);
	}

	// Toggle el class
	if (props.toggleClass) {
		newVal ?
			el.classList.add(props.toggleClass) :
			el.classList.remove(props.toggleClass)
	}
}
