!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:48'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #Estado category: 'Stack-Exercise'!
Object subclass: #Estado
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Estado methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 19:40:00'!
initializeWith: aStack
	self subclassResponsibility.! !


!classDefinition: #EstadoNoVacio category: 'Stack-Exercise'!
Estado subclass: #EstadoNoVacio
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EstadoNoVacio methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 19:39:16'!
initializeWith: aStack
	stack := aStack! !

!EstadoNoVacio methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 19:41:17'!
pop
	^stack removeLast! !

!EstadoNoVacio methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 19:42:08'!
top
	^stack last.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EstadoNoVacio class' category: 'Stack-Exercise'!
EstadoNoVacio class
	instanceVariableNames: ''!

!EstadoNoVacio class methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 19:09:18'!
chequearTipoStack: unStack
	^(unStack isEmpty) not.! !


!classDefinition: #EstadoVacio category: 'Stack-Exercise'!
Estado subclass: #EstadoVacio
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EstadoVacio methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 19:39:26'!
initializeWith: aStack
	stack := aStack! !

!EstadoVacio methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 19:45:54'!
pop
	self error: OOStack stackEmptyErrorDescription.! !

!EstadoVacio methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 19:45:46'!
top
	self error: OOStack stackEmptyErrorDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EstadoVacio class' category: 'Stack-Exercise'!
EstadoVacio class
	instanceVariableNames: ''!

!EstadoVacio class methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 19:09:24'!
chequearTipoStack: unStack
	^unStack isEmpty.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 19:44:14'!
estados
	| unaSubclase |
	unaSubclase _( (Estado subclasses) detect: [ :a |
		a chequearTipoStack: stack
		]) new initializeWith: stack.
	^unaSubclase.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 19:05:28'!
initialize
	stack := OrderedCollection new.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 18:16:02'!
isEmpty
	^(stack isEmpty)! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 19:42:20'!
pop
	^(self estados) pop.

"	(self isEmpty) ifTrue: [
		self error: self class stackEmptyErrorDescription.].
	^stack removeLast."! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 19:27:30'!
push: something
	stack add: something.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 18:17:35'!
size
	^stack size! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 19:42:26'!
top
	^(self estados) top.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!
