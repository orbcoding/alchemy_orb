import { on } from './listen';
import { actionState } from './actionState';

export const client = actionState({
	canHover: {
		el: document.documentElement,
		data: 'alchemy_orb-client-can-hover',
	},
})

on('turbolinks:load', { offOnTrigger: true }, () => {
	client.canHover = !window.matchMedia("(hover: none)").matches
})
