trigger contactUpdateTrigger on Opportunity (after insert, before update) {

    if(trigger.isUpdate && trigger.isbefore){
         ContactUpdateHandler contactUpdateTriggerHandler=new ContactUpdateHandler();
         contactUpdateTriggerHandler.AssociateContactToOpportunity(Trigger.new, Trigger.old);
    }

 
    if(trigger.isInsert && trigger.isafter){
         ContactUpdateHandler contactUpdateTriggerHandler=new ContactUpdateHandler();
         contactUpdateTriggerHandler.AssociateContactToOpportunityInsert(Trigger.new);
    }
   
}