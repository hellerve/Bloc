Class {
	#name : #BlVectorShape,
	#superclass : #Object,
	#instVars : [
		'parent',
		'attributes'
	],
	#classVars : [
		'CurveFromPointAttribute',
		'CurveToPointAttribute'
	],
	#category : #'Bloc-Basic-Vector Shapes'
}

{ #category : #'class initialization' }
BlVectorShape class >> initialize [
	CurveFromPointAttribute := #lineFromPoint.
	CurveToPointAttribute := #lineToPoint
]

{ #category : #enumerating }
BlVectorShape >> allParentsDetect: aBlock ifFound: ifFoundBlock ifNone: ifNoneBlock [
	self allParentsDo: [ :aParent | 
		(aBlock value: aParent)
			ifTrue: [ ^ ifFoundBlock value: aParent ] ].
	^ ifNoneBlock value
]

{ #category : #enumerating }
BlVectorShape >> allParentsDo: aBlock [
	self hasParent
		ifFalse: [ ^ self ].

	aBlock value: self parent.
	self parent allParentsDo: aBlock
]

{ #category : #enumerating }
BlVectorShape >> allShapes [
	^ Array streamContents: [ :aStream | self shapesDo: [ :each | aStream nextPut: each ] ]
]

{ #category : #converting }
BlVectorShape >> appendPathTo: aPathBuilder [
]

{ #category : #converting }
BlVectorShape >> asElementIn: aContainer [
]

{ #category : #accessing }
BlVectorShape >> attributeAt: aName [
	^ self attributes at: aName
]

{ #category : #accessing }
BlVectorShape >> attributeAt: aName ifAbsent: aValue [
	^ self attributes at: aName ifAbsent: aValue
]

{ #category : #accessing }
BlVectorShape >> attributeAt: aName ifAbsentPut: aValue [
	^ self attributes at: aName ifAbsentPut: aValue
]

{ #category : #accessing }
BlVectorShape >> attributeAt: aName put: aValue [
	self attributes at: aName put: aValue
]

{ #category : #accessing }
BlVectorShape >> attributes [
	^ attributes
]

{ #category : #converting }
BlVectorShape >> buildPathOnSpartaCanvas: aCanvas [
	| aPathBuilder |
	
	aPathBuilder := aCanvas path.
	aPathBuilder moveTo: 0@0.
	self appendPathTo: aPathBuilder.
	^ aPathBuilder finish
]

{ #category : #ui }
BlVectorShape >> gtAttributesFor: aView [
	<gtView>
	self attributes ifNil: [ ^ aView empty ].
	
	^ aView columnedList
		title: 'Attributes' translated;
		items: [ self attributes associations ];
		column: 'Name' 
			item: [ :anAssociation | anAssociation key ];
		column: 'Value' 
			item: [ :anAssociation | anAssociation value ]
]

{ #category : #ui }
BlVectorShape >> gtLiveFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Live';
		priority: 1;
		stencil: [
			| aContainer |
			
			aContainer := BlVectorShapeContainerElement new.
			aContainer constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ].
			self asElementIn: aContainer.
			aContainer ]
]

{ #category : #testing }
BlVectorShape >> hasParent [
	^ parent isNotNil
]

{ #category : #initialization }
BlVectorShape >> initialize [
	super initialize.
	
	attributes := Dictionary new
]

{ #category : #testing }
BlVectorShape >> isCurve [
	^ false
]

{ #category : #accessing }
BlVectorShape >> parent [
	<return: #BlCompositeShape>

	^ parent
]

{ #category : #accessing }
BlVectorShape >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
BlVectorShape >> parentDo: aBlock [
	self hasParent
		ifTrue: [ aBlock value: self parent ]
]

{ #category : #accessing }
BlVectorShape >> removeAttributeAt: aName [
	self attributes removeKey: aName ifAbsent: [  ]
]

{ #category : #enumerating }
BlVectorShape >> shapesDo: aBlock [
	aBlock value: self
]
