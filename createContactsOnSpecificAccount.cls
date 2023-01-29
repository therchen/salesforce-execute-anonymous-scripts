Account a = [SELECT Id FROM Account WHERE Id = '0015d00003WcDxGAAV'];
List<Contact> contacts = new List<Contact>();
for(Integer i = 0; i < 150; i++){
    Contact c = new Contact(
        FirstName = 'Test' + String.valueOf(i),
        LastName = 'Test' + String.valueOf(i),
        AccountId = a.Id
    );
    contacts.add(c);
}
insert contacts;



List<Contact> contacts2 = new List<Contact>();
List<Contact> contacts = [SELECT Id FROM Contact WHERE AccountId = '0015d00003WcDxGAAV'];
for(Contact c: contacts){
    c.OwnerId = '00540000003MwDrAAK';
    contacts2.add(c);
}
update contacts2;
