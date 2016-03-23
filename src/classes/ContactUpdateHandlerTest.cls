@isTest
public class ContactUpdateHandlerTest{
       
        static testMethod void runTriggerContactUpdateHandler(){
                List<ID> ConIds = New List<ID>();
                List<Contact> contactList= new List<Contact>();
                List<Opportunity> optyList=new List<Opportunity>();
                List<Task> TaskList=new List<Task>();
                
                
                //Insert Contact Record
                Contact contactRecord1=new Contact(LastName='Patel',FirstName='Rasika' ,Primary_Contact__c=false);
                Contact contactRecord2=new Contact(LastName='Sharma',FirstName='Kapil' ,Primary_Contact__c=false);
                contactList.add(contactRecord1);
                contactList.add(contactRecord2);
                system.debug('here the contactRecordlist'+contactList);
                insert contactList;   
              
                //Insert Opportunity Record
                Opportunity opportunityRecord=new Opportunity(Name='anjali',StageName='Closed Won',CloseDate=Date.today()); 
                system.debug('having contact id'+contactList[0].id );
                opportunityRecord.Contact__c=contactList[0].id;           
                optyList.add(opportunityRecord);
                insert  optyList;
                system.debug('here the opportunitylist'+optyList);
               
                Contact contact1=[
                                 SELECT id
                                      , Primary_Contact__c
                                  FROM  Contact
                                 WHERE  ID = : contactList[0].id     
                
                                ];
                
                System.debug('Contact1 primary contact' +contact1.Primary_Contact__c);
                System.assertEquals(true,contact1.Primary_Contact__c,'Required Contact Primary Contact is not checked');
                
                //Update Contact
                
                
                 Opportunity opportunity=[
                                          SELECT id
                                               , Contact__c
                                            FROM Opportunity
                                           WHERE Id IN : optyList     
                                         ];
                                        
                 opportunity.Contact__c=contactList[1].id;
                 update opportunity;
                 Contact contact2=[
                                   SELECT id
                                        , Primary_Contact__c
                                     FROM  Contact
                                    WHERE  ID = : contactList[1].id     
                
                                  ];
               contact1.Primary_Contact__c=false;
               update contact1;
               
              //to test for updated contact
               system.assertEquals(true,contact2.Primary_Contact__c,'Contact Primary_Contact not checkbox checked');
               system.assertEquals(false,contact1.Primary_Contact__c,'Contact Primary_Contact  checkbox checked');
        }
  }