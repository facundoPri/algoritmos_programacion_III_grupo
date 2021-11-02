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


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 19:05:28'!
initialize
	stack := OrderedCollection new.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 18:16:02'!
isEmpty
	^(stack isEmpty)! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 20:02:45'!
pop
	^(self stackState) popByState .! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 19:27:30'!
push: something
	stack add: something.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 18:17:35'!
size
	^stack size! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 20:10:37'!
stackState
	^OOStackState with: stack.
! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 20:09:31'!
top
	^(self stackState) topByState.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #OOStackState category: 'Stack-Exercise'!
Object subclass: #OOStackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackState methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 19:40:00'!
initializeWith: aStack
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackState class' category: 'Stack-Exercise'!
OOStackState class
	instanceVariableNames: ''!

!OOStackState class methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 20:10:37'!
with: aStack
	^( (self subclasses) detect: [ :aState |
		aState validateStackState: aStack
		]) new initializeWith: aStack.! !


!classDefinition: #OOStackStateEmpty category: 'Stack-Exercise'!
OOStackState subclass: #OOStackStateEmpty
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackStateEmpty methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 19:39:26'!
initializeWith: aStack
	stack := aStack! !

!OOStackStateEmpty methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 20:01:56'!
popByState
	self error: OOStack stackEmptyErrorDescription.! !

!OOStackStateEmpty methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 20:02:07'!
topByState
	self error: OOStack stackEmptyErrorDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackStateEmpty class' category: 'Stack-Exercise'!
OOStackStateEmpty class
	instanceVariableNames: ''!

!OOStackStateEmpty class methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 19:52:52'!
validateStackState: aStack
	^aStack isEmpty.! !


!classDefinition: #OOStackStateNotEmpty category: 'Stack-Exercise'!
OOStackState subclass: #OOStackStateNotEmpty
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackStateNotEmpty methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 19:39:16'!
initializeWith: aStack
	stack := aStack! !

!OOStackStateNotEmpty methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 20:01:28'!
popByState
	^stack removeLast! !

!OOStackStateNotEmpty methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 20:02:33'!
topByState
	^stack last.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackStateNotEmpty class' category: 'Stack-Exercise'!
OOStackStateNotEmpty class
	instanceVariableNames: ''!

!OOStackStateNotEmpty class methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 19:52:35'!
validateStackState: aStack
	^(aStack isEmpty) not.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'RS 11/2/2021 20:15:09'!
find: aPrefix! !
