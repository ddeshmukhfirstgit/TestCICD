//Generated by wsdl2apex

public class AsyncWwwEwayComAuGatewayManagedpayment {
    public class QueryCustomerResponse_elementFuture extends System.WebServiceCalloutFuture {
        public wwwEwayComAuGatewayManagedpayment.CreditCard getValue() {
            wwwEwayComAuGatewayManagedpayment.QueryCustomerResponse_element response = (wwwEwayComAuGatewayManagedpayment.QueryCustomerResponse_element)System.WebServiceCallout.endInvoke(this);
            return response.QueryCustomerResult;
        }
    }
    public class CreateCustomerResponse_elementFuture extends System.WebServiceCalloutFuture {
        public String getValue() {
            wwwEwayComAuGatewayManagedpayment.CreateCustomerResponse_element response = (wwwEwayComAuGatewayManagedpayment.CreateCustomerResponse_element)System.WebServiceCallout.endInvoke(this);
            return response.CreateCustomerResult;
        }
    }
    public class QueryPaymentResponse_elementFuture extends System.WebServiceCalloutFuture {
        public wwwEwayComAuGatewayManagedpayment.ArrayOfManagedTransaction getValue() {
            wwwEwayComAuGatewayManagedpayment.QueryPaymentResponse_element response = (wwwEwayComAuGatewayManagedpayment.QueryPaymentResponse_element)System.WebServiceCallout.endInvoke(this);
            return response.QueryPaymentResult;
        }
    }
    public class ProcessPaymentWithCVNResponse_elementFuture extends System.WebServiceCalloutFuture {
        public wwwEwayComAuGatewayManagedpayment.CCPaymentResponse getValue() {
            wwwEwayComAuGatewayManagedpayment.ProcessPaymentWithCVNResponse_element response = (wwwEwayComAuGatewayManagedpayment.ProcessPaymentWithCVNResponse_element)System.WebServiceCallout.endInvoke(this);
            return response.ewayResponse;
        }
    }
    public class ProcessPaymentResponse_elementFuture extends System.WebServiceCalloutFuture {
        public wwwEwayComAuGatewayManagedpayment.CCPaymentResponse getValue() {
            wwwEwayComAuGatewayManagedpayment.ProcessPaymentResponse_element response = (wwwEwayComAuGatewayManagedpayment.ProcessPaymentResponse_element)System.WebServiceCallout.endInvoke(this);
            return response.ewayResponse;
        }
    }
    public class QueryCustomerByReferenceResponse_elementFuture extends System.WebServiceCalloutFuture {
        public wwwEwayComAuGatewayManagedpayment.CreditCard getValue() {
            wwwEwayComAuGatewayManagedpayment.QueryCustomerByReferenceResponse_element response = (wwwEwayComAuGatewayManagedpayment.QueryCustomerByReferenceResponse_element)System.WebServiceCallout.endInvoke(this);
            return response.QueryCustomerByReferenceResult;
        }
    }
    public class ProcessPaymentWithBeagleResponse_elementFuture extends System.WebServiceCalloutFuture {
        public wwwEwayComAuGatewayManagedpayment.CCPaymentResponse getValue() {
            wwwEwayComAuGatewayManagedpayment.ProcessPaymentWithBeagleResponse_element response = (wwwEwayComAuGatewayManagedpayment.ProcessPaymentWithBeagleResponse_element)System.WebServiceCallout.endInvoke(this);
            return response.ewayResponse;
        }
    }
    public class UpdateCustomerResponse_elementFuture extends System.WebServiceCalloutFuture {
        public Boolean getValue() {
            wwwEwayComAuGatewayManagedpayment.UpdateCustomerResponse_element response = (wwwEwayComAuGatewayManagedpayment.UpdateCustomerResponse_element)System.WebServiceCallout.endInvoke(this);
            return response.UpdateCustomerResult;
        }
    }
    public class AsyncmanagedCreditCardPaymentTestSoap {
        public String endpoint_x = 'https://www.eway.com.au/gateway/ManagedPaymentService/test/managedcreditcardpayment.asmx';
        public Map<String,String> inputHttpHeaders_x;
        public String clientCertName_x;
        public Integer timeout_x;
        public wwwEwayComAuGatewayManagedpayment.eWAYHeader eWAYHeader;
        private String eWAYHeader_hns = 'eWAYHeader=https://www.eway.com.au/gateway/managedpayment';
        private String[] ns_map_type_info = new String[]{'https://www.eway.com.au/gateway/managedpayment', 'wwwEwayComAuGatewayManagedpayment'};
        public AsyncWwwEwayComAuGatewayManagedpayment.QueryCustomerResponse_elementFuture beginQueryCustomer(System.Continuation continuation,Long managedCustomerID) {
            wwwEwayComAuGatewayManagedpayment.QueryCustomer_element request_x = new wwwEwayComAuGatewayManagedpayment.QueryCustomer_element();
            request_x.managedCustomerID = managedCustomerID;
            return (AsyncWwwEwayComAuGatewayManagedpayment.QueryCustomerResponse_elementFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              AsyncWwwEwayComAuGatewayManagedpayment.QueryCustomerResponse_elementFuture.class,
              continuation,
              new String[]{endpoint_x,
              'https://www.eway.com.au/gateway/managedpayment/QueryCustomer',
              'https://www.eway.com.au/gateway/managedpayment',
              'QueryCustomer',
              'https://www.eway.com.au/gateway/managedpayment',
              'QueryCustomerResponse',
              'wwwEwayComAuGatewayManagedpayment.QueryCustomerResponse_element'}
            );
        }
        public AsyncWwwEwayComAuGatewayManagedpayment.CreateCustomerResponse_elementFuture beginCreateCustomer(System.Continuation continuation,String Title,String FirstName,String LastName,String Address,String Suburb,String State,String Company,String PostCode,String Country,String Email,String Fax,String Phone,String Mobile,String CustomerRef,String JobDesc,String Comments,String URL,String CCNumber,String CCNameOnCard,Integer CCExpiryMonth,Integer CCExpiryYear) {
            wwwEwayComAuGatewayManagedpayment.CreateCustomer_element request_x = new wwwEwayComAuGatewayManagedpayment.CreateCustomer_element();
            request_x.Title = Title;
            request_x.FirstName = FirstName;
            request_x.LastName = LastName;
            request_x.Address = Address;
            request_x.Suburb = Suburb;
            request_x.State = State;
            request_x.Company = Company;
            request_x.PostCode = PostCode;
            request_x.Country = Country;
            request_x.Email = Email;
            request_x.Fax = Fax;
            request_x.Phone = Phone;
            request_x.Mobile = Mobile;
            request_x.CustomerRef = CustomerRef;
            request_x.JobDesc = JobDesc;
            request_x.Comments = Comments;
            request_x.URL = URL;
            request_x.CCNumber = CCNumber;
            request_x.CCNameOnCard = CCNameOnCard;
            request_x.CCExpiryMonth = CCExpiryMonth;
            request_x.CCExpiryYear = CCExpiryYear;
            return (AsyncWwwEwayComAuGatewayManagedpayment.CreateCustomerResponse_elementFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              AsyncWwwEwayComAuGatewayManagedpayment.CreateCustomerResponse_elementFuture.class,
              continuation,
              new String[]{endpoint_x,
              'https://www.eway.com.au/gateway/managedpayment/CreateCustomer',
              'https://www.eway.com.au/gateway/managedpayment',
              'CreateCustomer',
              'https://www.eway.com.au/gateway/managedpayment',
              'CreateCustomerResponse',
              'wwwEwayComAuGatewayManagedpayment.CreateCustomerResponse_element'}
            );
        }
        public AsyncWwwEwayComAuGatewayManagedpayment.QueryPaymentResponse_elementFuture beginQueryPayment(System.Continuation continuation,Long managedCustomerID) {
            wwwEwayComAuGatewayManagedpayment.QueryPayment_element request_x = new wwwEwayComAuGatewayManagedpayment.QueryPayment_element();
            request_x.managedCustomerID = managedCustomerID;
            return (AsyncWwwEwayComAuGatewayManagedpayment.QueryPaymentResponse_elementFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              AsyncWwwEwayComAuGatewayManagedpayment.QueryPaymentResponse_elementFuture.class,
              continuation,
              new String[]{endpoint_x,
              'https://www.eway.com.au/gateway/managedpayment/QueryPayment',
              'https://www.eway.com.au/gateway/managedpayment',
              'QueryPayment',
              'https://www.eway.com.au/gateway/managedpayment',
              'QueryPaymentResponse',
              'wwwEwayComAuGatewayManagedpayment.QueryPaymentResponse_element'}
            );
        }
        public AsyncWwwEwayComAuGatewayManagedpayment.ProcessPaymentWithCVNResponse_elementFuture beginProcessPaymentWithCVN(System.Continuation continuation,Long managedCustomerID,Integer amount,String invoiceReference,String invoiceDescription,String cvn) {
            wwwEwayComAuGatewayManagedpayment.ProcessPaymentWithCVN_element request_x = new wwwEwayComAuGatewayManagedpayment.ProcessPaymentWithCVN_element();
            request_x.managedCustomerID = managedCustomerID;
            request_x.amount = amount;
            request_x.invoiceReference = invoiceReference;
            request_x.invoiceDescription = invoiceDescription;
            request_x.cvn = cvn;
            return (AsyncWwwEwayComAuGatewayManagedpayment.ProcessPaymentWithCVNResponse_elementFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              AsyncWwwEwayComAuGatewayManagedpayment.ProcessPaymentWithCVNResponse_elementFuture.class,
              continuation,
              new String[]{endpoint_x,
              'https://www.eway.com.au/gateway/managedpayment/ProcessPaymentWithCVN',
              'https://www.eway.com.au/gateway/managedpayment',
              'ProcessPaymentWithCVN',
              'https://www.eway.com.au/gateway/managedpayment',
              'ProcessPaymentWithCVNResponse',
              'wwwEwayComAuGatewayManagedpayment.ProcessPaymentWithCVNResponse_element'}
            );
        }
        public AsyncWwwEwayComAuGatewayManagedpayment.ProcessPaymentResponse_elementFuture beginProcessPayment(System.Continuation continuation,Long managedCustomerID,Integer amount,String invoiceReference,String invoiceDescription) {
            wwwEwayComAuGatewayManagedpayment.ProcessPayment_element request_x = new wwwEwayComAuGatewayManagedpayment.ProcessPayment_element();
            request_x.managedCustomerID = managedCustomerID;
            request_x.amount = amount;
            request_x.invoiceReference = invoiceReference;
            request_x.invoiceDescription = invoiceDescription;
            return (AsyncWwwEwayComAuGatewayManagedpayment.ProcessPaymentResponse_elementFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              AsyncWwwEwayComAuGatewayManagedpayment.ProcessPaymentResponse_elementFuture.class,
              continuation,
              new String[]{endpoint_x,
              'https://www.eway.com.au/gateway/managedpayment/ProcessPayment',
              'https://www.eway.com.au/gateway/managedpayment',
              'ProcessPayment',
              'https://www.eway.com.au/gateway/managedpayment',
              'ProcessPaymentResponse',
              'wwwEwayComAuGatewayManagedpayment.ProcessPaymentResponse_element'}
            );
        }
        public AsyncWwwEwayComAuGatewayManagedpayment.QueryCustomerByReferenceResponse_elementFuture beginQueryCustomerByReference(System.Continuation continuation,String CustomerReference) {
            wwwEwayComAuGatewayManagedpayment.QueryCustomerByReference_element request_x = new wwwEwayComAuGatewayManagedpayment.QueryCustomerByReference_element();
            request_x.CustomerReference = CustomerReference;
            return (AsyncWwwEwayComAuGatewayManagedpayment.QueryCustomerByReferenceResponse_elementFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              AsyncWwwEwayComAuGatewayManagedpayment.QueryCustomerByReferenceResponse_elementFuture.class,
              continuation,
              new String[]{endpoint_x,
              'https://www.eway.com.au/gateway/managedpayment/QueryCustomerByReference',
              'https://www.eway.com.au/gateway/managedpayment',
              'QueryCustomerByReference',
              'https://www.eway.com.au/gateway/managedpayment',
              'QueryCustomerByReferenceResponse',
              'wwwEwayComAuGatewayManagedpayment.QueryCustomerByReferenceResponse_element'}
            );
        }
        public AsyncWwwEwayComAuGatewayManagedpayment.ProcessPaymentWithBeagleResponse_elementFuture beginProcessPaymentWithBeagle(System.Continuation continuation,Long managedCustomerID,Integer amount,String invoiceReference,String invoiceDescription,String cvn,String ipAddress,String billingCountry) {
            wwwEwayComAuGatewayManagedpayment.ProcessPaymentWithBeagle_element request_x = new wwwEwayComAuGatewayManagedpayment.ProcessPaymentWithBeagle_element();
            request_x.managedCustomerID = managedCustomerID;
            request_x.amount = amount;
            request_x.invoiceReference = invoiceReference;
            request_x.invoiceDescription = invoiceDescription;
            request_x.cvn = cvn;
            request_x.ipAddress = ipAddress;
            request_x.billingCountry = billingCountry;
            return (AsyncWwwEwayComAuGatewayManagedpayment.ProcessPaymentWithBeagleResponse_elementFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              AsyncWwwEwayComAuGatewayManagedpayment.ProcessPaymentWithBeagleResponse_elementFuture.class,
              continuation,
              new String[]{endpoint_x,
              'https://www.eway.com.au/gateway/managedpayment/ProcessPaymentWithBeagle',
              'https://www.eway.com.au/gateway/managedpayment',
              'ProcessPaymentWithBeagle',
              'https://www.eway.com.au/gateway/managedpayment',
              'ProcessPaymentWithBeagleResponse',
              'wwwEwayComAuGatewayManagedpayment.ProcessPaymentWithBeagleResponse_element'}
            );
        }
        public AsyncWwwEwayComAuGatewayManagedpayment.UpdateCustomerResponse_elementFuture beginUpdateCustomer(System.Continuation continuation,Long managedCustomerID,String Title,String FirstName,String LastName,String Address,String Suburb,String State,String Company,String PostCode,String Country,String Email,String Fax,String Phone,String Mobile,String CustomerRef,String JobDesc,String Comments,String URL,String CCNumber,String CCNameOnCard,Integer CCExpiryMonth,Integer CCExpiryYear) {
            wwwEwayComAuGatewayManagedpayment.UpdateCustomer_element request_x = new wwwEwayComAuGatewayManagedpayment.UpdateCustomer_element();
            request_x.managedCustomerID = managedCustomerID;
            request_x.Title = Title;
            request_x.FirstName = FirstName;
            request_x.LastName = LastName;
            request_x.Address = Address;
            request_x.Suburb = Suburb;
            request_x.State = State;
            request_x.Company = Company;
            request_x.PostCode = PostCode;
            request_x.Country = Country;
            request_x.Email = Email;
            request_x.Fax = Fax;
            request_x.Phone = Phone;
            request_x.Mobile = Mobile;
            request_x.CustomerRef = CustomerRef;
            request_x.JobDesc = JobDesc;
            request_x.Comments = Comments;
            request_x.URL = URL;
            request_x.CCNumber = CCNumber;
            request_x.CCNameOnCard = CCNameOnCard;
            request_x.CCExpiryMonth = CCExpiryMonth;
            request_x.CCExpiryYear = CCExpiryYear;
            return (AsyncWwwEwayComAuGatewayManagedpayment.UpdateCustomerResponse_elementFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              AsyncWwwEwayComAuGatewayManagedpayment.UpdateCustomerResponse_elementFuture.class,
              continuation,
              new String[]{endpoint_x,
              'https://www.eway.com.au/gateway/managedpayment/UpdateCustomer',
              'https://www.eway.com.au/gateway/managedpayment',
              'UpdateCustomer',
              'https://www.eway.com.au/gateway/managedpayment',
              'UpdateCustomerResponse',
              'wwwEwayComAuGatewayManagedpayment.UpdateCustomerResponse_element'}
            );
        }
    }
}