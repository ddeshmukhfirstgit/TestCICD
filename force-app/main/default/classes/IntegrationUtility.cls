public class IntegrationUtility {
	static Integration_Settings__c integrationSettings;
    private string session_id;
    private string instanceUrl;
    
    public String getAccounts(String accountId){
        if(session_id == null){
            getSessionId();
        }
        
        return getRelatedAccount(accountId);       
    }
     
    private String getRelatedAccount(String accountId){
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(instanceUrl+'/services/apexrest/TestManagedPkg/RelatedContacts/'+accountId);
        req.setMethod('GET');							  
        
        req.setHeader('Authorization', 'Bearer '+session_id);
        req.setHeader('Content-Type', 'application/json');
        
        Http http = new Http();
        HTTPResponse res = http.send(req);
        system.debug('Account');
        System.debug(res.getBody());
        
        return res.getBody();
    }	
    
    
    /** LOGIN INTO SF AND GET SESSION ID */
    public void getSessionId(){
        HttpRequest req = new HttpRequest();
        integrationSettings = Integration_Settings__c.getValues('Callout Settings');
        
        req.setEndpoint(integrationSettings.Endpoint__c);
        
        req.setBody('username='+EncodingUtil.urlEncode(integrationSettings.Username__c, 'UTF-8')
                +'&password='+EncodingUtil.urlEncode(integrationSettings.Password__c, 'UTF-8')
                    +'&client_id='+EncodingUtil.urlEncode(integrationSettings.Client_Id__c, 'UTF-8')
                   +'&client_secret='+EncodingUtil.urlEncode(integrationSettings.Client_Secret__c, 'UTF-8')
                   +'&grant_type='+EncodingUtil.urlEncode('password', 'UTF-8')); 
        
        req.setMethod('POST');
        
        Http http = new Http();
        HTTPResponse res = http.send(req);
        
        System.debug(res.getBody());
        
        JSONParser parser =   JSON.createParser(res.getBody());
        
        while (parser.nextToken() != null) {
            /** Get session Id */
            if ((parser.getText() == 'access_token')){
               	system.debug('Retreiving Token');
               	parser.nextToken();
                session_id = parser.getText();
                system.debug('token: '+parser.getText());

            }
            
            /** Get Instance URL */
            if ((parser.getText() == 'instance_url')){
               	system.debug('Retreiving Token');
               	parser.nextToken();
                instanceUrl = parser.getText();
                system.debug('instanceUrl: '+parser.getText());

            }
            
        }
    }
}