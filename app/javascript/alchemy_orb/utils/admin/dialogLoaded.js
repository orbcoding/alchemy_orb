const callbacks = []

export function dialogLoaded(selector, callback) {
	dialogOpened(dialog => {
		AlchemyOrb.whenMutated({
			selector: '.alchemy-dialog-body',
			obs: { childList: true },
			withChild: selector,
		}, ({child}) => {
			callback({child, dialog})
		})
	})
}

export function dialogOpened(callback) {
	callbacks.push(callback)

	AlchemyOrb.on('turbolinks:load', () => {
		AlchemyOrb.whenMutated({
			selector: 'body',
			obs: { childList: true },
			withChild: '.alchemy-dialog',
		}, ({child}) => {
			AlchemyOrb.log('dialog opened');
			callbacks.forEach(cb => {
				cb(child)
			})
		})
	})
}
