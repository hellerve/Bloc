"
Is sent to the space when a window receives focus
"
Class {
	#name : #BlSpaceFocusInEvent,
	#superclass : #BlSpaceEvent,
	#category : #'Bloc-Events'
}

{ #category : #sending }
BlSpaceFocusInEvent >> sendTo: anObject [
	anObject spaceFocusInEvent: self
]
