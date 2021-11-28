!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'portfolio portfolio1 portfolio2 account account1 account2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'fp 11/28/2021 19:08:35'!
setUp
	
	portfolio := Portfolio new.
	portfolio1 := Portfolio new.	
	portfolio2 := Portfolio new.	
	
	account := ReceptiveAccount new.
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'fp 11/28/2021 18:38:27'!
test01EmptyPortfolioHasBalanceOfZero

	
	self assert: 0 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'fp 11/28/2021 18:38:56'!
test02WhenPorfolioHasOneAccountBothBalanceAreTheSame

	
	Deposit register: 100 * peso on: account.
	portfolio addAccount: account.
	
	self assert: 100 * peso equals: portfolio balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'fp 11/28/2021 18:38:58'!
test03WhenPorfolioHasMoreThanOneAccountTheBalanceIsTheSumOfTheBalances

	
	Deposit register: 100 * peso on: account.
	Deposit register: 50 * peso on: account1.
	portfolio addAccount: account.
	portfolio addAccount: account1.
	
	self assert: 150 * peso equals: portfolio balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'fp 11/28/2021 18:38:56'!
test04ATransactionRegisteredOnAnAccountInPortfolioIsFound

	| deposit |
	deposit := Deposit register: 100 * peso on: account.

	portfolio addAccount: account.

	self assert: (portfolio hasRegistered: deposit).
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'fp 11/28/2021 18:38:56'!
test05PortfolioCantFindTransactionNotRegistered

	| deposit |
	deposit := Deposit for: 100 * peso.

	portfolio addAccount: account.

	self deny: (portfolio hasRegistered: deposit).
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'fp 11/28/2021 18:38:56'!
test06PortfolioCanReturnAllItsTransactionsWhenHasOneAccount
	
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.

	portfolio addAccount: account.

	self assert: account transactions equals: (portfolio transactions).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'fp 11/28/2021 18:39:04'!
test07PortfolioCanReturnAllItsTransactionsWhenHasTwoAccount
	
	| allTransactions |
	Deposit register: 100 * peso on: account1.
	Withdraw register: 50 * peso on: account2.

	portfolio addAccount: account1.
	portfolio addAccount: account2.
	
	allTransactions := account1 transactions.
    allTransactions addAllLast: account2 transactions.

	self assert: allTransactions equals: (portfolio transactions).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'fp 11/28/2021 18:38:56'!
test08PortofioCantAddSameAccountTwice
	
	| previousPortfolioBalance |
	Deposit register: 100 * peso on: account.
	portfolio addAccount: account.
	
	previousPortfolioBalance := portfolio balance.

	self
		should: [	portfolio addAccount: account.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText = Portfolio accountAlreadyRegisteredErrorDescription.
			self assert: previousPortfolioBalance equals: portfolio balance.
		].! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'fp 11/28/2021 18:38:56'!
test09PortfolioCantAddAnAccountRegisteredOnOneOdItsPortfolios

	
	| previousPortfolioBalance |
	Deposit register: 100 * peso on: account.
	portfolio2 addAccount: account.
	portfolio1 addAccount: portfolio2.
	
	previousPortfolioBalance := portfolio1 balance.

	self
		should: [	portfolio1 addAccount: account.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText = Portfolio accountAlreadyRegisteredErrorDescription.
			self assert: previousPortfolioBalance equals: portfolio1 balance.
		].! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'fp 11/28/2021 18:39:03'!
test10PortfolioCanAddMoreThanOnePorfolio
	
	portfolio addAccount: portfolio1.
	portfolio addAccount: portfolio2.
	
	
	Deposit register: 50 * peso on: account1.
	Deposit register: 100 * peso on: account2.
	
	portfolio1 addAccount: account1.
	portfolio2 addAccount: account2.
	
	self assert: 150 * peso equals: portfolio balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'fp 11/28/2021 18:38:27'!
test11PortfolioCantIncludeItSelf
	
	self
		should: [	portfolio addAccount: portfolio.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText = Portfolio invalidPortfolioErrorDescription.
		].! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'fp 11/28/2021 18:38:58'!
test12PortfolioCantAddPortfolioThatIncludesAnyOfItsAccounts
	
	portfolio addAccount: account1.
	portfolio1 addAccount: account1.
	
	self
		should: [	portfolio addAccount: portfolio1.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText = Portfolio accountAlreadyRegisteredErrorDescription.
		].! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'fp 11/28/2021 19:13:56'!
test13PortfolioCantAddAccountIfItsParentsHaveIt
	
	portfolio addAccount: account1.
	portfolio addAccount: portfolio1.
	
	self
		should: [portfolio1 addAccount: account1.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText = Portfolio accountAlreadyRegisteredErrorDescription.
		].! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'fp 11/28/2021 18:07:41'!
test01OnTransferDestinationAccountBalanceIncreasesAndOriginAccountBalanceDecreases

	| destinationAccount originAccount |
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	
	Transfer from: originAccount to: destinationAccount for: 100 * peso.
	
	self assert: originAccount balance equals: -100 * peso.
	self assert: destinationAccount balance equals: 100 * peso.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'fp 11/28/2021 18:16:10'!
test02CannotTransferNegativeAmount

	| destinationAccount originAccount |
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	
	self
		should: [	Transfer from: originAccount to: destinationAccount for: -100*peso.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText = Transfer invalidAmountErrorDescription.
			self assert: destinationAccount balance equals: 0*peso.
			self assert: originAccount balance equals: 0*peso.
		].! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'fp 11/23/2021 19:02:33'!
test03EachLegAnswersItsCounterparty

	| destinationAccount originAccount aTransference |
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	
	aTransference := Transfer from: originAccount to: destinationAccount for: 100*peso.
	
	self assert: (aTransference withdrawalLeg) counterparty equals: aTransference depositLeg.
	self assert: (aTransference depositLeg) counterparty equals: aTransference withdrawalLeg.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'fp 11/28/2021 18:09:36'!
test04TransferenceCanAnswerItsValue

	| destinationAccount originAccount aTransference1 aTransference2 |
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	
	aTransference1 := Transfer from: originAccount to: destinationAccount for: 100*peso.
	aTransference2 := Transfer from: originAccount to: destinationAccount for: 50*peso.
	
	self assert: 100*peso equals: aTransference1 value.
	self assert: 50*peso equals: aTransference2 value.
	! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'fp 11/28/2021 18:16:05'!
test05CannotTransferZero

	| destinationAccount originAccount |
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	
	self
		should: [	Transfer from: originAccount to: destinationAccount for: 0*peso.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: anError messageText = Transfer invalidAmountErrorDescription.
			self assert: destinationAccount balance equals: 0*peso.
			self assert: originAccount balance equals: 0*peso.
		].! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'fp 11/23/2021 18:55:24'!
transactionValue

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value counterparty'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'fp 11/21/2021 18:11:50'!
transactionValue

	^ value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #DepositLeg category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #DepositLeg
	instanceVariableNames: 'value transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!DepositLeg methodsFor: 'initialization' stamp: 'fp 11/23/2021 18:56:41'!
initializeFor: aValue

	value := aValue ! !


!DepositLeg methodsFor: 'value' stamp: 'fp 11/28/2021 18:00:19'!
counterparty

	^transfer withdrawalLeg! !

!DepositLeg methodsFor: 'value' stamp: 'fp 11/28/2021 17:58:15'!
ofTransfer: anTransfer

	transfer := anTransfer ! !

!DepositLeg methodsFor: 'value' stamp: 'fp 11/23/2021 18:56:41'!
transactionValue

	^ value! !

!DepositLeg methodsFor: 'value' stamp: 'fp 11/23/2021 18:56:41'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DepositLeg class' category: 'ServiciosFinancieros-Ejercicio'!
DepositLeg class
	instanceVariableNames: ''!

!DepositLeg class methodsFor: 'instance creation' stamp: 'fp 11/23/2021 18:56:41'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value counterparty'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'fp 11/21/2021 18:11:41'!
transactionValue

	^ value negated! !

!Withdraw methodsFor: 'value' stamp: 'fp 11/18/2021 21:36:12'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #WithdrawalLeg category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #WithdrawalLeg
	instanceVariableNames: 'value counterparty transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!WithdrawalLeg methodsFor: 'initialization' stamp: 'fp 11/23/2021 18:56:29'!
initializeFor: aValue

	value := aValue ! !


!WithdrawalLeg methodsFor: 'value' stamp: 'fp 11/28/2021 17:58:56'!
counterparty

	^transfer depositLeg! !

!WithdrawalLeg methodsFor: 'value' stamp: 'fp 11/28/2021 17:58:24'!
ofTransfer: anTransfer

	transfer := anTransfer ! !

!WithdrawalLeg methodsFor: 'value' stamp: 'fp 11/23/2021 18:56:29'!
transactionValue

	^ value negated! !

!WithdrawalLeg methodsFor: 'value' stamp: 'fp 11/23/2021 18:56:29'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WithdrawalLeg class' category: 'ServiciosFinancieros-Ejercicio'!
WithdrawalLeg class
	instanceVariableNames: ''!

!WithdrawalLeg class methodsFor: 'instance creation' stamp: 'fp 11/23/2021 18:56:29'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts parentPortfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'fp 11/23/2021 20:26:13'!
hasRegistered: aTransaction
	
	^accounts anySatisfy: [:anAccount|
		anAccount hasRegistered: aTransaction.
	]! !

!Portfolio methodsFor: 'initialization' stamp: 'fp 11/28/2021 18:57:32'!
initialize
	
	accounts := OrderedCollection new.
	parent := nil.! !


!Portfolio methodsFor: 'main protocol' stamp: 'fp 11/23/2021 19:45:29'!
balance

 	^accounts sum: [ :anAccount | 
			anAccount balance. 
	] ifEmpty:[0]! !

!Portfolio methodsFor: 'main protocol' stamp: 'fp 11/28/2021 17:16:13'!
transactions
	| allTransactions |
	allTransactions := OrderedCollection new.
	accounts do:[:anAccount|
		allTransactions addAllLast: anAccount transactions.
	].

    ^allTransactions.! !


!Portfolio methodsFor: 'associating' stamp: 'fp 11/28/2021 19:04:02'!
addAccount: anAccount 

	(parentPortfolio ~= nil and:[parentPortfolio hasAccount: anAccount]) ifTrue:[
		self error: self class accountAlreadyRegisteredErrorDescription
	].

	(self hasAccount: anAccount) ifTrue: [
		self error: self class accountAlreadyRegisteredErrorDescription
	].

	(self = anAccount) ifTrue: [
		self error: self class invalidPortfolioErrorDescription 
	].

	(anAccount isKindOf: Portfolio) ifTrue: [
		anAccount setParent: self.
	].

	accounts add: anAccount.! !


!Portfolio methodsFor: 'private' stamp: 'fp 11/28/2021 19:24:20'!
hasAccount: aReceptiveAccount 

	accounts do: [:anAccount|
		(anAccount isKindOf: Portfolio) ifTrue: [
			((anAccount hasAccount: aReceptiveAccount) or: [anAccount == aReceptiveAccount])ifTrue:[^true]
		].
		(aReceptiveAccount isKindOf: Portfolio) ifTrue: [
			((aReceptiveAccount hasAccount: anAccount ) or: [anAccount == aReceptiveAccount])ifTrue:[^true]
		]
	].

	^accounts includes: aReceptiveAccount.! !

!Portfolio methodsFor: 'private' stamp: 'fp 11/28/2021 19:01:48'!
parentPortfolio

	^parentPortfolio! !

!Portfolio methodsFor: 'private' stamp: 'fp 11/28/2021 19:01:12'!
setParent: aPortfolio

	parentPortfolio := aPortfolio 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'fp 11/24/2021 17:40:45'!
accountAlreadyRegisteredErrorDescription

	^'Account already registered'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'fp 11/24/2021 18:25:30'!
invalidPortfolioErrorDescription

	^'Invalid portfolio'! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'fp 11/21/2021 18:12:16'!
balance
	
	^transactions sum: [ :aTransaction | 
			aTransaction transactionValue 
	] ifEmpty:[0]
	! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'fp 11/25/2021 20:39:26'!
register: aTransaction

	transactions add: aTransaction.
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'fp 11/21/2021 17:57:53'!
transactions 

	^ transactions copy! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'depositLeg withdrawalLeg value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transfer methodsFor: 'as yet unclassified' stamp: 'fp 11/23/2021 19:02:41'!
depositLeg

	^depositLeg ! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'fp 11/28/2021 18:10:41'!
initializeFrom: anOriginAccount to: aDestinationAccount for: anAmount

	depositLeg := DepositLeg register: anAmount on: aDestinationAccount.
	withdrawalLeg := WithdrawalLeg register: anAmount on: anOriginAccount.
	
	depositLeg ofTransfer: self.
	withdrawalLeg ofTransfer: self.
	value := anAmount.
	

	! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'fp 11/28/2021 18:10:48'!
value

	^value.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'fp 11/23/2021 19:02:46'!
withdrawalLeg

	^withdrawalLeg ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'fp 11/28/2021 18:14:47'!
from: anOriginAccount to: aDestinationAccount for: anAmount

 	(anAmount <= 0) ifTrue:[
		self error: self invalidAmountErrorDescription.
	].
	
	^self new initializeFrom: anOriginAccount to: aDestinationAccount for: anAmount! !

!Transfer class methodsFor: 'instance creation' stamp: 'fp 11/28/2021 18:15:30'!
invalidAmountErrorDescription
	^'Invalid amount'! !
