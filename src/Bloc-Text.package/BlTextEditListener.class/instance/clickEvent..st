mouse handlers
clickEvent: anEvent
	| aTextEditElement aClickPosition |

	aTextEditElement := anEvent currentTarget.
	aTextEditElement requestFocus.
	
	true"anEvent modifiers isCmd"
		ifFalse: [ aTextEditElement removeCursors ].

	aClickPosition := aTextEditElement globalPointToLocal: anEvent position.
	self addCursorAtPosition: aClickPosition in: aTextEditElement