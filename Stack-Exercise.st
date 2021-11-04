!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test Limited Stack' stamp: 'RS 11/4/2021 18:20:21'!
test11LimitedStackShouldBeEmptyWhenCreated

	| stack  |
	
	stack := OOStack withAlimit: 5.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test Limited Stack' stamp: 'RS 11/4/2021 18:21:36'!
test12PushAddsElementToLimitedStack

	| stack  |
	
	stack := OOStack withAlimit: 5.
	
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test Limited Stack' stamp: 'RS 11/4/2021 18:23:31'!
test13PopRemovesElementsFromTheLimitedStack

	| stack |
	
	stack := OOStack withAlimit: 5.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test Limited Stack' stamp: 'RS 11/4/2021 18:30:16'!
test14CanNotPushWhenTheLimitedStackIsFull

	| stack  |
	
	stack := OOStack withAlimit: 5.
	
	#('first' 'second' 'third' 'fourth' 'five') do: [:e |
		stack push: e].
	
	self
		should: [ stack push:'sixth sense' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackFullErrorDescription ]
		
! !


!OOStackTest methodsFor: 'test Stack' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test Stack' stamp: 'RS 11/4/2021 18:22:26'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test Stack' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test Stack' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test Stack' stamp: 'NR 5/13/2020 13:30:48'!
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

!OOStackTest methodsFor: 'test Stack' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test Stack' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test Stack' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test Stack' stamp: 'NR 5/13/2020 13:30:31'!
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

!OOStackTest methodsFor: 'test Stack' stamp: 'HAW 4/14/2017 22:48:44'!
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

!SentenceFinderByPrefixTest methodsFor: 'setUp/tearDown' stamp: 'RS 11/3/2021 18:20:06'!
setUp
	sentencesToPass := OrderedCollection with: 'winter is coming' with: 'winning is everything' with: 'The winds of Winter' with:'Winter is here'.
	
	sentenceFinder := SentenceFinderByPrefix with: sentencesToPass.
	! !


!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'RS 11/3/2021 18:31:29'!
test01SenteceFinderAmountEqualsToFourAfterCreation

	self assert: sentenceFinder sentencesAmount equals: 4.
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'RS 11/3/2021 18:17:52'!
test02FindASentenceByPrefixReturnsOneSentenceInOrderedCollection
	| sentences |
	
	sentences := sentenceFinder find: 'Wint'.
	
	self assert: sentences first equals: 'Winter is here'.
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'RS 11/3/2021 18:48:00'!
test03FindASentenceByPrefixReturnsMoreThanOneSentenceInOrderedCollection
	| sentencesFound sentencesShouldFound|
	
	sentencesShouldFound := OrderedCollection with: 'winter is coming' with: 'winning is everything'.
	sentencesFound := sentenceFinder find: 'win'.
	
	self assert: sentencesFound equals: 	sentencesShouldFound .
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'RS 11/3/2021 18:18:30'!
test04FindASentenceByPrefixReturnsEmptyOrderedCollectionIfNoSentenceWithPrefixFound
	| sentences |
	
	sentences := sentenceFinder find: 'fruta'.
	
	self assert: sentences size equals: 0.
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'RS 11/3/2021 18:55:28'!
test05EmptyPrefixIsInvalid

	self
		should: [ sentenceFinder find: '' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix invalidPrefixErrorDesciption ]
		

	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'RS 11/3/2021 18:55:44'!
test06PrefixWithSpacesIsInvalid
	
	self
		should: [ sentenceFinder find: 'wi nn' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix invalidPrefixErrorDesciption ]
		

	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'RS 11/3/2021 18:55:52'!
test07SentencesOfSentenceFinderDoNotChangeAfterFinding
	| sentencesContained |

	sentencesContained := sentenceFinder sentences.
	
	self assert: sentencesContained equals: sentencesToPass.
		

	! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'stack limit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'RS 11/3/2021 21:52:53'!
initialize
	stack := OrderedCollection new.
	limit := nil.! !

!OOStack methodsFor: 'initialization' stamp: 'RS 11/3/2021 21:54:00'!
initializeWithLimit: aLimit
	stack := OrderedCollection new.
	limit := aLimit.! !


!OOStack methodsFor: 'testing' stamp: 'RS 11/2/2021 18:16:02'!
isEmpty
	^(stack isEmpty)! !


!OOStack methodsFor: 'accessing' stamp: 'RS 11/3/2021 21:53:13'!
limit
	^limit! !

!OOStack methodsFor: 'accessing' stamp: 'RS 11/2/2021 18:17:35'!
size
	^stack size! !


!OOStack methodsFor: 'private' stamp: 'RS 11/4/2021 18:52:51'!
stackState
	^OOStackState with: stack aLimit: limit .
! !


!OOStack methodsFor: 'stack operations' stamp: 'RS 11/2/2021 20:02:45'!
pop
	^(self stackState) popByState .! !

!OOStack methodsFor: 'stack operations' stamp: 'RS 11/3/2021 21:44:29'!
push: something
	^(self stackState) pushByState: something .! !

!OOStack methodsFor: 'stack operations' stamp: 'RS 11/2/2021 20:09:31'!
top
	^(self stackState) topByState.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !

!OOStack class methodsFor: 'error descriptions' stamp: 'RS 11/4/2021 17:34:42'!
stackFullErrorDescription

	^'Stack is full'! !


!OOStack class methodsFor: 'class initialization' stamp: 'RS 11/3/2021 21:55:16'!
withAlimit: aLimit
	^self new initializeWithLimit: aLimit.! !


!classDefinition: #OOStackState category: 'Stack-Exercise'!
Object subclass: #OOStackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackState methodsFor: 'initialization' stamp: 'RS 11/2/2021 19:40:00'!
initializeWith: aStack
	self subclassResponsibility.! !


!OOStackState methodsFor: 'stack operations' stamp: 'RS 11/3/2021 19:41:12'!
popByState
	self subclassResponsibility.! !

!OOStackState methodsFor: 'stack operations' stamp: 'RS 11/3/2021 19:41:31'!
topByState
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackState class' category: 'Stack-Exercise'!
OOStackState class
	instanceVariableNames: ''!

!OOStackState class methodsFor: 'class initialization' stamp: 'RS 11/4/2021 19:03:54'!
with: aStack aLimit: aLimit 
	^( (self subclasses) detect: [ :aState |
		aState validateStackState: aStack withAlimit:aLimit.
		]) new initializeWith: aStack.! !


!classDefinition: #OOStackStateEmpty category: 'Stack-Exercise'!
OOStackState subclass: #OOStackStateEmpty
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackStateEmpty methodsFor: 'initialization' stamp: 'RS 11/2/2021 19:39:26'!
initializeWith: aStack
	stack := aStack! !


!OOStackStateEmpty methodsFor: 'stack operations' stamp: 'RS 11/2/2021 20:01:56'!
popByState
	self error: OOStack stackEmptyErrorDescription.! !

!OOStackStateEmpty methodsFor: 'stack operations' stamp: 'RS 11/3/2021 21:46:14'!
pushByState: something
	^stack add: something.! !

!OOStackStateEmpty methodsFor: 'stack operations' stamp: 'RS 11/2/2021 20:02:07'!
topByState
	self error: OOStack stackEmptyErrorDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackStateEmpty class' category: 'Stack-Exercise'!
OOStackStateEmpty class
	instanceVariableNames: ''!

!OOStackStateEmpty class methodsFor: 'validation' stamp: 'RS 11/4/2021 18:59:43'!
validateStackState: aStack withAlimit: aLimit 
	^aStack isEmpty.! !


!classDefinition: #OOStackStateNotEmpty category: 'Stack-Exercise'!
OOStackState subclass: #OOStackStateNotEmpty
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackStateNotEmpty methodsFor: 'initialization' stamp: 'RS 11/2/2021 19:39:16'!
initializeWith: aStack
	stack := aStack! !


!OOStackStateNotEmpty methodsFor: 'stack operations' stamp: 'RS 11/2/2021 20:01:28'!
popByState
	^stack removeLast! !

!OOStackStateNotEmpty methodsFor: 'stack operations' stamp: 'RS 11/3/2021 21:45:17'!
pushByState: something
	^stack add: something.! !

!OOStackStateNotEmpty methodsFor: 'stack operations' stamp: 'RS 11/2/2021 20:02:33'!
topByState
	^stack last.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackStateNotEmpty class' category: 'Stack-Exercise'!
OOStackStateNotEmpty class
	instanceVariableNames: ''!

!OOStackStateNotEmpty class methodsFor: 'validation' stamp: 'RS 11/4/2021 19:15:18'!
hasNoLimit: aLimit
	^(aLimit = nil).! !

!OOStackStateNotEmpty class methodsFor: 'validation' stamp: 'RS 11/4/2021 19:17:11'!
hasNotReachLimit: aStack of: aLimit  
	^((aLimit = nil)not) and: [(aStack size = aLimit)not].! !

!OOStackStateNotEmpty class methodsFor: 'validation' stamp: 'RS 11/4/2021 18:41:00'!
isNotEmpty: aStack
	^(aStack isEmpty) not.! !

!OOStackStateNotEmpty class methodsFor: 'validation' stamp: 'RS 11/4/2021 18:55:48'!
validateStackState: aStack withAlimit: aLimit 
	^(self isNotEmpty: aStack) and:[ 
		(self hasNoLimit: aLimit) or: [self hasNotReachLimit: aStack of: aLimit ] 
		] .! !


!classDefinition: #OOStackStateWithLimit category: 'Stack-Exercise'!
OOStackState subclass: #OOStackStateWithLimit
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackStateWithLimit methodsFor: 'initialization' stamp: 'RS 11/3/2021 21:42:54'!
initializeWith: aStack
	stack := aStack! !


!OOStackStateWithLimit methodsFor: 'stack operations' stamp: 'RS 11/3/2021 21:43:12'!
popByState
	^stack removeLast! !

!OOStackStateWithLimit methodsFor: 'stack operations' stamp: 'RS 11/4/2021 19:06:24'!
pushByState: something
	self error: OOStack stackFullErrorDescription .! !

!OOStackStateWithLimit methodsFor: 'stack operations' stamp: 'RS 11/3/2021 21:43:25'!
topByState
	^stack last.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackStateWithLimit class' category: 'Stack-Exercise'!
OOStackStateWithLimit class
	instanceVariableNames: ''!

!OOStackStateWithLimit class methodsFor: 'validation' stamp: 'RS 11/4/2021 18:59:35'!
validateStackState: aStack withAlimit: aLimit 
	^(aStack size = aLimit).! !


!classDefinition: #PrefixValidationState category: 'Stack-Exercise'!
Object subclass: #PrefixValidationState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!PrefixValidationState methodsFor: 'initialization' stamp: 'RS 11/3/2021 19:40:41'!
initializeWith: aPrefix
	self subclassResponsibility.! !


!PrefixValidationState methodsFor: 'prefix state actions' stamp: 'RS 11/3/2021 21:38:16'!
allowToFindOn: stackOfSentences
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PrefixValidationState class' category: 'Stack-Exercise'!
PrefixValidationState class
	instanceVariableNames: ''!

!PrefixValidationState class methodsFor: 'class initialization' stamp: 'RS 11/3/2021 20:31:00'!
with: aPrefix
	
	^((self subclasses ) detect: [:aSubclass |
		aSubclass validatePrefixState: aPrefix
		] ifNone: [PrefixValid] ) new initializeWith: aPrefix.! !


!PrefixValidationState class methodsFor: 'error descriptions' stamp: 'RS 11/4/2021 18:09:48'!
invalidPrefixErrorDesciption

	^'Prefix is invalid'! !


!classDefinition: #PrefixEmpty category: 'Stack-Exercise'!
PrefixValidationState subclass: #PrefixEmpty
	instanceVariableNames: 'prefix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!PrefixEmpty methodsFor: 'initialization' stamp: 'RS 11/3/2021 19:22:22'!
initializeWith: aPrefix
	prefix := aPrefix.! !


!PrefixEmpty methodsFor: 'prefix state actions' stamp: 'RS 11/3/2021 21:38:17'!
allowToFindOn: aSentenceFinder
	self error: self class invalidPrefixErrorDesciption.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PrefixEmpty class' category: 'Stack-Exercise'!
PrefixEmpty class
	instanceVariableNames: ''!

!PrefixEmpty class methodsFor: 'validation' stamp: 'RS 11/3/2021 19:12:08'!
validatePrefixState: aPrefix
	^(aPrefix = '')! !


!classDefinition: #PrefixValid category: 'Stack-Exercise'!
PrefixValidationState subclass: #PrefixValid
	instanceVariableNames: 'prefix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!PrefixValid methodsFor: 'initialization' stamp: 'RS 11/3/2021 19:32:10'!
initializeWith: aPrefix
	prefix := aPrefix.! !


!PrefixValid methodsFor: 'prefix state actions' stamp: 'RS 11/3/2021 21:38:17'!
allowToFindOn: aSentenceFinder
	^aSentenceFinder findWithValidPrefix: prefix.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PrefixValid class' category: 'Stack-Exercise'!
PrefixValid class
	instanceVariableNames: ''!

!PrefixValid class methodsFor: 'validation' stamp: 'RS 11/3/2021 20:30:00'!
validatePrefixState: aPrefix
	^false! !


!classDefinition: #PrefixWithSpace category: 'Stack-Exercise'!
PrefixValidationState subclass: #PrefixWithSpace
	instanceVariableNames: 'prefix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!PrefixWithSpace methodsFor: 'prefix state actions' stamp: 'RS 11/3/2021 21:38:17'!
allowToFindOn: aSentenceFinder
	self error: self class invalidPrefixErrorDesciption.! !


!PrefixWithSpace methodsFor: 'initialization' stamp: 'RS 11/3/2021 19:22:31'!
initializeWith: aPrefix
	prefix := aPrefix.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PrefixWithSpace class' category: 'Stack-Exercise'!
PrefixWithSpace class
	instanceVariableNames: ''!

!PrefixWithSpace class methodsFor: 'validation' stamp: 'RS 11/3/2021 19:12:44'!
validatePrefixState: aPrefix
	^(aPrefix anySatisfy: [:c | c = $ .]).! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stackOfSentences'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'accessing' stamp: 'RS 11/3/2021 21:33:01'!
sentences
	^self collectSentencesFromStackWithCondition: [:a | true].! !

!SentenceFinderByPrefix methodsFor: 'accessing' stamp: 'RS 11/3/2021 18:29:38'!
sentencesAmount
	^stackOfSentences size.! !


!SentenceFinderByPrefix methodsFor: 'private' stamp: 'RS 11/3/2021 21:32:24'!
collectSentencesFromStackWithCondition: aBlockCondition

	|auxiliaryStack sentencesFound sentence |

	auxiliaryStack := stackOfSentences veryDeepCopy.
	sentencesFound := OrderedCollection new.
	
	[(auxiliaryStack isEmpty)not] whileTrue: [
		sentence := auxiliaryStack pop.
		
		(aBlockCondition value: sentence ) ifTrue: [
			sentencesFound addFirst: sentence.
			].
		
		].
	^sentencesFound.	! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'RS 11/3/2021 21:32:24'!
findWithValidPrefix: aPrefix
	^ self collectSentencesFromStackWithCondition: [ :aSentence | aSentence beginsWith: aPrefix].! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'RS 11/3/2021 20:52:26'!
prefixState: aPrefix
	^(PrefixValidationState with: aPrefix).! !


!SentenceFinderByPrefix methodsFor: 'finding' stamp: 'RS 11/3/2021 21:38:17'!
find: aPrefix	
	^(self prefixState: aPrefix) allowToFindOn: self.
	! !


!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'RS 11/3/2021 18:31:09'!
initializeWith: anOrderedCollectionOfSentences
	stackOfSentences := OOStack new.
	anOrderedCollectionOfSentences do: [ :sentence |
		stackOfSentences push: sentence
		].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'RS 11/4/2021 18:10:07'!
invalidPrefixErrorDesciption

	^'Prefix is invalid'! !


!SentenceFinderByPrefix class methodsFor: 'class initialization' stamp: 'RS 11/3/2021 18:28:02'!
with: anOrderedCollectionOfSentences
	
	^self new initializeWith: anOrderedCollectionOfSentences.! !
