Extension { #name : #BlElement }

{ #category : #'*Bloc-Sparta' }
BlElement >> asSpartaForm [
	| aCanvas aBoundsInLocal aBoundsInParent aScaledBoundsInParent |

	self forceLayout.

	aBoundsInLocal := (self effectBounds: BlBounds new)
		merge: self boundsInLocal;
		merge: self visualBounds.

	aBoundsInParent := self localBoundsToParent: aBoundsInLocal copy.
	aScaledBoundsInParent := aBoundsInParent scaleBy: self globalScale.

	aCanvas := Bloc preferableSpartaCanvas extent: (aScaledBoundsInParent extent max: 1@1) ceiling.
	aCanvas transform
		by: [ :aTransform | aTransform scaleBy: self globalScale ]
		during: [ self drawMeAndChildrenOnSpartaCanvas: aCanvas	 ].

	^ aCanvas asForm
]

{ #category : #'*Bloc-Sparta' }
BlElement >> drawBackgroundOnSpartaCanvas: aCanvas [
	self background drawOnSpartaCanvas: aCanvas of: self
]

{ #category : #'*Bloc-Sparta' }
BlElement >> drawBorderOnSpartaCanvas: aCanvas [
	self border drawOnSpartaCanvas: aCanvas of: self
]

{ #category : #'*Bloc-Sparta' }
BlElement >> drawChildrenOnSpartaCanvas: aCanvas [

	"If there are not children no need to draw and clip"
	self hasChildren
		ifFalse: [ ^ self ].

	aCanvas clip
		when: [ self clipChildren ]
		by: [ self geometry pathOnSpartaCanvas: aCanvas ]
		during: [ self children sortedByElevation
			do: [ :anElement | anElement fullDrawOnSpartaCanvas: aCanvas ] ]
]

{ #category : #'*Bloc-Sparta' }
BlElement >> drawDebugInfoOnSpartaCanvas: aCanvas [
	| aWidth |

	aWidth := (self globalBoundsToLocal: (BlBounds origin: 0@0 extent: 1@1)) width.

	aCanvas stroke
		path: self geometryBounds;
		paint: (Color red alpha: 0.5);
		dashPattern: { aWidth * 6 . aWidth * 6 };
		width: aWidth;
		draw.

	aCanvas stroke
		path: self visualBounds;
		paint: (Color blue alpha: 0.5);
		width: aWidth;
		draw.
		
	aCanvas stroke
		path: self bounds inLocal asRectangle;
		paint: (Color gray alpha: 0.5);
		dashPattern: { aWidth * 6 . aWidth * 6 };
		width: aWidth;
		draw
]

{ #category : #'*Bloc-Sparta' }
BlElement >> drawError: anError onSpartaCanvas: aCanvas [

	aCanvas fill
		paint: Color lightGray;
		path: self boundsInLocal;
		draw.

	self drawChildrenOnSpartaCanvas: aCanvas
]

{ #category : #'*Bloc-Sparta' }
BlElement >> drawMeAndChildrenOnSpartaCanvas: aCanvas [
	self drawOnSpartaCanvas: aCanvas.
	self drawChildrenOnSpartaCanvas: aCanvas
]

{ #category : #'*Bloc-Sparta' }
BlElement >> drawMeWithEffectsOnCanvas: aCanvas [
	self effect
		applyEffectOnSpartaCanvas: aCanvas
		for: self
		around: [ :aShadowCanvas | self drawMeAndChildrenOnSpartaCanvas: aShadowCanvas ]
]

{ #category : #'*Bloc-Sparta' }
BlElement >> drawOnSpartaCanvas: aCanvas [
	| isBackgroundTransparent isBorderTransparent areBothTransparent |
	
	isBackgroundTransparent := self background isTransparent.
	isBorderTransparent := self border isTransparent.
	areBothTransparent := isBackgroundTransparent and: [ isBorderTransparent ].

	areBothTransparent
		ifTrue: [ ^ self ].

	"We create a new virtual layer in order to blend background and border only if they are both visible"
	aCanvas layer
		when: [ self outskirts wantsLayerOn: self ]
		during: [
			aCanvas
				compose: #composeSource
				when: [ self outskirts wantsLayerOn: self ]
				during: [
					self outskirts
						drawBackground: [ self drawBackgroundOnSpartaCanvas: aCanvas ]
						border: [ self drawBorderOnSpartaCanvas: aCanvas ]
						of: self
						onSpartaCanvas: aCanvas ] ]
]

{ #category : #'*Bloc-Sparta' }
BlElement >> fullDrawOnSpartaCanvas: aCanvas [
	"We do not draw transparent elements at all"
	self isTransparent
		ifTrue: [ ^ self ].

	"invisible elements are not rendered too"
	self isVisible
		ifFalse: [ ^ self ].

	aCanvas layer
		alpha: self opacity;
		when: [ self isTranslucent ]
		during: [
			aCanvas transform
				by: self transformation matrix
				translated: self position
				during: [ :aTransformedCanvas |
					self errorHandler
						with: self
						do: [
							self drawMeWithEffectsOnCanvas: aCanvas.
							misc debug ifTrue: [ self drawDebugInfoOnSpartaCanvas: aTransformedCanvas ] ]
						failed: [ :anError | self drawError: anError onSpartaCanvas: aCanvas ] ] ]
]
