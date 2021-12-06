!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio2'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio2'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:00'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:06'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:12'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:18'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:26'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:08'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 * peso on: account.
	anotherAccountWithdraw := Withdraw register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 11/29/2021 18:55:37'!
test12PortfolioCanNotIncludeItself

	| simplePortfolio |
	
	simplePortfolio := Portfolio new.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 0 equals: simplePortfolio accountsSize. ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'RS 12/3/2021 16:35:03'!
test16PortfolioCanBeCreatedWithAName

	| johnsAccount angiesAccount childrenPortfolio |
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'. 
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'. 
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount.
	
	self assert: 'Portfolio de hijos' equals: childrenPortfolio accountName.! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio2'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio2'!

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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'RS 12/3/2021 16:33:07'!
test08AccountCanBeCreatedWithAName

	| johnsAccount |
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	
	self assert: 'Cuenta de Juan' equals: johnsAccount accountName.! !


!classDefinition: #ReportTest category: 'ServiciosFinancieros-Ejercicio2'!
TestCase subclass: #ReportTest
	instanceVariableNames: 'anAccount1 anAccount2 emptyPortfolio1 portfolioWithTwoAccounts emptyNamedPortfolio portfolioWithPortfolio portfolioWithPortfolioWithPortfolio anAccount3 portfolioWithAccount portfolioWithEmptyPortfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio2'!

!ReportTest methodsFor: 'test' stamp: 'RS 12/3/2021 15:41:11'!
test01AccountWithoutTransactionsItsSummaryIsEmpty

	| aSummary |
	aSummary := AccountSummary of: anAccount1.
	self assert: 'Balance = 0 pesos' equals:  (aSummary create at: 1).
	! !

!ReportTest methodsFor: 'test' stamp: 'RS 12/3/2021 15:41:11'!
test02AccountWithOneDepositTransacrtionSummaryReturnsTransactionAndBalance
	
	| aSummary |
	Deposit register: 100 * peso on: anAccount1 .

	aSummary := (AccountSummary of: anAccount1) create.
	
	self assert: 'Depósito por 100 pesos' equals: (aSummary at: 1 ).
	self assert: 'Balance = 100 pesos' equals: (aSummary at: 2 )
! !

!ReportTest methodsFor: 'test' stamp: 'RS 12/3/2021 15:41:11'!
test03AccountWithOneWithdrawTransacrtionSummaryReturnsTransactionAndBalance
	
	| aSummary |

	Withdraw register: 50 * peso on: anAccount1 .
	aSummary := (AccountSummary of: anAccount1) create .
	
	self assert: (aSummary at: 1 ) equals: 'Extracción por 50 pesos'.
	self assert: (aSummary at: 2) equals: 'Balance = -50 pesos' 
! !

!ReportTest methodsFor: 'test' stamp: 'RS 12/3/2021 15:41:11'!
test04AccountWithOneTransferDepositLegTransactionSummaryReturnsTransactionAndBalance

	| aSummary |
	Transfer amount: 50 * peso from: anAccount1 to: anAccount2.
	aSummary := (AccountSummary of: anAccount2) create.
	
	self assert: 'Entrada por transferencia de 50 pesos' equals: (aSummary at: 1).
	self assert: 'Balance = 50 pesos' equals: (aSummary at: 2).  
! !

!ReportTest methodsFor: 'test' stamp: 'RS 12/3/2021 15:41:11'!
test05AccountWithOneTransferWithdrawLegTransactionSummaryReturnsTransactionAndBalance

	| aSummary |
	Transfer amount: 50 * peso from: anAccount1 to: anAccount2.
	aSummary := (AccountSummary of: anAccount1) create.
	self assert: 'Salida por transferencia de 50 pesos' equals: (aSummary at: 1).
	self assert: 'Balance = -50 pesos' equals: (aSummary at: 2).  
! !

!ReportTest methodsFor: 'test' stamp: 'RS 12/4/2021 21:16:55'!
test06AccountWithMultipleTransactionSummaryReturnsTransactionsAndBalance

	| messages aSummary |
	Deposit register: 100 * peso on: anAccount1.
	Withdraw register: 50 * peso on: anAccount1.
	Transfer amount: 20 * peso from: anAccount1 to: anAccount2.
	Transfer amount: 30 * peso from: anAccount2 to: anAccount1.
	
	aSummary := (AccountSummary of: anAccount1) create.
	messages := #( 'Depósito por 100 pesos' 'Extracción por 50 pesos' 'Salida por transferencia de 20 pesos' 'Entrada por transferencia de 30 pesos' 'Balance = 60 pesos').
	
	self assertOnMessages: messages withAReport: aSummary.! !

!ReportTest methodsFor: 'test' stamp: 'RS 12/3/2021 15:41:11'!
test07AccountWithoutTransfersHasZeroAsTransferNet
	
	| aTransferNet |
	aTransferNet := TransferNet of: anAccount1.
		
	self assert: 0 equals: aTransferNet create..! !

!ReportTest methodsFor: 'test' stamp: 'RS 12/3/2021 15:41:11'!
test08AccountWithATransferDepositsHasItsValueAsTransferNet
	
	| anAmount aTransferNet |
	anAmount := 100 * peso.
	Transfer amount: anAmount from: anAccount2 to: anAccount1.

	aTransferNet := TransferNet of: anAccount1.
	
	self assert: anAmount equals: aTransferNet create.! !

!ReportTest methodsFor: 'test' stamp: 'RS 12/3/2021 15:41:11'!
test09AccountWithATransferWithdrawaltsHasItsValueAsTransferNet
	
	| anAmount aTransferNet |
	anAmount := 100 * peso.
	Transfer amount: anAmount from: anAccount2 to: anAccount1.
	aTransferNet := TransferNet of: anAccount2.

	self assert: anAmount negated equals: aTransferNet create ! !

!ReportTest methodsFor: 'test' stamp: 'RS 12/3/2021 15:41:11'!
test10AccountWithMultipleTransfersHasATransferNet
	
	| aTransferNet |
	Transfer amount: 10*peso from: anAccount2 to: anAccount1.
	Transfer amount: 20*peso from: anAccount1 to: anAccount2.
	Transfer amount: 1*peso from: anAccount1 to: anAccount2.
	Transfer amount: 50*peso from: anAccount2 to: anAccount1.
	aTransferNet := TransferNet of: anAccount1.
	self assert: 39*peso equals: aTransferNet create.! !

!ReportTest methodsFor: 'test' stamp: 'RS 12/4/2021 18:17:49'!
test11WhenPortfolioHasNoChildAccountsAndNoNamePortfolioTreePrinterReturnsDefaultName
	
	| aReport |
	aReport := (PortfolioTreePrinter of: emptyPortfolio1) create.
	self assert: emptyPortfolio1 name equals:  (aReport at: 1).! !

!ReportTest methodsFor: 'test' stamp: 'RS 12/4/2021 18:17:57'!
test12WhenPortfolioHasNoChildAccountsPortfolioTreePrinterReturnsOnlyItsName
	
	| aReport |
	aReport := (PortfolioTreePrinter of: emptyNamedPortfolio ) create.
	self assert: 'Portfolio de la familia' equals:  (aReport at: 1).! !

!ReportTest methodsFor: 'test' stamp: 'RS 12/4/2021 21:05:33'!
test13WhenPortfolioHasOneAccountNamedAndOneUnnamedPortfolioTreePrinterReturnsTheirNames
	
	| aReport |
	aReport := (PortfolioTreePrinter of: portfolioWithTwoAccounts ) create.
	
	self assert: portfolioWithTwoAccounts accountName equals:  (aReport at: 1).
	self assert: '     ',anAccount1 accountName equals:  (aReport at: 2).
	self assert: '     ',anAccount2 accountName equals:  (aReport at: 3).! !

!ReportTest methodsFor: 'test' stamp: 'RS 12/4/2021 21:05:33'!
test14WhenPortfolioHasOnePortfoliPortfolioTreePrinterReturnsItsNamesWithATreeStructure
	
	| aReport |
	aReport := (PortfolioTreePrinter of: portfolioWithPortfolio) create.
	
	self assert: portfolioWithPortfolio accountName equals:  (aReport at: 1).
	self assert: '     ',portfolioWithTwoAccounts accountName equals:  (aReport at: 2).
	self assert: '     ','     ',anAccount1 accountName equals:  (aReport at: 3).
	self assert: '     ','     ',anAccount2 accountName equals:  (aReport at: 4).! !

!ReportTest methodsFor: 'test' stamp: 'RS 12/4/2021 21:05:33'!
test15PortfolioTreeIsRenderedProperlyByPortfolioTreePrinter
	
	| aReport |
	aReport := (PortfolioTreePrinter of: portfolioWithPortfolioWithPortfolio) create.
	
	self assert: portfolioWithPortfolioWithPortfolio accountName equals:  (aReport at: 1).
	self assert: '     ',portfolioWithPortfolio accountName equals:  (aReport at: 2).
	self assert: '     ','     ',portfolioWithTwoAccounts accountName equals:  (aReport at: 3).
	self assert: '     ','     ','     ',anAccount1 accountName equals:  (aReport at: 4).
	self assert: '     ','     ','     ',anAccount2 accountName equals:  (aReport at: 5).
	self assert: '     ',anAccount3 accountName equals:  (aReport at: 6).! !

!ReportTest methodsFor: 'test' stamp: 'RS 12/4/2021 21:00:18'!
test16WhenPortfolioIsEmptyPortfolioDetailedTreeReturnNameAndBalance

	| aReport |
	aReport := (PortfolioDetailedTreePrinter of: emptyNamedPortfolio) create.
	
	self assert: emptyNamedPortfolio accountName equals:  (aReport at: 1).
	self assert: '     ','Balance = 0 pesos' equals:  (aReport at: 2).! !

!ReportTest methodsFor: 'test' stamp: 'RS 12/4/2021 20:58:18'!
test17WhenPortfolioHasOneAccountPortfolioDetailedTreePrinterReturnsNameAccountSummaryAndBalance

	| aReport |
	aReport := (PortfolioDetailedTreePrinter of: portfolioWithAccount) create.
	
	self assert: portfolioWithAccount accountName equals:  (aReport at: 1).
	self assert: '     ',anAccount1 accountName equals:  (aReport at: 2).
	self assert: '     ','     ','Balance = 0 pesos' equals:  (aReport at: 3).
	self assert: '     ','Balance = 0 pesos' equals:  (aReport at: 4).! !

!ReportTest methodsFor: 'test' stamp: 'RS 12/4/2021 21:27:48'!
test18WhenPortfolioHasMultipleReceptiveAccountSPortfolioDetailedTreePrinterReturnsNameAccountSummaryAndBalance

	| aReport messages |

	Transfer amount: 20 * peso from: anAccount1 to: anAccount2.
	Transfer amount: 30 * peso from: anAccount2 to: anAccount1.
	
	aReport := (PortfolioDetailedTreePrinter of: portfolioWithTwoAccounts) create.
	messages := OrderedCollection new.
	messages 
		add: portfolioWithTwoAccounts accountName;
		add: '     ',anAccount1 accountName;
		add: '     ','     ','Salida por transferencia de 20 pesos';
		add: '     ','     ','Entrada por transferencia de 30 pesos';	
		add: '     ','     ','Balance = 10 pesos';
		add: '     ',anAccount2 accountName;
		add: '     ','     ','Entrada por transferencia de 20 pesos';
		add: '     ','     ','Salida por transferencia de 30 pesos';	
		add: '     ','     ','Balance = -10 pesos';
		add: '     ','Balance = 0 pesos'.
		
	self assertOnMessages: messages withAReport: aReport.! !

!ReportTest methodsFor: 'test' stamp: 'RS 12/5/2021 12:15:01'!
test19WhenPortfolioHasOnePortfolioPortfolioDetailedTreePrinterReturnsTheirNamesAndBalance

	| aReport messages |
	
	aReport := (PortfolioDetailedTreePrinter of: portfolioWithEmptyPortfolio) create.
	messages := OrderedCollection new.
	messages 
		add: portfolioWithEmptyPortfolio accountName;
		add: '     ',emptyPortfolio1 accountName;
		add: '     ','     ','Balance = 0 pesos';
		add: '     ','Balance = 0 pesos'.
		
	self assertOnMessages: messages withAReport: aReport.! !

!ReportTest methodsFor: 'test' stamp: 'RS 12/5/2021 12:36:13'!
test20AccountSummaryCantRecieveAPortfolio

	self 
		should: [ AccountSummary of: emptyPortfolio1 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: AccountSummary canNotRecievePortfolioErrorMessage equals: anError messageText.
			]! !

!ReportTest methodsFor: 'test' stamp: 'RS 12/5/2021 12:35:25'!
test21PortfolioTreePrinterCantRecieveAReceptiveAccount

	self 
		should: [ PortfolioTreePrinter of: anAccount1]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: PortfolioTreePrinter canNotRecieveReceptiveAccountErrorMessage equals: anError messageText.
			]! !

!ReportTest methodsFor: 'test' stamp: 'RS 12/5/2021 12:36:49'!
test22PortfolioDetailedTreePrinterCantRecieveAReceptiveAccount

	self 
		should: [ PortfolioDetailedTreePrinter of: anAccount1]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: PortfolioDetailedTreePrinter canNotRecieveReceptiveAccountErrorMessage equals: anError messageText.
			]! !

!ReportTest methodsFor: 'test' stamp: 'RS 12/5/2021 12:39:45'!
test23WhenPortfolioHasOnePortfolioWithAccountPortfolioDetailedTreePrinterReturnsTheirNamesTheAccountSummaryAndBalance

	| aReport messages |
	
	aReport := (PortfolioDetailedTreePrinter of: portfolioWithPortfolio ) create.
	messages := OrderedCollection new.
	messages 
		add: portfolioWithPortfolioWithPortfolio accountName;
		add: '     ',emptyPortfolio1 accountName;
		add: '     ','     ','Balance = 0 pesos';
		add: '     ','Balance = 0 pesos'.
		
	self assertOnMessages: messages withAReport: aReport.! !


!ReportTest methodsFor: 'setup' stamp: 'RS 12/4/2021 21:35:23'!
setUp

	anAccount1 := ReceptiveAccount named: 'Cuenta mia'.
	anAccount2 := ReceptiveAccount new.
	anAccount3 := ReceptiveAccount new.
	
	emptyPortfolio1 := Portfolio new.
	emptyNamedPortfolio := Portfolio named: 'Portfolio de la familia'.
	
	portfolioWithEmptyPortfolio := Portfolio named: 'Portfolio with one account' with: emptyPortfolio1.
	portfolioWithAccount := Portfolio named: 'Portfolio with one account' with: anAccount1.
	portfolioWithTwoAccounts := Portfolio named: 'Portfolio with two accounts' with: anAccount1 with: anAccount2.
	portfolioWithPortfolio := Portfolio named: 'Portfolio de la familia' with: portfolioWithTwoAccounts.
	portfolioWithPortfolioWithPortfolio := Portfolio with: portfolioWithPortfolio with: anAccount3.! !


!ReportTest methodsFor: 'soporte' stamp: 'RS 12/4/2021 21:43:39'!
assertOnMessages: anArray withAReport: aSummary

	anArray inject: 1 into: [:index :each |
		self assert: each equals: (aSummary at: index).
		index + 1.
	].! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Ejercicio2'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio2'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:07:03'!
test01ATransferDecreasesBalanceFromOriginAccountAndIncreasesItForDestinationAccount

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 8 * peso equals: originAccount balance.
	self assert: 12 * peso equals: destinationAccount balance.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:12:28'!
test02ATransferKnowsItsValue

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 2 * peso equals: transfer value.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:44'!
test03DepositLegKnowsItsWithdrawCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:51'!
test04WithdrawLegKnowsItsDepositCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:36'!
test05OriginAndDestinationAccountsCannotBeTheSame

	| originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	self should: [ Transfer amount: 2 * peso from: originAccount to: originAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToOriginErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:44'!
test06CannotTransferAZeroAmount

	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 5 * peso on: destinationAccount.
	
	self should: [ Transfer amount: 0 from: originAccount to: destinationAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferZeroErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !


!classDefinition: #Account category: 'ServiciosFinancieros-Ejercicio2'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio2'!

!Account methodsFor: 'main protocol' stamp: 'RS 12/3/2021 16:44:10'!
accountName
	
	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:45:50'!
addedTo: aPortfolio

	self subclassResponsibility! !

!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:46:48'!
isComposedBy: anAccount

	self subclassResponsibility! !


!Account methodsFor: 'private' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio2'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio2'!

!Portfolio methodsFor: 'initialization' stamp: 'RS 12/3/2021 17:05:34'!
initialize
	name := self name.
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'main protocol' stamp: 'RS 12/5/2021 12:13:31'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 * peso ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'RS 12/4/2021 18:40:33'!
beAddedToReport: aReport

	^accounts do: [:each |
		each beAddedToReport: aReport
		]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'accounts management' stamp: 'RS 12/3/2021 16:44:01'!
accountName

	^name! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'RS 12/3/2021 16:43:15'!
assignName: aName 
	
	name := aName.! !


!Portfolio methodsFor: 'private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'private' stamp: 'RS 12/3/2021 17:29:20'!
iterateAccountsWith: aBlockClosure

	accounts do: [:each|
		aBlockClosure value: each.
		].! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'composition' stamp: 'RS 12/4/2021 20:37:41'!
bePrintedOn: aReport with: anIdentation

	^aReport printPortfolioOn: self with: anIdentation.! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio2'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'RS 12/3/2021 16:41:05'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!Portfolio class methodsFor: 'instance creation' stamp: 'RS 12/3/2021 17:01:50'!
named: aString

	^self new 
		assignName: aString;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'RS 12/3/2021 17:01:43'!
named: aString with: anAccount

	^self new 
		add: anAccount;
		assignName: aString;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'RS 12/3/2021 16:41:38'!
named: aString with: anAccount with: anotherAccount 

	^self new 
		add: anAccount;
		add: anotherAccount;
		assignName: aString;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio2'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions string name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio2'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'RS 12/3/2021 17:06:09'!
initialize

	super initialize.
	name := self name.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'RS 12/3/2021 16:27:57'!
initializeNamed: aName 

	name := aName.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'RS 12/3/2021 16:29:03'!
accountName
	^name! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'RS 12/2/2021 17:10:25'!
balance

	^transactions 
		inject: 0 * peso
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'RS 12/4/2021 20:37:28'!
bePrintedOn: aReport with: anIdentation

	^aReport printReceptiveAccountOn: self with: anIdentation.! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'private' stamp: 'RS 12/3/2021 16:19:19'!
iterateTransactionsWith: aBlockClosure 
	self transactions do: [:each|
		aBlockClosure value: each.
		]! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'ServiciosFinancieros-Ejercicio2'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'RS 12/3/2021 16:27:30'!
named: aString 
	
	^self new initializeNamed: aString ! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio2'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio2'!

!AccountTransaction methodsFor: 'value' stamp: 'RS 12/2/2021 17:00:27'!
asString

	self subclassResponsibility.! !

!AccountTransaction methodsFor: 'value' stamp: 'RS 12/3/2021 15:57:19'!
bePrintedOn: aReport

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio2'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio2'!

!Deposit methodsFor: 'initialization' stamp: 'RS 12/5/2021 12:26:55'!
initializeFor: aValue
 
	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'RS 12/2/2021 16:58:40'!
asString

	^ 'Depósito por ', value asString! !

!Deposit methodsFor: 'value' stamp: 'RS 12/3/2021 15:51:37'!
bePrintedOn: aReport
	^aReport printDepositWith: self.! !

!Deposit methodsFor: 'value' stamp: 'RS 12/5/2021 12:28:03'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !

!Deposit methodsFor: 'balance' stamp: 'RS 12/3/2021 16:12:29'!
affectTransferNet: transferNet

	^0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio2'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!Deposit class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros-Ejercicio2'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio2'!

!TransferLeg methodsFor: 'value' stamp: 'RS 12/2/2021 17:00:20'!
asString

	self subclassResponsibility.! !

!TransferLeg methodsFor: 'value' stamp: 'RS 12/3/2021 15:57:01'!
bePrintedOn: aReport

	self subclassResponsibility.! !

!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !


!TransferLeg methodsFor: 'initialization' stamp: 'LL 9/20/2020 22:28:14'!
initializeWith: aTransfer

	transfer := aTransfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros-Ejercicio2'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 22:45:01'!
of: aTransfer on: anAccount

	| transaction |
	
	transaction := self new initializeWith: 	aTransfer.
	anAccount register: transaction.	
	
	^transaction! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancieros-Ejercicio2'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio2'!

!TransferDepositLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:26:10'!
withdrawLeg

	^transfer withdrawLeg! !


!TransferDepositLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:49'!
affectBalance: aBalance

	^aBalance + self value! !

!TransferDepositLeg methodsFor: 'balance' stamp: 'RS 12/3/2021 16:12:29'!
affectTransferNet: transferNet

	^transferNet + self value ! !


!TransferDepositLeg methodsFor: 'value' stamp: 'RS 12/2/2021 17:06:08'!
asString

	^'Entrada por transferencia de ', transfer value asString! !

!TransferDepositLeg methodsFor: 'value' stamp: 'RS 12/3/2021 15:57:51'!
bePrintedOn: aReport

	^aReport printTransferDepositLegWith: self.! !

!TransferDepositLeg methodsFor: 'value' stamp: 'RS 12/2/2021 17:02:36'!
value

	^transfer value! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros-Ejercicio2'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio2'!

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !


!TransferWithdrawLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:55'!
affectBalance: aBalance

	^aBalance - self value! !

!TransferWithdrawLeg methodsFor: 'balance' stamp: 'RS 12/3/2021 16:12:29'!
affectTransferNet: aValue

	^aValue - self value ! !


!TransferWithdrawLeg methodsFor: 'value' stamp: 'RS 12/2/2021 17:06:30'!
asString

	^'Salida por transferencia de ', transfer value asString .! !

!TransferWithdrawLeg methodsFor: 'value' stamp: 'RS 12/3/2021 15:58:12'!
bePrintedOn: aReport

	^aReport printTransferWithdrawalLegWith: self.! !

!TransferWithdrawLeg methodsFor: 'value' stamp: 'RS 12/2/2021 17:02:43'!
value

	^transfer value! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio2'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio2'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'RS 12/2/2021 16:58:59'!
asString

	^'Extracción por ', value asString! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

!Withdraw methodsFor: 'balance' stamp: 'RS 12/3/2021 16:12:29'!
affectTransferNet: transferNet

	^0! !


!Withdraw methodsFor: 'printing' stamp: 'RS 12/3/2021 15:55:46'!
bePrintedOn: aReport
	^aReport printWithdrawalWith: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio2'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'LL 7/8/2021 21:45:05'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Report category: 'ServiciosFinancieros-Ejercicio2'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio2'!

!Report methodsFor: 'as yet unclassified' stamp: 'RS 12/3/2021 16:57:47'!
create
	 self subclassResponsibility.! !


!classDefinition: #AccountSummary category: 'ServiciosFinancieros-Ejercicio2'!
Report subclass: #AccountSummary
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio2'!

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'RS 12/4/2021 18:30:25'!
create

	| summary |
	summary := OrderedCollection new.
	
	account iterateTransactionsWith: [:transaction|
		summary add: (transaction bePrintedOn: self)
	].

	summary add: ('Balance = ' , account balance asString).
	^summary.
	! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'RS 12/2/2021 21:03:45'!
initializeWith: anAccount

	account := anAccount.! !


!AccountSummary methodsFor: 'printing' stamp: 'RS 12/3/2021 15:53:50'!
printDepositWith: aDeposit 
	^'Depósito por ', aDeposit value asString! !

!AccountSummary methodsFor: 'printing' stamp: 'RS 12/3/2021 16:00:50'!
printTransferDepositLegWith: aTransferDepositLeg 
	
	^'Entrada por transferencia de ', aTransferDepositLeg value asString.! !

!AccountSummary methodsFor: 'printing' stamp: 'RS 12/3/2021 16:01:21'!
printTransferWithdrawalLegWith: aTransferWithdrawLeg 

	^'Salida por transferencia de ', aTransferWithdrawLeg value asString .! !

!AccountSummary methodsFor: 'printing' stamp: 'RS 12/3/2021 15:56:31'!
printWithdrawalWith: aWithdraw 

	^'Extracción por ', aWithdraw value asString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'ServiciosFinancieros-Ejercicio2'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'error descriptions' stamp: 'RS 12/5/2021 12:20:11'!
canNotRecievePortfolioErrorMessage
	^'An Account Summary cant recieve a Portfolio'.! !


!AccountSummary class methodsFor: 'instance creation' stamp: 'RS 12/5/2021 12:35:55'!
of: anAccount
	(anAccount isKindOf: ReceptiveAccount) ifFalse: [
		self error: self canNotRecievePortfolioErrorMessage.
		].
	^self new initializeWith: anAccount! !


!classDefinition: #PortfolioDetailedTreePrinter category: 'ServiciosFinancieros-Ejercicio2'!
Report subclass: #PortfolioDetailedTreePrinter
	instanceVariableNames: 'account report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio2'!

!PortfolioDetailedTreePrinter methodsFor: 'initialization' stamp: 'RS 12/5/2021 12:13:00'!
create

	report := OrderedCollection new.
	
	report add: account accountName.
	
	account iterateAccountsWith: [:anAccount | | summary |
		report add:('     ',anAccount accountName).
		(anAccount isKindOf: ReceptiveAccount ) ifTrue: [
			summary := (AccountSummary of: anAccount)create.
			summary do: [:each|
				report add:('     ','     ',each).
				].
			].
		(anAccount isKindOf: Portfolio ) ifTrue: [
			report add: ('     ','     ','Balance = ',anAccount balance asString).
		].
	].
	
	report add: ('     ','Balance = ',account balance asString).
	^report.
! !

!PortfolioDetailedTreePrinter methodsFor: 'initialization' stamp: 'RS 12/4/2021 20:45:33'!
initializeOf: anAccount 

	account := anAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioDetailedTreePrinter class' category: 'ServiciosFinancieros-Ejercicio2'!
PortfolioDetailedTreePrinter class
	instanceVariableNames: ''!

!PortfolioDetailedTreePrinter class methodsFor: 'error descriptions' stamp: 'RS 12/5/2021 12:35:25'!
canNotRecieveReceptiveAccountErrorMessage
	^'An PortfolioDetailedTreePrinter cant recieve a Receptive Account'.! !


!PortfolioDetailedTreePrinter class methodsFor: 'instance creation' stamp: 'RS 12/5/2021 12:35:25'!
of: anAccount 
	(anAccount isKindOf: Portfolio ) ifFalse: [
		self error: self canNotRecieveReceptiveAccountErrorMessage.
		].
	^self new initializeOf: anAccount ! !


!classDefinition: #PortfolioTreePrinter category: 'ServiciosFinancieros-Ejercicio2'!
Report subclass: #PortfolioTreePrinter
	instanceVariableNames: 'account report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio2'!

!PortfolioTreePrinter methodsFor: 'initialization' stamp: 'RS 12/3/2021 16:56:06'!
initializeWith: anAccount 
	
	account := anAccount.! !


!PortfolioTreePrinter methodsFor: 'as yet unclassified' stamp: 'RS 12/4/2021 20:34:40'!
create

	report := OrderedCollection new.
	
	report add: account accountName.
	
	account iterateAccountsWith: [:anAccount|
		(anAccount bePrintedOn: self with: '     ').
	].

	^report.
	! !

!PortfolioTreePrinter methodsFor: 'as yet unclassified' stamp: 'RS 12/4/2021 20:37:41'!
printPortfolioOn: aPortfolio with: anIdentation

	report add: anIdentation,aPortfolio accountName .
	aPortfolio iterateAccountsWith: [:anAccount|
		anAccount bePrintedOn: self with: anIdentation,'     '.
		].! !

!PortfolioTreePrinter methodsFor: 'as yet unclassified' stamp: 'RS 12/4/2021 20:37:28'!
printReceptiveAccountOn: aReceptiveAccount with: anIdentation

	report add: (anIdentation,aReceptiveAccount accountName).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreePrinter class' category: 'ServiciosFinancieros-Ejercicio2'!
PortfolioTreePrinter class
	instanceVariableNames: ''!

!PortfolioTreePrinter class methodsFor: 'instance creation' stamp: 'RS 12/5/2021 12:35:25'!
of: anAccount
	(anAccount isKindOf: Portfolio ) ifFalse: [
		self error: self canNotRecieveReceptiveAccountErrorMessage.
		].
	^self new initializeWith: anAccount! !


!PortfolioTreePrinter class methodsFor: 'error descriptions' stamp: 'RS 12/5/2021 12:35:25'!
canNotRecieveReceptiveAccountErrorMessage
	^'An PortfolioTreePrinter cant recieve a Receptive Account'.! !


!classDefinition: #TransferNet category: 'ServiciosFinancieros-Ejercicio2'!
Report subclass: #TransferNet
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio2'!

!TransferNet methodsFor: 'as yet unclassified' stamp: 'RS 12/3/2021 16:12:29'!
create

	^account transactions inject: 0 into:[:currentTransferNet :each|
		each affectTransferNet: currentTransferNet .
	].
	! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'RS 12/2/2021 21:20:35'!
initializeWith: anAccount

	account := anAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'ServiciosFinancieros-Ejercicio2'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'instance creation' stamp: 'RS 12/2/2021 21:20:04'!
of: anAccount

	^self new initializeWith: anAccount.! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Ejercicio2'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio2'!

!Transfer methodsFor: 'value' stamp: 'LL 9/20/2020 21:13:00'!
value

	^value! !


!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:39:46'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 21:25:56'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'initialization' stamp: 'LL 9/20/2020 21:25:21'!
initializeWith: aValue withdrawLeg: aWithdraw depositLeg: aDeposit

	value := aValue.
	withdrawLeg := aWithdraw.
	depositLeg := aDeposit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Ejercicio2'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:57:30'!
cannotTransferToOriginErrorDescription
	
	^'Transfer destionation cannot be the origin account'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:00:53'!
cannotTransferZeroErrorDescription

	^'Transfer amount should be positive'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:56:35'!
signalCannotTransferToOrigin
	
	self error: self cannotTransferToOriginErrorDescription! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:06:17'!
signalCannotTransferZero

	self error: self cannotTransferZeroErrorDescription! !


!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:05:22'!
assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount

	self assertCanTransferTo: destinationAccount from: originAccount.
	self assertCanTransfer: anAmountOfMoney! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:11:50'!
assertCanTransfer: anAmountOfMoney

	^ anAmountOfMoney isZero ifTrue: [ self signalCannotTransferZero ]! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:04:58'!
assertCanTransferTo: destinationAccount from: originAccount

	^ originAccount = destinationAccount ifTrue: [ self signalCannotTransferToOrigin ]! !


!Transfer class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 23:11:34'!
amount: anAmountOfMoney from: originAccount to: destinationAccount 
	
	| transfer depositLeg withdrawLeg |
	
	self assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount.
	
	transfer := self new.
	
	withdrawLeg := TransferWithdrawLeg of: transfer on: originAccount.
	depositLeg := TransferDepositLeg of: transfer on: destinationAccount.
	
	^transfer initializeWith: anAmountOfMoney withdrawLeg: withdrawLeg depositLeg: depositLeg
	
	
	! !
