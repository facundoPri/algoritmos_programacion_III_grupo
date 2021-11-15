!classDefinition: #MarsRoversTests category: 'Mars-Rover-Exercise'!
TestCase subclass: #MarsRoversTests
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover-Exercise'!

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 16:38:48'!
setUp

	marsRover := MarsRover atX: 0 atY: 0 towards: 'N'.! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 16:38:48'!
test01CuandoRoverEsInicializadoConPosicionYDireccionSeEncuentraEnPosicionYDireccion

	self assert: (0 @ 0) equals: marsRover position.
	self assert: 'N' equals: marsRover direction.! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 17:16:46'!
test02CuandoRoverEsInicializadoConDireccionInvalidaNoSePuedeInicializar

	self
		should: [MarsRover atX: 0 atY: 0 towards: 'H']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText = MarsRover invalidDirectionErrorDescription ]	! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 16:38:48'!
test03ComandoFMueveRoverUnPuntoAdelante
	
	marsRover executeCommands: 'f'.
	
	self assert: (0 @ 1) equals: marsRover position.! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 16:38:48'!
test04ComandoFFMueveRoverDosPuntosAdelante

	marsRover executeCommands: 'ff'.
	
	self assert: (0 @ 2) equals: marsRover position.! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 17:47:05'!
test05ComandoBMueveRoverUnPuntoAtras

	marsRover executeCommands: 'b'.
	
	self assert: (0 @ -1) equals: marsRover position.! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 16:38:48'!
test06ComandoLRotaRoverHaciaIzquierda
	
	marsRover executeCommands: 'l'.
	
	self assert: 'O' equals: marsRover direction.! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 17:21:38'!
test07ComandoLLRRotaRoverHaciaIzquierda

	marsRover executeCommands: 'llr'.
	
	self assert: 'O' equals: marsRover direction.! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 17:49:24'!
test08ComandoLFRMueveRoverUnPuntoHaciaOeste

	marsRover executeCommands: 'lf'.
	
	self assert: 'O' equals: marsRover direction.
	self assert: (-1 @ 0) equals: marsRover position.! !

!MarsRoversTests methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 17:55:15'!
test09ComandoFFBRRFFLBMueveRoverCorrectamente

	marsRover executeCommands: 'ffbrrfflb'.
	
	self assert: 'E' equals: marsRover direction.
	self assert: (-1 @ -1) equals: marsRover position.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoversTests class' category: 'Mars-Rover-Exercise'!
MarsRoversTests class
	instanceVariableNames: 'marsRover'!


!classDefinition: #MarsRover category: 'Mars-Rover-Exercise'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover-Exercise'!

!MarsRover methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 17:20:46'!
direction
	^direction symbol! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 17:46:28'!
executeCommands: aString
	aString do: [:aValue|
		(aValue = $l) ifTrue:[
			direction := direction left
		].
		(aValue = $r) ifTrue:[
			direction := direction right
		].
		aValue = $f ifTrue:[
			position := position + direction forward.
		].
		aValue = $b ifTrue:[
			position := position + direction backward.
		].
	]
! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 15:31:05'!
initializeAt: aPoint towards: aDirectionString
	position := aPoint.
	direction := aDirectionString.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 15:32:07'!
position
	^position! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Mars-Rover-Exercise'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 17:16:25'!
atX: aSmallIntegerX atY:aSmallIntegerY towards: aDirectionString

	(#('N' 'S' 'E' 'O') anySatisfy: [:aValue| aValue = aDirectionString ]) ifFalse:[
		self class error: self invalidDirectionErrorDescription 
	].

	^self new initializeAt: ( aSmallIntegerX @ aSmallIntegerY ) towards: Norte new.! !

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 15:45:25'!
invalidDirectionErrorDescription
	^'Direccion invalida'! !


!classDefinition: #PuntoCardinalRover category: 'Mars-Rover-Exercise'!
Object subclass: #PuntoCardinalRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover-Exercise'!

!PuntoCardinalRover methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 17:46:18'!
backward
	self subclassResponsibility 
	! !

!PuntoCardinalRover methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 17:32:21'!
forward
	self subclassResponsibility 
	! !

!PuntoCardinalRover methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 17:08:39'!
left
	self subclassResponsibility 
	! !

!PuntoCardinalRover methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 17:08:45'!
right
	self subclassResponsibility ! !

!PuntoCardinalRover methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 17:18:58'!
symbol
	self subclassResponsibility ! !


!classDefinition: #Este category: 'Mars-Rover-Exercise'!
PuntoCardinalRover subclass: #Este
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover-Exercise'!

!Este methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 17:46:17'!
backward
	^(-1 @ 0)
	! !

!Este methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 17:40:34'!
forward
	^(1 @ 0)
	! !

!Este methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 17:09:40'!
left
	^Norte new! !

!Este methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 17:37:41'!
right
	^Sur new! !

!Este methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 17:18:52'!
symbol
	^'E'! !


!classDefinition: #Norte category: 'Mars-Rover-Exercise'!
PuntoCardinalRover subclass: #Norte
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover-Exercise'!

!Norte methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 17:46:17'!
backward
	^( 0 @ -1 )
	! !

!Norte methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 17:42:39'!
forward
	^( 0 @ 1 ) 
	! !

!Norte methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 17:10:44'!
left
	^Oeste new! !

!Norte methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 17:10:59'!
right
	^Este new! !

!Norte methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 17:19:07'!
symbol
	^'N'! !


!classDefinition: #Oeste category: 'Mars-Rover-Exercise'!
PuntoCardinalRover subclass: #Oeste
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover-Exercise'!

!Oeste methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 17:46:17'!
backward
	^(1 @ 0)! !

!Oeste methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 17:41:22'!
forward
	^( -1 @ 0 ) 
	! !

!Oeste methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 17:11:20'!
left
	^Sur new! !

!Oeste methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 17:11:58'!
right
	^Norte new! !

!Oeste methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 17:19:12'!
symbol
	^'O'! !


!classDefinition: #Sur category: 'Mars-Rover-Exercise'!
PuntoCardinalRover subclass: #Sur
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover-Exercise'!

!Sur methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 17:46:18'!
backward
	^( 0 @ 1 )
	! !

!Sur methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 17:55:59'!
forward
	^( 0 @ -1 )! !

!Sur methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 17:13:29'!
left
	^Este new! !

!Sur methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 17:13:07'!
right
	^Oeste new! !

!Sur methodsFor: 'as yet unclassified' stamp: 'fp 11/13/2021 17:19:18'!
symbol
	^'S'! !
