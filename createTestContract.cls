Boolean deleteExistingTestAccounts = false;
Boolean createQuote = false;
Boolean closedWon = false;
String accountName = 'Testing Partners ' + String.valueOf(System.now());
if (deleteExistingTestAccounts) {
	List < Account > accounts = [SELECT Id FROM Account WHERE Is_Test_Record__c = true];
	if (!accounts.isEmpty()) {
		List < Contract > contracts = [SELECT Id FROM Contract WHERE AccountId = : accounts[0].Id];
		if (!contracts.isEmpty()) {
			delete contracts;
		}
		List < Customer_Renewal_Journey__c > crjs = [SELECT Id FROM Customer_Renewal_Journey__c WHERE Account__c = : accounts[0].Id];
		if (!crjs.isEmpty()) {
			delete crjs;
		}
		List < Opportunity > opps = [SELECT Id FROM Opportunity WHERE AccountId = : accounts[0].Id];
		if (!opps.isEmpty()) {
			delete opps;
		}
		delete accounts;
	}
}
User u = [SELECT Id FROM User WHERE Alias = 'mkraus'];
Account a = new Account(OwnerId = u.Id, Name = accountName, Website = 'testingpartners.com', Is_Test_Record__c = true, Company_Size__c = '1 to 50', NumberOfEmployees = 10, Industry = 'Alumni Associations', Type = 'Corporate', BillingCity = 'Test City', BillingCountry = 'US', BillingPostalCode = '55555', BillingState = 'CA', BillingStreet = '12345 Test Avenue', ShippingCity = 'Test City', ShippingCountry = 'US', ShippingPostalCode = '55555', ShippingState = 'CA', ShippingStreet = '12345 Test Avenue');
insert a;
Contact c1 = new Contact(OwnerId = u.Id, FirstName = 'Test', LastName = 'Billing', AccountId = a.Id);
insert c1;
Contact c2 = new Contact(OwnerId = u.Id, FirstName = 'Test', LastName = 'Shipping', AccountId = a.Id);
insert c2;
Opportunity o = new Opportunity(Billing_Contact__c = c1.Id, Shipping_Contact__c = c2.Id, Pricebook2Id = '01s5d000004o2F3AAI', LeadSource = 'BDR - Cold Call', OwnerId = u.Id, Name = 'Test', RecordTypeId = '01240000000QMGWAA4', Opportunity_Type__c = 'New Booking', CloseDate = Date.newInstance(2022, 12, 31), AccountId = a.Id, StageName = 'Stage 0: Qualification');
insert o;
if (createQuote) {
	SBQQ__Quote__c q = new SBQQ__Quote__c(OwnerId = u.Id, SBQQ__Opportunity2__c = o.Id, SBQQ__Primary__c = true, SBQQ__StartDate__c = Date.newInstance(2021, 01, 01), SBQQ__EndDate__c = Date.newInstance(2021, 12, 31), SBQQ__PaymentTerms__c = 'Upfront');
	insert q;
	List < SBQQ__QuoteLine__c > lines = new List < SBQQ__QuoteLine__c > ();
	//PREMIUM BUNDLE
	SBQQ__QuoteLine__c line1 = new SBQQ__QuoteLine__c(SBQQ__Product__c = '01t05000001h8feAAA', SBQQ__Quote__c = q.Id, SBQQ__Quantity__c = 1);
	insert line1;
	//USER LICENSE
	SBQQ__QuoteLine__c line2 = new SBQQ__QuoteLine__c(SBQQ__Product__c = '01t05000001h8fgAAA', SBQQ__Quote__c = q.Id, SBQQ__Quantity__c = 1, SBQQ__CustomerPrice__c = 4500, SBQQ__ListPrice__c = 4500, SBQQ__NetPrice__c = 4500, SBQQ__OptionLevel__c = 1, SBQQ__OptionType__c = 'Related Product', SBQQ__PartnerPrice__c = 4500, SBQQ__ProductOption__c = 'a4m05000000PZkmAAG', SBQQ__ProratedListPrice__c = 4500, SBQQ__ProratedPrice__c = 4500, SBQQ__RegularPrice__c = 4500, SBQQ__RequiredBy__c = line1.Id);
	insert line2;
	//REPS TICKETS
	//SBQQ__QuoteLine__c line3 = new SBQQ__QuoteLine__c(SBQQ__Product__c = '01t05000001h8fhAAA', SBQQ__Quote__c = q.Id, SBQQ__Quantity__c = 200);
	if (closedWon) {
		o.StageName = 'Closed Won';
		update o;
	}
}
