import { client } from '../client';

// https://stackoverflow.com/a/30303898
export function watchForHover() {
  // lastTouchTime is used for ignoring emulated mousemove events
  let lastTouchTime = 0

  function enableHover() {
		if (new Date() - lastTouchTime < 500) return
		if (!client.hover) client.hover = true
		if (client.touch) client.touch = false
  }

  function enableTouch() {
		if (client.hover) client.hover = false
		if (!client.touch) client.touch = true
  }

  function updateLastTouchTime() {
    lastTouchTime = new Date()
  }

  document.addEventListener('touchstart', updateLastTouchTime, true)
  document.addEventListener('touchstart', enableTouch, true)
  document.addEventListener('mousemove', enableHover, true)
}

// Events fired when client touching or hovering
// Dont use these internal events. use on('client:touch/hover') instead
export const touchEvent = new CustomEvent("client:touch", { "detail": "Custom AlchemyOrb event" });
export const hoverEvent = new CustomEvent("client:hover", { "detail": "Custom AlchemyOrb event" });
// export const hasTouch = 'ontouchstart' in document.documentElement
//   || navigator.maxTouchPoints > 0
//   || navigator.msMaxTouchPoints > 0;

