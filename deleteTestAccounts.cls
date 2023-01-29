Boolean deleteExistingTestAccounts = true;
Boolean createQuote = false;
if (deleteExistingTestAccounts) {
	List < Account > accounts = [SELECT Id FROM Account WHERE Is_Test_Record__c = true];
	delete accounts;
}
User u = [SELECT Id FROM User WHERE Alias = 'mkraus'];
Account a = new Account(OwnerId = u.Id, Name = 'Herk Testing Partners 02', Website = 'testingpartners.com', Is_Test_Record__c = true, Company_Size__c = '1 to 50', NumberOfEmployees = 10, Industry = 'Alumni Associations', Type = 'Corporate', Account_Status__c = 'Cold');
insert a;
Contact c = new Contact(OwnerId = u.Id, FirstName = 'Test', LastName = 'Test', AccountId = a.Id);
insert c;
Opportunity o = new Opportunity(LeadSource = 'BDR - Cold Call', OwnerId = u.Id, Name = 'Test', RecordTypeId = '01240000000QMGWAA4', Opportunity_Type__c = 'New Sale', CloseDate = Date.newInstance(2022, 12, 31), AccountId = a.Id, StageName = 'Stage 0: Qualification');
insert o;
if (createQuote) {
	SBQQ__Quote__c q = new SBQQ__Quote__c(SBQQ__Opportunity2__c = o.Id, SBQQ__Primary__c = true, SBQQ__StartDate__c = Date.newInstance(2022, 01, 01), SBQQ__EndDate__c = Date.newInstance(2022, 12, 31), SBQQ__PaymentTerms__c = 'Upfront');
	insert q;
}

//MOVE TO STAGE 01
/*
Discovery_Call_Date__c = Date.newInstance(2022, 01, 01),
Discovery_Demo_Notes__c = 'Test',
Planned_First_Event_Date__c = Date.newInstance(2022, 01, 01),
Primary_Use_Case__c = 'Benefits',
Scheduled_By__c = u.Id
*/
