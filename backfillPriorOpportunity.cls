Integer startCount = [SELECT COUNT() FROM Opportunity WHERE Renewed_Opportunity__c = NULL AND Opportunity_Type__c = 'Renewal Booking'
	AND IsClosed = FALSE
];
System.debug('startCount: ' + startCount);
List < Opportunity > opps = [SELECT Id, AccountId FROM Opportunity WHERE Renewed_Opportunity__c = NULL AND Opportunity_Type__c = 'Renewal Booking'
	AND IsClosed = FALSE LIMIT 20
];
if (!opps.isEmpty()) {
	List < Opportunity > oppsToUpdate = new List < Opportunity > ();
	for (Opportunity o: opps) {
		List < Opportunity > opps2 = [
			SELECT Id, Opportunity_Start_Date__c FROM Opportunity
			WHERE
			AccountId = : o.AccountId AND(Opportunity_Type__c = 'New Booking'
				OR Opportunity_Type__c = 'Renewal Booking') AND
			StageName = 'Closed Won'
			ORDER BY Opportunity_Start_Date__c DESC
		];
		if (!opps2.isEmpty()) {
			Opportunity oppToUpdate = new Opportunity(Id = o.Id, Renewed_Opportunity__c = opps2[0].Id, Updated_Renewed_Opportunity__c = true);
			oppsToUpdate.add(oppToUpdate);
		}
	}
	if (!oppsToUpdate.isEmpty()) {
		update oppsToUpdate;
	}
	Integer endCount = [SELECT COUNT() FROM Opportunity WHERE Renewed_Opportunity__c = NULL AND Opportunity_Type__c = 'Renewal Booking'
		AND IsClosed = FALSE
	];
	System.debug('endCount: ' + endCount);
}
