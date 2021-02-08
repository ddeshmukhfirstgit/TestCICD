public class CustomerDetailsPage_CC {
    public string caseId {get;set;}
    public Boolean showCase  {get;set;}
    
    public CustomerDetailsPage_CC(){
        caseId = '5002800000AvWKi';
        showCase = false;
    }
    
    public PageReference setCaseId(){
        String cId = ApexPages.currentPage().getParameters().get('firstParam');
        caseId = '5002800000AvWKk';
        showCase = true;
        system.debug('Case Id: '+caseId);
        
        return null;
    }
}