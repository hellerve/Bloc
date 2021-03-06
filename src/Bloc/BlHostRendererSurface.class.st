"
I am a mediator between host space and host renderer
"
Class {
	#name : #BlHostRendererSurface,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'physicalSize',
		'dpiFactor'
	],
	#category : #'Bloc-Universe - Renderer'
}

{ #category : #accessing }
BlHostRendererSurface class >> allSurfaces [
	"Return a collection of all possible surfaces"
	<return: #Collection of: #'BlHostRendererSurface class'>

	^ self allSubclasses
]

{ #category : #testing }
BlHostRendererSurface class >> supportedBy: anObject [
	"Return true if a given object supports this surface, false otherwise"
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #initialization }
BlHostRendererSurface >> createSpaceRendererOn: anObject [
	<return: #BlHostSpaceRenderer>

	^ self subclassResponsibility
]

{ #category : #initialization }
BlHostRendererSurface >> createSurfaceRendererOn: anObject [
	<return: #BlHostSurfaceRenderer>

	^ self subclassResponsibility
]

{ #category : #geometry }
BlHostRendererSurface >> dpiFactor [
	"Return a scaling dpi factor from logical to physical coordinates.
	On high dpi (retina) displays scaling factor is > 1"
	<return: #Number>
	
	^ dpiFactor
]

{ #category : #geometry }
BlHostRendererSurface >> extent [
	"Return an actual extent of the underlying surface.
	Note: #extent may be different from canvas or window extents"
	<return: #Point>

	^ self subclassResponsibility
]

{ #category : #initialization }
BlHostRendererSurface >> initializeForHostSpace: aBlHostSpace [
	physicalSize := aBlHostSpace physicalSize.
	dpiFactor := aBlHostSpace dpiFactor
]

{ #category : #geometry }
BlHostRendererSurface >> logicalSize [
	"Returns the logical size of the host's client area.
	The client area is the content of the window, excluding the title bar and borders.
	Converting the returned LogicalSize to PhysicalSize produces the size your framebuffer should be."
	<return: #BlHostLogicalSize>

	^ self physicalSize asLogical: self dpiFactor
]

{ #category : #geometry }
BlHostRendererSurface >> physicalSize [
	"Return a physical host size which is what the framebuffer size should be.
	This size may differ from the logical size on high dpi (retina) screens.
	In most cases physical size is x2 larger than logical size on retina screens."
	<return: #BlHostPhysicalSize>

	^ physicalSize
]
