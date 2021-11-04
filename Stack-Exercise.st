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
	instanceVariableNames: 'sentencesToPass sentenceFinder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'RS 11/3/2021 18:20:06'!
setUp
	sentencesToPass := OrderedCollection with: 'winter is coming' with: 'winning is everything' with: 'The winds of Winter' with:'Winter is here'.
	
	sentenceFinder := SentenceFinderByPrefix with: sentencesToPass.
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'RS 11/3/2021 18:31:29'!
test01SenteceFinderAmountEqualsToFourAfterCreation

	self assert: sentenceFinder sentencesAmount equals: 4.
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'RS 11/3/2021 18:17:52'!
test02FindASentenceByPrefixReturnsOneSentenceInOrderedCollection
	| sentences |
	
	sentences := sentenceFinder find: 'Wint'.
	
	self assert: sentences first equals: 'Winter is here'.
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'RS 11/3/2021 18:48:00'!
test03FindASentenceByPrefixReturnsMoreThanOneSentenceInOrderedCollection
	| sentencesFound sentencesShouldFound|
	
	sentencesShouldFound := OrderedCollection with: 'winter is coming' with: 'winning is everything'.
	sentencesFound := sentenceFinder find: 'win'.
	
	self assert: sentencesFound equals: 	sentencesShouldFound .
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'RS 11/3/2021 18:18:30'!
test04FindASentenceByPrefixReturnsEmptyOrderedCollectionIfNoSentenceWithPrefixFound
	| sentences |
	
	sentences := sentenceFinder find: 'fruta'.
	
	self assert: sentences size equals: 0.
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'RS 11/3/2021 18:55:28'!
test05EmptyPrefixIsInvalid

	self
		should: [ sentenceFinder find: '' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix invalidPrefixErrorDesciption ]
		

	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'RS 11/3/2021 18:55:44'!
test06PrefixWithSpacesIsInvalid
	
	self
		should: [ sentenceFinder find: 'wi nn' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix invalidPrefixErrorDesciption ]
		

	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'RS 11/3/2021 18:55:52'!
test07SentencesOfSentenceFinderDoNotChangeAfterFinding
	| sentencesContained |

	sentencesContained := sentenceFinder sentences.
	
	self assert: sentencesContained equals: sentencesToPass.
		

	! !


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

!OOStackState methodsFor: 'as yet unclassified' stamp: 'RS 11/3/2021 19:41:12'!
popByState
	self subclassResponsibility.! !

!OOStackState methodsFor: 'as yet unclassified' stamp: 'RS 11/3/2021 19:41:31'!
topByState
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


!classDefinition: #PrefixValidationState category: 'Stack-Exercise'!
Object subclass: #PrefixValidationState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!PrefixValidationState methodsFor: 'as yet unclassified' stamp: 'RS 11/3/2021 19:40:25'!
findOn: stackOfSentences
	self subclassResponsibility.! !

!PrefixValidationState methodsFor: 'as yet unclassified' stamp: 'RS 11/3/2021 19:40:41'!
initializeWith: aPrefix
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PrefixValidationState class' category: 'Stack-Exercise'!
PrefixValidationState class
	instanceVariableNames: ''!

!PrefixValidationState class methodsFor: 'as yet unclassified' stamp: 'RS 11/3/2021 19:24:27'!
invalidPrefixErrorDesciption
	^'Prefix is invalid'! !

!PrefixValidationState class methodsFor: 'as yet unclassified' stamp: 'RS 11/3/2021 20:31:00'!
with: aPrefix
	
	^((self subclasses ) detect: [:aSubclass |
		aSubclass validatePrefixState: aPrefix
		] ifNone: [PrefixValid] ) new initializeWith: aPrefix.! !


!classDefinition: #PrefixEmpty category: 'Stack-Exercise'!
PrefixValidationState subclass: #PrefixEmpty
	instanceVariableNames: 'prefix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!PrefixEmpty methodsFor: 'as yet unclassified' stamp: 'RS 11/3/2021 20:48:38'!
findOn: aSentenceFinder
	self error: self class invalidPrefixErrorDesciption.! !

!PrefixEmpty methodsFor: 'as yet unclassified' stamp: 'RS 11/3/2021 19:22:22'!
initializeWith: aPrefix
	prefix := aPrefix.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PrefixEmpty class' category: 'Stack-Exercise'!
PrefixEmpty class
	instanceVariableNames: ''!

!PrefixEmpty class methodsFor: 'as yet unclassified' stamp: 'RS 11/3/2021 19:12:08'!
validatePrefixState: aPrefix
	^(aPrefix = '')! !


!classDefinition: #PrefixValid category: 'Stack-Exercise'!
PrefixValidationState subclass: #PrefixValid
	instanceVariableNames: 'prefix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!PrefixValid methodsFor: 'as yet unclassified' stamp: 'RS 11/3/2021 20:59:09'!
findOn: aSentenceFinder
	^aSentenceFinder findWithValidPrefix: prefix.! !

!PrefixValid methodsFor: 'as yet unclassified' stamp: 'RS 11/3/2021 19:32:10'!
initializeWith: aPrefix
	prefix := aPrefix.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PrefixValid class' category: 'Stack-Exercise'!
PrefixValid class
	instanceVariableNames: ''!

!PrefixValid class methodsFor: 'as yet unclassified' stamp: 'RS 11/3/2021 20:30:00'!
validatePrefixState: aPrefix
	^false! !


!classDefinition: #PrefixWithSpace category: 'Stack-Exercise'!
PrefixValidationState subclass: #PrefixWithSpace
	instanceVariableNames: 'prefix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!PrefixWithSpace methodsFor: 'as yet unclassified' stamp: 'RS 11/3/2021 20:48:44'!
findOn: aSentenceFinder
	self error: self class invalidPrefixErrorDesciption.! !

!PrefixWithSpace methodsFor: 'as yet unclassified' stamp: 'RS 11/3/2021 19:22:31'!
initializeWith: aPrefix
	prefix := aPrefix.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PrefixWithSpace class' category: 'Stack-Exercise'!
PrefixWithSpace class
	instanceVariableNames: ''!

!PrefixWithSpace class methodsFor: 'as yet unclassified' stamp: 'RS 11/3/2021 19:12:44'!
validatePrefixState: aPrefix
	^(aPrefix anySatisfy: [:c | c = $ .]).! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stackOfSentences'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'RS 11/3/2021 20:58:05'!
find: aPrefix	
	^(self prefixState: aPrefix) findOn: self.
	! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'RS 11/3/2021 20:56:58'!
findWithValidPrefix: aPrefix
	|auxiliaryStack sentencesFound sentence |

	auxiliaryStack := OOStack new.
	sentencesFound := OrderedCollection new.
	
	[(stackOfSentences isEmpty)not] whileTrue: [
		sentence := stackOfSentences pop.
		auxiliaryStack push: sentence.
		(sentence beginsWith: aPrefix) ifTrue: [
			sentencesFound addFirst: sentence.
			].
		].
	
	[(auxiliaryStack isEmpty)not] whileTrue: [
		sentence := auxiliaryStack pop.
		stackOfSentences push: sentence.
		].
	
	^sentencesFound.	! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'RS 11/3/2021 18:31:09'!
initializeWith: anOrderedCollectionOfSentences
	stackOfSentences := OOStack new.
	anOrderedCollectionOfSentences do: [ :sentence |
		stackOfSentences push: sentence
		].
	! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'RS 11/3/2021 20:52:26'!
prefixState: aPrefix
	^(PrefixValidationState with: aPrefix).! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'RS 11/3/2021 18:45:06'!
sentences
	|stackAux sentencesFound s |
	
	stackAux := OOStack new.
	sentencesFound := OrderedCollection new.
	
	[(stackOfSentences isEmpty)not] whileTrue: [
		s := stackOfSentences pop.
		stackAux push: s.
		sentencesFound addFirst: s.
		].
	[(stackAux isEmpty)not] whileTrue: [
		s := stackAux pop.
		stackOfSentences push: s.
		].
	
	^sentencesFound.! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'RS 11/3/2021 18:29:38'!
sentencesAmount
	^stackOfSentences size.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'RS 11/3/2021 18:52:59'!
invalidPrefixErrorDesciption
	^'Prefix is invalid'! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'RS 11/3/2021 18:28:02'!
with: anOrderedCollectionOfSentences
	
	^self new initializeWith: anOrderedCollectionOfSentences.! !
