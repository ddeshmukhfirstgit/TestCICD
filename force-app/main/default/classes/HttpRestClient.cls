public class HttpRestClient {
	public class RestClientException extends Exception {}
    
    private Map<String,String> headers;
    private String url;
    private String method;
    private String body;
    
    // Default HTTP Timeout
    public Integer TIMEOUT = 120000; 
    // should we print debug statements?
    private Boolean DEBUG = true; 
    private String BLANK_URL_MSG = 'URL should not be empty';
    private String BLANK_METHOD_MSG = 'HTTP Method should not be null';
    
    /*
	 * Constructor
	 */        
    
    public HttpRestClient(String url, String method, Map<String,String> headers, String body) {
    	if(String.isBlank(url))
    		throw new RestClientException(BLANK_URL_MSG);
    	if(String.isBlank(method))
    		throw new RestClientException(BLANK_METHOD_MSG);    		            
    	this.url = url;
    	this.method = method;
    	this.headers = headers;
    	this.body = body;
    }    
    
    public HttpResponse doCallout() {
        Http h = new Http();
        HttpRequest request = buildRequest();
        HttpResponse response = sendRequest(h, request);
        return response;
    }

    /*
	 * private helper Methods
	 */    
    private HttpRequest buildRequest(){
        HttpRequest request = new HttpRequest();
        request.setTimeout(TIMEOUT); // timeout in milliseconds 
        if (headers != null) {
            for(String hkey : headers.keySet()){
                request.setHeader(hkey, headers.get(hkey)); 
            } 
            
          system.debug('Headers :'+headers);  
        }
        request.setEndpoint(url);
        request.setMethod(method);
        if (body != null && body.length() > 0) {
            request.setBody(body);
        }
        return request;
    }        
    
    private HttpResponse sendRequest(Http h, HttpRequest request){
		HttpResponse response = h.send(request);
        return response;    
    }  

}