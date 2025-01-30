public with sharing class ContactTriggerHandler extends TriggerHandler {

    private List <Contact> newContacts;
    private Map <Id, Contact> newContactMap;
    private List <Contact> oldContacts;
    private Map <Id, Contact> oldContactMap;

    public ContactTriggerHandler() {
        this.newContacts = (List<Contact>) Trigger.new;
        this.newContactMap = (Map<Id, Contact>) Trigger.newMap;
        this.oldContacts = (List<Contact>) Trigger.old;
        this.oldContactMap = (Map<Id, Contact>) Trigger.oldMap;
    }
        protected override virtual void beforeInsert(){
            Integer randomNumber = Integer.valueof((Math.random() * 100));
            String randomString = String.valueOf(randomNumber);
                for(Contact con : newContacts){
                    if(String.isBlank(con.DummyJSON_Id__c)){
                        con.DummyJSON_Id__c = randomString;
                    }
            }
        }

        protected override virtual void afterInsert(){
            for(Contact con : newContacts){
                if(con.DummyJSON_Id__c <= String.valueOf(100)) {
                    DummyJSONCallout.getDummyJSONUserFromId(con.DummyJSON_Id__c);
                }		
            }
        }

        protected override virtual void afterUpdate(){
            for(Contact con : newContacts){
                if(Integer.valueOf(con.DummyJSON_Id__c) > 100){
                    DummyJSONCallout.postCreateDummyJSONUser(con.Id); 
                }
            }
        }
}
        


