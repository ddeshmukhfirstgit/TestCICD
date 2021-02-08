public class CaseDetails_CC {
    @AuraEnabled
    public static Case getCaseDetails(Id caseId){
        return [Select c.Type, c.Account.Phone, c.Account.BillingCountry, 
                	c.Account.BillingPostalCode, c.Account.BillingState,
                	c.Account.BillingCity, c.Account.BillingStreet, c.Account.Name,
                	c.AccountId From Case c where Id=: caseId];
    }
    
    @AuraEnabled
    public static String getSalesOrder(Id accountId){
    	
        List<Contact> consList =  [Select Id, AccountId, LastName, FirstName, Salutation, Name, MobilePhone, HomePhone, Email, Title From Contact 
                	Where AccountId =:accountId];
                	
        String jsonString = Json.serializePretty(consList);
        return jsonString;
        
    }
    
    @AuraEnabled
    public static String getProvisionalTasks(Id conId){
    	String jsonString ;
        
        List<Task> taskList = [Select t.WhoId, t.Subject, t.Status, t.Priority, t.Id, t.ActivityDate From Task t Where WhoId=:conId];
        
        jsonString = JSON.serializePretty(taskList);
        return jsonString;
    }
    @AuraEnabled
    public static String getProvisionDetails(){
    	String jsonString ;
        
        List<ProvisionalOrders> provisionalOrdes = new List<ProvisionalOrders>();
        
        for(Integer i =0;i<5;i++){
            provisionalOrdes.add(new ProvisionalOrders('Provisional '+i, System.today().addDays(i),
                                                      		'Provisional Details '+i, 'Provisional Comments '+i));
        }
        
        jsonString = JSON.serializePretty(provisionalOrdes);
        return jsonString;
        
    }
    
   
    
    public class ProvisionalOrders{
        @AuraEnabled public String provisionName {get;set;}
        @AuraEnabled public Date provisionDate {get;set;}
        @AuraEnabled public String provisionDetails {get;set;}
        @AuraEnabled public String provisionComments {get;set;}
        
        public ProvisionalOrders(String provisionName, Date provisionDate, String provisionDetails, String provisionComments){
            this.provisionName = provisionName;
            this.provisionDate = provisionDate;
            this.provisionDetails = provisionDetails;
            this.provisionComments = provisionComments;
            
        }
    }
}