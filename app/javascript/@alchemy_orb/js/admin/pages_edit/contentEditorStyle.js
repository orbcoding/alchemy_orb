AlchemyOrb.contentEditorsLoaded(({editors}) => {
	const styledEditors = editors.filter(e => e.dataset.style)
	console.log(styledEditors)
})
