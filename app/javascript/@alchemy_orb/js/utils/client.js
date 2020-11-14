import { actionState } from './actionState';

export const client = actionState({
	touch: {
		el: document.documentElement,
		toggleClass: 'has-touch',
	},
	hover: {
		el: document.documentElement,
		toggleClass: 'has-hover',
	},
})

function hasTouch() {
  return 'ontouchstart' in document.documentElement
         || navigator.maxTouchPoints > 0
         || navigator.msMaxTouchPoints > 0;
}

client.touch = hasTouch()
client.hover = !client.touch

// https://stackoverflow.com/a/30303898
// function watchForHover() {
//   // lastTouchTime is used for ignoring emulated mousemove events
//   let lastTouchTime = 0

//   function enableHover() {
// 		if (new Date() - lastTouchTime < 500) return
// 		client.hover = true
// 		client.touch = false
//   }

//   function disableHover() {
// 		client.hover = false
// 		client.touch = true
//   }

//   function updateLastTouchTime() {
//     lastTouchTime = new Date()
//   }

//   document.addEventListener('touchstart', updateLastTouchTime, true)
//   document.addEventListener('touchstart', disableHover, true)
//   document.addEventListener('mousemove', enableHover, true)

//   enableHover()
// }

// watchForHover()
