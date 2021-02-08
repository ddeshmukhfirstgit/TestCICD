/**
 * @Author	:	Jitendra Zaa
 * @Date	:	17 Sep 2017
 * @Desc	:	Controller for Lightning Component "ReadOnlyChevron"
 * 
 * */
public class ReadOnlyChevronController {
    @AuraEnabled
    public static String getChevronData(String recId,String fieldName){ 
        //For Demo purpose
        if(recId == null){
            recId = '5002800000AvWKiAAN';
        }        
        // Logic as per Q 112 : Dynamic Apex
        // http://www.jitendrazaa.com/blog/salesforce/salesforce-interview-question-part-12/         
        List<Schema.SObjectType> gd = Schema.getGlobalDescribe().Values();
        Map<String,String> objectMap = new Map<String,String>();
        for(Schema.SObjectType f : gd)
        {
             objectMap.put(f.getDescribe().getKeyPrefix(), f.getDescribe().getName());
        }
        String prefix =  recId.left(3); 
        String objectName = objectMap.get(prefix);
        String query = 'SELECT '+fieldName+' FROM '+objectName+' WHERE Id =: recId';        
        
        
        List<SOBject> lstObj = Database.query(query);        
        String selVal =  String.valueOf(lstObj[0].get(fieldName)) ;  
        Schema.SObjectField sobjField = Schema.getGlobalDescribe().get(objectName).getDescribe().Fields.getMap().get(fieldName) ;
        Schema.DescribeFieldResult fieldResult = sobjField.getDescribe() ;
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();        
        Boolean curValMatched = false;
        Integer widthPerItem = 100/ple.size() ;
        List<chevronData> lstRet = new List<chevronData>();        
        for( Schema.PicklistEntry f : ple)
        {
            chevronData obj = new chevronData();
            obj.val = f.getLabel();
            obj.width = widthPerItem+'%';            
            if(obj.val == selVal){
                obj.cssClass = 'active';
                curValMatched = true;
            }
            else if(curValMatched){
                obj.cssClass = '';
            }else{
                obj.cssClass = 'visited'; 
            } 
            lstRet.add(obj);
        } 
        return JSON.serialize(lstRet);
    }  
    
    @AuraEnabled
    public static String getChevronData2(String recId){ 
        

           	List<Required_Doc__c> rDocs =  [Select Id, Status__c
    											 From Required_Doc__c 
    											 WHERE Case__c = '5002800000AvWKiAAN' 
    											 ];
        
               
        Boolean curValMatched = false;
        Integer widthPerItem = 100/rDocs.size() ;
        List<chevronData> lstRet = new List<chevronData>();        
        for( Required_Doc__c rd : rDocs)
        {
            chevronData obj = new chevronData();
            obj.val = rd.Status__c;
            obj.docId = rd.Id;
            obj.docStatus = rd.Status__c;
            obj.width = widthPerItem+'%';            
            if(!curValMatched && obj.val == 'Not Done'){
                obj.cssClass = 'active';
                curValMatched = true;
            }
            else if(obj.val == 'Passed'){
                obj.cssClass = 'visited';
            }
            
            lstRet.add(obj);
        } 
        return JSON.serialize(lstRet);
    }  
    
    @AuraEnabled 
    public static String  getDocumentDetails(String requireDocId){
    	
    	//create set of Id as a workaround for restriction
    	Set<Id> docIds = new Set<Id>();
    	docIds.add(Id.valueOf(requireDocId));
    	
    	// Implementation restriction: ContentDocumentLink requires a filter by a single Id on ContentDocumentId or LinkedEntityId using the equals operator or multiple Id's using the IN operator.
    	//this should return only on record
    	List<ContentDocumentLink> docLinks = [Select c.LinkedEntityId, c.ContentDocument.Id, c.ContentDocumentId From ContentDocumentLink c Where LinkedEntityId IN : docIds];
    	
    	if(docLinks.isEmpty())
    		return 'File not found!';
    	ContentVersion fileData = [Select c.VersionData, c.Title, c.FileExtension, c.ContentDocument.Id, c.ContentDocumentId From ContentVersion c Where c.ContentDocument.Id =: docLinks[0].ContentDocumentId];
   
    	    	
    	
    	String strData = EncodingUtil.base64Encode(fileData.VersionData);
    	
    	return EncodingUtil.base64Encode(fileData.VersionData);
    	
    }
    
    public class chevronData{
        public String val{get;set;}
        public String cssClass{get;set;}
        public String width {get;set;}
        public String docId {get;set;}
        public String docStatus {get;set;}
    }
}