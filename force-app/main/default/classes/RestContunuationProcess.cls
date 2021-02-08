public with sharing class RestContunuationProcess {
    public Map<String, JSONFieldWrapper> jsonFieldWrapperMap {get;set;}
	public List<JSONFieldWrapper> jsonFieldWrapperList{set;get;} // this list contain JSONFieldWrapper with the value
	public List<JSONRecordWrapper> jsonRecordWrapper{get;set;} // list of records in the jsonRecordWrapper. This would be the object used to iterate in visualforce
	public List<String> labelOrders {get;set;}
    
    static Integration_Settings__c integrationSettings;
    private string session_id;
    private string instanceUrl;
    
	private String dataRequestLabel;
    private string sObjectId;
    
    // Unique label for the initial callout request
    public String requestLabel1;
    // Unique label for the chained callout request
    public String requestLabel2;
    // Result of initial callout
    public String result1 {get;set;}
    // Result of chained callout
    public String result2 {get;set;}
    // Endpoint of long-running service
    private static final String LONG_RUNNING_SERVICE_URL1 = 
        '<Insert your first service URL>';
    private static final String LONG_RUNNING_SERVICE_URL2 = 
        '<Insert your second service URL>';
           
    // Action method
    public Object invokeInitialRequest() {
      system.debug('Calling continuation');
        // Create continuation with a timeout
      Continuation con = new Continuation(60);
      // Set callback method
      con.continuationMethod='processInitialResponse';
      
      // Create first callout request
      HttpRequest req = new HttpRequest();
      integrationSettings = Integration_Settings__c.getValues('Callout Settings');
        
      //req.setEndpoint('https://akshayth-dev-ed.my.salesforce.com/services/oauth2/token');
      req.setEndpoint('callout:SF');
        system.debug(req.getEndpoint());  
       
      req.setBody('username=akshay@deshmukh.com'
                +'&password=Salesforce1988FVUGFgikQCJyTAHMD3j5puTxW'
                    +'&client_id=3MVG9Y6d_Btp4xp4dft0ohY5ncMIVxnnE0dOXRRr1m07UX48hBcqTHGRW1NJOvekQSCojShozS5Ux5WsaAVVM'
                   +'&client_secret=5034369290671920600'
                   +'&grant_type=password'
                 +'&redirect_uri=https://www.google.co.in/'); 
      
         
        req.setHeader('content-type', 'application/json');
      	/*req.setHeader('username', integrationSettings.Username__c);
        req.setHeader('password', integrationSettings.Password__c);
        req.setHeader('client_id', integrationSettings.Client_Id__c);
        req.setHeader('client_secret', integrationSettings.Client_Secret__c);
        req.setHeader('grant_type', 'password');
        */
        
        
      req.setMethod('POST');  
      
        system.debug('Headers'+req.getHeader('grant_type'));
        
      // Add initial callout request to continuation
      
       system.debug('REQ: '+req);
        system.debug('REQ: '+req.getBody());
      this.requestLabel1 = con.addHttpRequest(req);              
      
      // Return the continuation
      return con;  
    }
    
    // Callback method for initial request
    public Object processInitialResponse() {   
      // Get the response by using the unique label
      HttpResponse response = Continuation.getResponse(this.requestLabel1);
      // Set the result variable that is displayed on the Visualforce page
      this.result1 = response.getBody();
      
        
        System.debug('REQUEST : '+ response.getBody());
        system.debug('First Response :'+this.result1);
      JSONParser parser =   JSON.createParser(response.getBody());
        
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
        
      Continuation chainedContinuation = null;
      // Chain continuation if some condition is met
      if (session_id != null) {
          // Create a second continuation 
          chainedContinuation = new Continuation(60);
          // Set callback method
          chainedContinuation.continuationMethod='processChainedResponse';
          
          // Create callout request
          HttpRequest req = new HttpRequest();
    
          integrationSettings = Integration_Settings__c.getValues('Callout Settings');
          req.setEndpoint(instanceUrl+'/services/apexrest/TestManagedPkg/RelatedContacts/'+sObjectId);
          req.setMethod('GET');							  
    
      	  req.setHeader('Authorization', 'Bearer '+session_id);
          req.setHeader('Content-Type', 'application/json');
    
          
          // Add callout request to continuation
          this.requestLabel2 = chainedContinuation.addHttpRequest(req); 
      }
      
      // Start another continuation 
      return chainedContinuation;  
    }    
    
    // Callback method for chained request
    public Object processChainedResponse() {   
      // Get the response for the chained request
      HttpResponse response = Continuation.getResponse(this.requestLabel2);
      // Set the result variable that is displayed on the Visualforce page
      this.result2 = response.getBody();
	  
        
      populateReponse(response.getBody());  
      // Return null to re-render the original Visualforce page
      return null;
    }
    
    private List<Integration_Config__mdt> getCustomMetadata(String methodName){
        List<Integration_Config__mdt> metadata = [select Label__c, Type__c, Order__c,  JsonName__c  from Integration_Config__mdt 
                                                  		Where Label =: methodName Order by Order__C asc];
        
        system.debug('Metadata: '+metadata);
        
        /** populate json Labels according to order */
        for(Integration_Config__mdt mdt : metadata){
            labelOrders.add(mdt.Label__c);
        }
        
        return metadata;
    }
    
    public  RestContunuationProcess(){
    	jsonRecordWrapper = new List<JSONRecordWrapper>();
        labelOrders = new List<String>();
    }
    
    
    
    private void populateReponse(String response){
    	
    	JSONParser parser =   JSON.createParser(response);
    
    	/** Parse JSON response as list of object */
    	List<Object> lstwrap =(List<Object>) System.JSON.deserializeUntyped(response);

    	for(Object mapObject : lstwrap){
    		 
    		 /** JSON will be received as Key:value pair, so typecast it into map */
    		 Map<String, Object> contactAttributes = (Map<String, Object>)mapObject;
    		 
    		 JSONRecordWrapper recordWrapperTemp = new JSONRecordWrapper();

    		 /** Iterate through map and get individual properties */
			 for (String attributeName : contactAttributes.keyset()) {
			     
			     if(jsonFieldWrapperMap.containsKey(attributeName)){
			     	
			     	/** Get field wrapper created for each jsonName */
			     	JSONFieldWrapper wrapper = jsonFieldWrapperMap.get(attributeName);
			     	String val = (String) contactAttributes.get(attributeName);
			     	
			     	/** Create a temp wrapper adding value received from JSON response */
			     	JSONFieldWrapper  tempFieldWrapper = new JSONFieldWrapper (wrapper.jsonName, wrapper.jsonLabel, wrapper.jsonOrder,val);
			     	
			     	/** Add wrapper with value in record wrapper*/
			     	recordWrapperTemp.addJSONFieldWrapper(tempFieldWrapper);
 				    
			     }
			 }
			 system.debug('recordWrapperTemp: '+recordWrapperTemp);
			 jsonRecordWrapper.add(recordWrapperTemp);
    	}
    }
    
   
   /** Wrapper class which holds configuration for each field which will be received by External System*/
   private class JSONFieldWrapper {
		public String jsonName {set;get;}
		public String jsonLabel {set;get;}
 		public Decimal jsonOrder {set;get;}
		public String value {set;get;}
		public String dType {set;get;}

       		
    	public JSONFieldWrapper(String  name, String lbl, Decimal order){
    		this.jsonName = name;
			this.jsonLabel = lbl;
 			this.jsonOrder = order;
 			this.dType=dtype;
		}
	        	
    	public JSONFieldWrapper(String  name, String lbl, Decimal order, String value){
    		this.jsonName = name;
			this.jsonLabel = lbl;
 			this.jsonOrder = order;
 			this.value = value;
    	}          

	     // implement equals and hashcode (so we can use Set)
	    // https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/langCon_apex_collections_maps_keys_userdefined.htm

		public Boolean equals(Object obj) {
		    // Your implementation
		    return true; 
		}

		public Integer hashCode() {
		    // Your implementation
		    return 0;
		}	  
	}
	
	
	
	// This class is for a record 
	public class JSONRecordWrapper {
		public List<JSONFieldWrapper> jsonFieldWrapperList {get;set;}

	        	public JSONRecordWrapper(){ 
	        		jsonFieldWrapperList = new List<JSONFieldWrapper>();
	        	}

	        	public void addJSONFieldWrapper(JSONFieldWrapper jsonFieldWrapper){ // add the first jsonFieldWrapper to the jsonFieldWrapperList
	        		jsonFieldWrapperList.add(jsonFieldWrapper);	
	        	}	        	 	        	
				
				public List<JSONFieldWrapper> getJsonFieldWrapperList(){
					return jsonFieldWrapperList;
				}
 	        	// to support sorting
	        	// https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_comparable.htm#apex_comparable
	        	public Integer compareTo(Object compareTo) {
	        		//implement compareTo method using jsonOrder ensure cater for scenario when the jsonOrder is
	        		return 0;
	        	}	        	

	}
}