// Goes into G
export const store = {}

// Register to track what has been added to avoid listener duplication
store.listenReg = {
	upload_optimization_select_dialog: null,
	upload_optimization_select_change: null,
}

store.listenReg.new = key => {
	if (store.listenReg[key]) return false // Already set

	store.listenReg[key] = true
	return true
}

// Seal object so all entries have to be specified here
Object.seal(store.listenReg)
