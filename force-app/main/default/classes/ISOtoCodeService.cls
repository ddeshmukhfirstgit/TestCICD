/**
* 	@Author	:	Jitendra Zaa
 * 	@Web	:	http://JitendraZaa.com
 *
 * */
public class ISOtoCodeService {
    public String countryISO {get;set;}
    public String response {get;set;} 

	//private String baseSericeURL = 'http://services.groupkt.com/country/get/iso2code/';
    private String returnedContinuationId ;

    public ISOtoCodeService()
    {
        countryISO = 'IN';
    } 

    public Object requestService(){

        //Timeout in seconds, 60 is limit
        Continuation con = new Continuation(120);

        // Set callback method
        con.continuationMethod='renderResponse';

        // Create callout request
        /*HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint(baseSericeURL+countryISO);

        returnedContinuationId = con.addHttpRequest(req);*/
        
        HttpRequest req = new HttpRequest();
    
	    Integration_Settings__c  integrationSettings = Integration_Settings__c.getValues('Callout Settings');
	   req.setEndpoint(integrationSettings.Endpoint__c);
	    //req.setEndpoint('https://akshayth-dev-ed.my.salesforce.com/services/apexrest/TestManagedPkg/RelatedContacts/0019000001mqXPx');
	    req.setBody('username='+integrationSettings.Username__c
	                +'&password='+EncodingUtil.urlEncode(integrationSettings.Password__c, 'UTF-8')
	                    +'&client_id='+EncodingUtil.urlEncode(integrationSettings.Client_Id__c, 'UTF-8')
	                   +'&client_secret='+EncodingUtil.urlEncode(integrationSettings.Client_Secret__c, 'UTF-8')
	                   +'&grant_type='+EncodingUtil.urlEncode('password', 'UTF-8')); 
	                   
	    String b = req.getBody();
	    string enp = req.getEndpoint();
	    
	    system.debug(b);
	    system.debug(enp);
	    
	                 
	    
	    req.setHeader('Content-Type','application/x-www-form-urlencoded');    
	   // req.setMethod('GET');
		//req.setHeader('Authorization', 'Bearer 00D90000000uDBQ!AR0AQPaIE5IfSNyumCZrVDxzMcXGv7956XuclRrkLDGDpMBBVHD5udXwUniUCcnBcFzUE5i5XyyjNBntvCcldmM6yLfCbM.T');
     // req.setHeader('Content-Type', 'application/json');
		system.debug('Request '+req.getBody()); 
		 
		//Http http = new Http();
		//HttpResponse rs = http.send(req);
		
		//system.debug('res '+rs);
		returnedContinuationId = con.addHttpRequest(req);
		
        return con;
    }

    public Object renderResponse() {
      // Get the response by using the unique label
      system.debug('In renderResponse');
        HttpResponse httpRes = Continuation.getResponse(returnedContinuationId);
      // Set the result variable that is displayed on the Visualforce page
       response = httpRes.getBody();
       system.debug('In renderResponse' + response );
      // Return null to re-render the original Visualforce page
      return null;
    }

}