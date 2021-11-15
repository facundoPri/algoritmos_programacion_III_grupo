!classDefinition: #MarsRoversTests category: 'Mars-Rover-Exercise'!
TestCase subclass: #MarsRoversTests
	instanceVariableNames: 'marsRoverNorth marsRoverSouth'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover-Exercise'!

!MarsRoversTests methodsFor: 'tests Commands' stamp: 'fp 11/15/2021 17:02:47'!
test03ComandoFMueveRoverUnPuntoAdelante
	
	marsRoverNorth executeCommands: 'f'.
	
	self assert: (0 @ 1) equals: marsRoverNorth position.! !

!MarsRoversTests methodsFor: 'tests Commands' stamp: 'fp 11/15/2021 17:02:47'!
test04ComandoFFMueveRoverDosPuntosAdelante

	marsRoverNorth executeCommands: 'ff'.
	
	self assert: (0 @ 2) equals: marsRoverNorth position.! !

!MarsRoversTests methodsFor: 'tests Commands' stamp: 'fp 11/15/2021 17:02:47'!
test05ComandoBMueveRoverUnPuntoAtras

	marsRoverNorth executeCommands: 'b'.
	
	self assert: (0 @ -1) equals: marsRoverNorth position.! !

!MarsRoversTests methodsFor: 'tests Commands' stamp: 'fp 11/15/2021 17:02:47'!
test06ComandoLRotaRoverHaciaIzquierda
	
	marsRoverNorth executeCommands: 'l'.
	
	self assert: 'O' equals: marsRoverNorth direction.! !

!MarsRoversTests methodsFor: 'tests Commands' stamp: 'fp 11/15/2021 17:02:47'!
test07ComandoLLRRotaRoverHaciaIzquierda

	marsRoverNorth executeCommands: 'llr'.
	
	self assert: 'O' equals: marsRoverNorth direction.! !

!MarsRoversTests methodsFor: 'tests Commands' stamp: 'fp 11/15/2021 17:02:47'!
test08ComandoLFRMueveRoverUnPuntoHaciaOeste

	marsRoverNorth executeCommands: 'lf'.
	
	self assert: 'O' equals: marsRoverNorth direction.
	self assert: (-1 @ 0) equals: marsRoverNorth position.! !

!MarsRoversTests methodsFor: 'tests Commands' stamp: 'fp 11/15/2021 17:02:47'!
test09ComandoFFBRRFFLBMueveRoverCorrectamente

	marsRoverNorth executeCommands: 'ffbrrfflb'.
	
	self assert: 'E' equals: marsRoverNorth direction.
	self assert: (-1 @ -1) equals: marsRoverNorth position.! !

!MarsRoversTests methodsFor: 'tests Commands' stamp: 'fp 11/15/2021 18:07:47'!
test10ComandosSeEjecutanHastaComandoInvalidoQueTirarError
	
	self
		should: [marsRoverSouth executeCommands: 'ffxff']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText = MarsRover invalidCommandErrorDescription ]	.
	
	self assert: 'S' equals: marsRoverSouth direction.
	self assert: (0@-2) equals: marsRoverSouth  position.! !


!MarsRoversTests methodsFor: 'tests Initialization' stamp: 'fp 11/15/2021 17:02:47'!
test01CuandoRoverEsInicializadoConPosicionYDireccionSeEncuentraEnPosicionYDireccion

	self assert: (0 @ 0) equals: marsRoverNorth position.
	self assert: 'N' equals: marsRoverNorth direction.! !

!MarsRoversTests methodsFor: 'tests Initialization' stamp: 'fp 11/13/2021 17:16:46'!
test02CuandoRoverEsInicializadoConDireccionInvalidaNoSePuedeInicializar

	self
		should: [MarsRover atX: 0 atY: 0 towards: 'H']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText = MarsRover invalidDirectionErrorDescription ]	! !

!MarsRoversTests methodsFor: 'tests Initialization' stamp: 'fp 11/15/2021 17:03:47'!
test11AlPasarSurComoDireccionInicialRoverEsInicilizadoConDireccionSur	

	self assert: 'S' equals: marsRoverSouth direction.! !


!MarsRoversTests methodsFor: 'setup' stamp: 'fp 11/15/2021 17:03:27'!
setUp

	marsRoverNorth := MarsRover atX: 0 atY: 0 towards: 'N'.
	
	marsRoverSouth := MarsRover atX: 0 atY: 0 towards: 'S'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoversTests class' category: 'Mars-Rover-Exercise'!
MarsRoversTests class
	instanceVariableNames: 'marsRover'!


!classDefinition: #ComandoRover category: 'Mars-Rover-Exercise'!
Object subclass: #ComandoRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover-Exercise'!

!ComandoRover methodsFor: 'actions' stamp: 'fp 11/15/2021 18:01:02'!
beExecutedOn: aMarsRover
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ComandoRover class' category: 'Mars-Rover-Exercise'!
ComandoRover class
	instanceVariableNames: ''!

!ComandoRover class methodsFor: 'initialization' stamp: 'fp 11/15/2021 17:42:44'!
with: aCommandCharacter

	| subclassDetected |
	subclassDetected := (self subclasses) 
	detect: [:aSubclass|
		aSubclass validateInicializationValue: aCommandCharacter.] 
	ifFound:[:aSubclass| aSubclass new] 
	ifNone:[self error: self invalidCommandErrorDescription ].
	
	^subclassDetected! !


!ComandoRover class methodsFor: 'validation' stamp: 'fp 11/15/2021 17:47:16'!
validateInicializationValue: aCommandCharacter
	self subclassResponsibility 
	! !


!ComandoRover class methodsFor: 'errorDescription' stamp: 'fp 11/15/2021 17:41:36'!
invalidCommandErrorDescription
	^'Comando invalido'! !


!classDefinition: #Backward category: 'Mars-Rover-Exercise'!
ComandoRover subclass: #Backward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover-Exercise'!

!Backward methodsFor: 'actions' stamp: 'fp 11/15/2021 18:01:02'!
beExecutedOn: aMarsRover
	aMarsRover moveBackward.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Backward class' category: 'Mars-Rover-Exercise'!
Backward class
	instanceVariableNames: ''!

!Backward class methodsFor: 'validation' stamp: 'fp 11/15/2021 17:47:41'!
validateInicializationValue: aCommandCharacter
	^ aCommandCharacter = $b
	! !


!classDefinition: #Forward category: 'Mars-Rover-Exercise'!
ComandoRover subclass: #Forward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover-Exercise'!

!Forward methodsFor: 'actions' stamp: 'fp 11/15/2021 18:01:02'!
beExecutedOn: aMarsRover
	aMarsRover moveForward.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Forward class' category: 'Mars-Rover-Exercise'!
Forward class
	instanceVariableNames: ''!

!Forward class methodsFor: 'validation' stamp: 'fp 11/15/2021 17:47:50'!
validateInicializationValue: aCommandCharacter
	^ aCommandCharacter = $f
	! !


!classDefinition: #Left category: 'Mars-Rover-Exercise'!
ComandoRover subclass: #Left
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover-Exercise'!

!Left methodsFor: 'actions' stamp: 'fp 11/15/2021 18:01:02'!
beExecutedOn: aMarsRover
	aMarsRover rotateLeft.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Left class' category: 'Mars-Rover-Exercise'!
Left class
	instanceVariableNames: ''!

!Left class methodsFor: 'validation' stamp: 'fp 11/15/2021 17:47:58'!
validateInicializationValue: aCommandCharacter
	^ aCommandCharacter = $l! !


!classDefinition: #Right category: 'Mars-Rover-Exercise'!
ComandoRover subclass: #Right
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover-Exercise'!

!Right methodsFor: 'actions' stamp: 'fp 11/15/2021 18:01:02'!
beExecutedOn: aMarsRover
	aMarsRover rotateRight.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Right class' category: 'Mars-Rover-Exercise'!
Right class
	instanceVariableNames: ''!

!Right class methodsFor: 'validation' stamp: 'fp 11/15/2021 17:48:04'!
validateInicializationValue: aCommandCharacter
	^ aCommandCharacter = $r! !


!classDefinition: #MarsRover category: 'Mars-Rover-Exercise'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover-Exercise'!

!MarsRover methodsFor: 'getters' stamp: 'fp 11/13/2021 17:20:46'!
direction
	^direction symbol! !

!MarsRover methodsFor: 'getters' stamp: 'fp 11/13/2021 15:32:07'!
position
	^position! !


!MarsRover methodsFor: 'interface' stamp: 'fp 11/15/2021 18:01:02'!
executeCommands: aString
	aString do: [:aValue| | aCommand |
		aCommand := ComandoRover with: aValue.
		aCommand beExecutedOn: self.
	]
! !


!MarsRover methodsFor: 'actions' stamp: 'fp 11/15/2021 17:58:40'!
moveBackward
	position := position + direction backward.! !

!MarsRover methodsFor: 'actions' stamp: 'fp 11/15/2021 17:58:18'!
moveForward
	position := position + direction forward.! !

!MarsRover methodsFor: 'actions' stamp: 'fp 11/15/2021 17:58:55'!
rotateLeft
	direction := direction left! !

!MarsRover methodsFor: 'actions' stamp: 'fp 11/15/2021 17:59:07'!
rotateRight
	direction := direction right! !


!MarsRover methodsFor: 'initialization' stamp: 'fp 11/15/2021 17:14:32'!
initializeAt: aPoint towards: aDirection
	position := aPoint.
	direction := aDirection.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Mars-Rover-Exercise'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'initialization' stamp: 'fp 11/15/2021 18:01:52'!
atX: aSmallIntegerX atY:aSmallIntegerY towards: aDirectionString

	| aDirection |
	aDirection := PuntoCardinalRover with: aDirectionString.

	^self new initializeAt: ( aSmallIntegerX @ aSmallIntegerY ) towards: aDirection.! !


!MarsRover class methodsFor: 'errorDescription' stamp: 'fp 11/15/2021 16:35:34'!
invalidCommandErrorDescription
	^'Comando invalido'! !

!MarsRover class methodsFor: 'errorDescription' stamp: 'fp 11/15/2021 16:35:15'!
invalidDirectionErrorDescription
	^'Direccion invalida'! !


!classDefinition: #PuntoCardinalRover category: 'Mars-Rover-Exercise'!
Object subclass: #PuntoCardinalRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover-Exercise'!

!PuntoCardinalRover methodsFor: 'getters' stamp: 'fp 11/13/2021 17:46:18'!
backward
	self subclassResponsibility 
	! !

!PuntoCardinalRover methodsFor: 'getters' stamp: 'fp 11/13/2021 17:32:21'!
forward
	self subclassResponsibility 
	! !

!PuntoCardinalRover methodsFor: 'getters' stamp: 'fp 11/13/2021 17:08:39'!
left
	self subclassResponsibility 
	! !

!PuntoCardinalRover methodsFor: 'getters' stamp: 'fp 11/13/2021 17:08:45'!
right
	self subclassResponsibility ! !

!PuntoCardinalRover methodsFor: 'getters' stamp: 'fp 11/13/2021 17:18:58'!
symbol
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PuntoCardinalRover class' category: 'Mars-Rover-Exercise'!
PuntoCardinalRover class
	instanceVariableNames: ''!

!PuntoCardinalRover class methodsFor: 'initialization' stamp: 'fp 11/15/2021 16:57:29'!
with: aDirectionString

	| subclassDetected |
	subclassDetected := (self subclasses) 
	detect: [:aSubclass|
		aSubclass validateInicializationValue: aDirectionString.] 
	ifFound:[:aSubclass| aSubclass new] 
	ifNone:[self error: self invalidDirectionErrorDescription ].
	
	^subclassDetected! !


!PuntoCardinalRover class methodsFor: 'validation' stamp: 'fp 11/15/2021 16:59:23'!
validateInicializationValue: aDirectionString
	self subclassResponsibility ! !


!PuntoCardinalRover class methodsFor: 'errorDescription' stamp: 'fp 11/15/2021 16:57:09'!
invalidDirectionErrorDescription
	^'Direccion invalida'! !


!classDefinition: #Este category: 'Mars-Rover-Exercise'!
PuntoCardinalRover subclass: #Este
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover-Exercise'!

!Este methodsFor: 'getters' stamp: 'fp 11/13/2021 17:46:17'!
backward
	^(-1 @ 0)
	! !

!Este methodsFor: 'getters' stamp: 'fp 11/13/2021 17:40:34'!
forward
	^(1 @ 0)
	! !

!Este methodsFor: 'getters' stamp: 'fp 11/13/2021 17:09:40'!
left
	^Norte new! !

!Este methodsFor: 'getters' stamp: 'fp 11/13/2021 17:37:41'!
right
	^Sur new! !

!Este methodsFor: 'getters' stamp: 'fp 11/13/2021 17:18:52'!
symbol
	^'E'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Este class' category: 'Mars-Rover-Exercise'!
Este class
	instanceVariableNames: ''!

!Este class methodsFor: 'validation' stamp: 'fp 11/15/2021 16:59:42'!
validateInicializationValue: aDirectionString
	^aDirectionString = 'E'! !


!classDefinition: #Norte category: 'Mars-Rover-Exercise'!
PuntoCardinalRover subclass: #Norte
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover-Exercise'!

!Norte methodsFor: 'getters' stamp: 'fp 11/13/2021 17:46:17'!
backward
	^( 0 @ -1 )
	! !

!Norte methodsFor: 'getters' stamp: 'fp 11/13/2021 17:42:39'!
forward
	^( 0 @ 1 ) 
	! !

!Norte methodsFor: 'getters' stamp: 'fp 11/13/2021 17:10:44'!
left
	^Oeste new! !

!Norte methodsFor: 'getters' stamp: 'fp 11/13/2021 17:10:59'!
right
	^Este new! !

!Norte methodsFor: 'getters' stamp: 'fp 11/13/2021 17:19:07'!
symbol
	^'N'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Norte class' category: 'Mars-Rover-Exercise'!
Norte class
	instanceVariableNames: ''!

!Norte class methodsFor: 'validation' stamp: 'fp 11/15/2021 16:59:50'!
validateInicializationValue: aDirectionString
	^aDirectionString = 'N'! !


!classDefinition: #Oeste category: 'Mars-Rover-Exercise'!
PuntoCardinalRover subclass: #Oeste
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover-Exercise'!

!Oeste methodsFor: 'getters' stamp: 'fp 11/13/2021 17:46:17'!
backward
	^(1 @ 0)! !

!Oeste methodsFor: 'getters' stamp: 'fp 11/13/2021 17:41:22'!
forward
	^( -1 @ 0 ) 
	! !

!Oeste methodsFor: 'getters' stamp: 'fp 11/13/2021 17:11:20'!
left
	^Sur new! !

!Oeste methodsFor: 'getters' stamp: 'fp 11/13/2021 17:11:58'!
right
	^Norte new! !

!Oeste methodsFor: 'getters' stamp: 'fp 11/13/2021 17:19:12'!
symbol
	^'O'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Oeste class' category: 'Mars-Rover-Exercise'!
Oeste class
	instanceVariableNames: ''!

!Oeste class methodsFor: 'validation' stamp: 'fp 11/15/2021 16:59:58'!
validateInicializationValue: aDirectionString
	^aDirectionString = 'O'! !


!classDefinition: #Sur category: 'Mars-Rover-Exercise'!
PuntoCardinalRover subclass: #Sur
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-Rover-Exercise'!

!Sur methodsFor: 'getters' stamp: 'fp 11/13/2021 17:46:18'!
backward
	^( 0 @ 1 )
	! !

!Sur methodsFor: 'getters' stamp: 'fp 11/13/2021 17:55:59'!
forward
	^( 0 @ -1 )! !

!Sur methodsFor: 'getters' stamp: 'fp 11/13/2021 17:13:29'!
left
	^Este new! !

!Sur methodsFor: 'getters' stamp: 'fp 11/13/2021 17:13:07'!
right
	^Oeste new! !

!Sur methodsFor: 'getters' stamp: 'fp 11/13/2021 17:19:18'!
symbol
	^'S'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sur class' category: 'Mars-Rover-Exercise'!
Sur class
	instanceVariableNames: ''!

!Sur class methodsFor: 'validation' stamp: 'fp 11/15/2021 17:00:05'!
validateInicializationValue: aDirectionString
	^aDirectionString = 'S'! !
