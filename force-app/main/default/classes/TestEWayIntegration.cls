public class TestEWayIntegration {
	
    
    public void createCustomer(){
        
        wwwEwayComAuGatewayManagedpayment soapCall = new wwwEwayComAuGatewayManagedpayment();
        wwwEwayComAuGatewayManagedpayment.eWAYHeader header = new wwwEwayComAuGatewayManagedpayment.eWAYHeader();
        header.eWAYCustomerID = '91141674';
        header.Username = 'akshay.deshmukh0@gmail.com.sand';
        header.Password = 'Salesforce88';
        
        wwwEwayComAuGatewayManagedpayment.managedCreditCardPaymentTestSoap  ewayObj  = new wwwEwayComAuGatewayManagedpayment.managedCreditCardPaymentTestSoap ();
        
        String Title = 'Mr.';
        String FirstName = 'Akshay';
        String LastName = 'Deshmukh';
        String  Country='au';
        ewayObj.eWAYHeader = header;
      
        /*
        ewayObj.inputHttpHeaders_x = new Map<String, String>();
        ewayObj.inputHttpHeaders_x.put('eWAYCustomerID','91141674');
        ewayObj.inputHttpHeaders_x.put('Username','akshay.deshmukh0@gmail.com.sand');
        ewayObj.inputHttpHeaders_x.put('Password','Salesforce88');
    	*/
        string res = ewayObj.CreateCustomer('Mr.','AKs','Des','','','','','','au','','','','','','','','','4444333322221111','test',01,24);      
        system.debug('Response : '+res);
            
        if(res != null){
            system.debug('Customer created in eway. Proceeding to payment....');
            
            ewayObj.ProcessPayment( Long.valueOf(res),100,'test','test');
            
        }
    }
    
}