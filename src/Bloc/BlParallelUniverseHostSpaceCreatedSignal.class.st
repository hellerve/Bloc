"
Is sent after a host space was created and assigned to the space
"
Class {
	#name : #BlParallelUniverseHostSpaceCreatedSignal,
	#superclass : #BlParallelUniverseSpaceSignal,
	#instVars : [
		'hostSpace'
	],
	#category : #'Bloc-Universe - Parallel'
}

{ #category : #accessing }
BlParallelUniverseHostSpaceCreatedSignal class >> label [
	^ 'Create space host'
]

{ #category : #accessing }
BlParallelUniverseHostSpaceCreatedSignal class >> nextSignals [
	^ { BlParallelUniverseHostSpaceShownSignal }
]

{ #category : #accessing }
BlParallelUniverseHostSpaceCreatedSignal >> hostSpace [
	^ hostSpace
]

{ #category : #accessing }
BlParallelUniverseHostSpaceCreatedSignal >> hostSpace: anObject [
	hostSpace := anObject
]
