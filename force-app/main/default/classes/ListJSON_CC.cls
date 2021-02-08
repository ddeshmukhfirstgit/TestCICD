public class ListJSON_CC {
	
	public Map<String, JSONFieldWrapper> jsonFieldWrapperMap {get;set;}
	public List<JSONFieldWrapper> jsonFieldWrapperList{set;get;} // this list contain JSONFieldWrapper with the value
	public List<JSONRecordWrapper> jsonRecordWrapper{get;set;} // list of records in the jsonRecordWrapper. This would be the object used to iterate in visualforce
	public List<String> labelOrders {get;set;}
    
    static Integration_Settings__c integrationSettings;
    private string session_id;
    private string instanceUrl;
    
	private String dataRequestLabel;
    private string sObjectId;
     
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
    
    public  ListJSON_CC(){
    	jsonRecordWrapper = new List<JSONRecordWrapper>();
        labelOrders = new List<String>();
    }
    
    /** Get session Id from External*/
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
    
    
    private void populateReponse(String response){
    	
    	JSONParser parser =   JSON.createParser(response);
    
    	/** Parse JSON response as list of object */
    	List<Object> lstwrap =(List<Object>) System.JSON.deserializeUntyped(response);
		
         system.debug('jsonFieldWrapperMap: '+jsonFieldWrapperMap);
        
    	for(Object mapObject : lstwrap){
    		 
    		 /** JSON will be received as Key:value pair, so typecast it into map */
    		 Map<String, Object> contactAttributes = (Map<String, Object>)mapObject;
    		 
    		 JSONRecordWrapper recordWrapperTemp = new JSONRecordWrapper();
				
    		 /** Iterate through map and get individual properties */
			 for (String attributeName : contactAttributes.keyset()) {
			     
                 system.debug('Attribute Name: '+attributeName);
                 
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
    
     
	
	
	public Object invokeInitialRequestForSessionId() {
       
	    /** Login into external system and get session Id */
	    getSessionId();
	    
	    jsonFieldWrapperMap = new Map<String, JSONFieldWrapper>();
	    
	    List<Integration_Config__mdt> metadata = getCustomMetadata('doGet');
	    for(Integration_Config__mdt integrationMdt : metadata){
	    	JSONFieldWrapper wrapper = new JSONFieldWrapper(integrationMdt.JsonName__c, integrationMdt.Label__c, integrationMdt.Order__c);
	    	jsonFieldWrapperMap.put(integrationMdt.JsonName__c,wrapper);
	    }
	    
	    /**Pass Sales order Id here 
	    * @todo: This will be received from Sales order related list under case 
	    */
	    sObjectId = '0019000001mqXPx';
	  
      
      /** Create continuation with a timeout */
      HttpRequest req = new HttpRequest();
    
      integrationSettings = Integration_Settings__c.getValues('Callout Settings');
      req.setEndpoint(instanceUrl+'/services/apexrest/TestManagedPkg/RelatedContacts/'+sObjectId);
      req.setMethod('GET');							  
    
      req.setHeader('Authorization', 'Bearer '+session_id);
      req.setHeader('Content-Type', 'application/json');
    
      Continuation con = new Continuation(60);
      con.continuationMethod='processInitialResponse';
      dataRequestLabel = con.addHttpRequest(req);              
      
       
      // Return the continuation
      return con;  
    }
    
    public Object processInitialResponse() {   
      
      system.debug('Asynch response is received ');
      
      HttpResponse response = Continuation.getResponse(this.dataRequestLabel);
      String initialResponse = response.getBody();
      
      system.debug('REsponse: '+initialResponse);  
        
      populateReponse(initialResponse);
      // Start another continuation 
      return null;  
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