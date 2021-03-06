Class {
	#name : #BlSpartaBufferSpaceRenderer,
	#superclass : #BlSpartaSpaceRenderer,
	#category : #'Bloc-Sparta-Renderer'
}

{ #category : #initialization }
BlSpartaBufferSpaceRenderer >> initializeForSurface: aSurface [
	"Initalize sparta canvas to be used with a given surface"
	| aSpartaCanvas |

	aSpartaCanvas := (BlSpartaRenderer pickCanvasForSurface: aSurface) forBufferOn: aSurface.
	self
		initializeCanvas: aSpartaCanvas
		surface: aSurface
]
