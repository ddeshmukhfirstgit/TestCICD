public with sharing class GetAccountListLWC {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> fetchAccounts() {

            return [Select Id, Name, Website from Account];
    }
}