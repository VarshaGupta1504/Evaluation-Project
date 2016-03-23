public class ContactUpdateHandler
{
           List<ID> conIds = New List<ID>();
           List<ID> contactOldIds = New List<ID>();
           List<Contact> conList= new List<Contact>();
           List<Task> TaskList=new List<Task>();
           List<Contact> conOldList=new  List<Contact>();
           
           Task taskAssignment=new Task();  
   
        //Function is to checked the checkbox for the associated Contact and task creation
          public void AssociateContactToOpportunity(list<Opportunity> opportunityList, list<Opportunity> opportunityOldList ) {
            
            
            //traverse new opportunity
            for(Opportunity opty : opportunityList){
                // Condition in which the trigger work for
                     if(opty .StageName == 'Closed Won' || opty .StageName== 'Closed Partial'){
                        
                        //Add selected contact id in ConIds
                        ConIds.add(opty .Contact__c);
                       
                        //This is to create the task and assign the task to opportunity Owner
                        taskAssignment.whatID=opty.ID;
                        taskAssignment.Subject='Touch Point 1';
                        taskAssignment.Priority='Normal';
                        taskAssignment.Type='Call';
                        taskAssignment.Status='Not Started'; 
                        taskAssignment.ActivityDate=Date.today();                    
                        TaskList.add(taskAssignment);
                        
                        
                }
            
            }
            //insert created task
             insert TaskList; 
            
            // Fetching Contact details to update
             conList = [
                         SELECT  id
                              ,  Primary_Contact__c 
                           FROM  Contact 
                          WHERE id in :ConIds
                               
                       ];
                       
                       
            system.debug('conlist'+conList );           
                              
            // to check the checkbox for the related contact                 
            for(integer i = 0 ; i < conList.size(); i++){
                conList[i].Primary_Contact__c = true;
    
            }
            
            
           
            update conList;
            
            system.debug('opportylist'+opportunityOldList);
            
            //traversing old opportunity records
            for(Opportunity oldOpportunity: opportunityOldList){
                 contactOldIds.add(oldOpportunity.Contact__c);
                  
            }
            
            conOldList = [
                         SELECT  id
                              ,  Primary_Contact__c 
                           FROM  Contact 
                          WHERE id in :contactOldIds
                               
                       ];
     
            //unchecked previous contact record
            for(integer i = 0 ; i < conOldlist .size(); i++){
                conOldlist[i].Primary_Contact__c = false;
                
            } 
            
            //update old contact and make its checkbox unchecked
            update conOldList ;
       } 
       
       public void AssociateContactToOpportunityInsert(list<Opportunity> opportunityList){

               
               for(Opportunity opty : opportunityList){
               
                    if(opty .StageName == 'Closed Won' || opty .StageName== 'Closed Partial'){    
                        //Add selected contact id in ConIds
                        ConIds.add(opty .Contact__c);
                       
                        //This is to create the task and assign the task to opportunity Owner
                        taskAssignment.whatID=opty.ID;
                        taskAssignment.Subject='Touch Point 1';
                        taskAssignment.Priority='Normal';
                        taskAssignment.Type='Call';
                        taskAssignment.Status='Not Started';
                        taskAssignment.ActivityDate=Date.today();                      
                        TaskList.add(taskAssignment);
                      
                        
                 }
             
              }
             insert TaskList; 
             system.debug('the task id is'+TaskList[0].id);
             List<Contact> conList = [
                              SELECT  id
                                   ,  Primary_Contact__c 
                                FROM  Contact 
                               WHERE id in :ConIds
                               
                             ];
                             
                             
            // to check the checkbox for the related contact                 
            for(integer i = 0 ; i < conList.size(); i++){
                conList[i].Primary_Contact__c = true;
    
            }

            update conList;
        
       
    }
  
}