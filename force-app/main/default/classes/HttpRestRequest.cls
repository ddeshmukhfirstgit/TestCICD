public abstract class HttpRestRequest {
	public class HttpRestRequestException extends Exception {}

    /**
     * Methods to create a GCP Rest request
     */ 
    protected abstract String getURL();
    protected abstract Map<String,String> getHeaders();
    protected abstract String getMethod();
    protected abstract String getBody();    
    
    /**
     * Make request and call response parser logic to handle a REST Client response     
     */             
    public void makeRequest() {        
        HttpRestClient restClient = new HttpRestClient(getURL(), getMethod(), getHeaders(), getBody());
        HttpResponse response = restClient.doCallout();
        System.debug(LoggingLevel.Info, 'Response body :' + response.getBody());
        
        if(response == null || String.isBlank(response.getBody())) {
            throw new HttpRestRequestException('No response received from CI Service');
        }
        if(response.getBody().containsIgnoreCase('gateway timeout') || response.getStatusCode() == 504) {
           	throw new HttpRestRequestException('Gateway Timeout'); 
        }     
        
        Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());        
        if(responseMap.containsKey('Error')) {
            String errorMsg = '';
            Map<String, Object>  m = (Map<String, Object>)responseMap.get('Error');
            errorMsg = (String) m.get('ErrorMessage');
            throw new HttpRestRequestException(errorMsg);
        }       
        //return responseParser.parse(response);
    } 

}