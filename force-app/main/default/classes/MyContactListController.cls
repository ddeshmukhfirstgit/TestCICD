public class MyContactListController {
    
    @AuraEnabled
    public static List<Contact> getContacts( String acctId) {
        return [Select Id, Name, Email, Title, Phone From Contact Where AccountID =: acctId];
    }
    
    @AuraEnabled
    public static Account getAccountDetails( String acctId) {
        return [Select Id, Name,Type, Phone,Rating,Website From Account Where Id =: acctId];
    }
}