Class {
	#name : #BlGlutinOpenGLSurfaceRenderer,
	#superclass : #BlGlutinSurfaceRenderer,
	#category : #'BlocHost-Glutin-Renderer'
}

{ #category : #initialization }
BlGlutinOpenGLSurfaceRenderer >> initializeForSurface: aSurface [
	self
		assert: [ self window isNotNil ]
		description: [ 'Window must be set!' ].

	aSurface extent: aSurface physicalSize asPoint
]

{ #category : #'host space - drawing' }
BlGlutinOpenGLSurfaceRenderer >> renderSurface: aSurface damaged: aCollectionOfRectangles [
	self makeCurrent.
	self swapBuffers
]