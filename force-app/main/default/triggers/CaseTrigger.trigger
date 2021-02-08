trigger CaseTrigger on Case (after insert, after update) {
  
  Set<Id> conIds = new Set<Id>();
  for(Case c : Trigger.new){
        if(c.Second_Contact__c != null){
          conIds.add(c.Second_Contact__c);
        }
  }
  
  List<CaseShare> cShare = new List<CaseShare>();
  List<User> usrList = [select Id from User where ContactId IN : conIds];
  for(Case cs : Trigger.new){
      for(User u : usrList){
        
        if(u.contactId == cs.Second_Contact__c){
           CaseShare cSss = new CaseShare();
           cSss.UserOrGroupId = u.Id;
           cSss.CaseId= cs.Id;
           cSss.rowCause = 'Manual';
            cSss.CaseAccessLevel= 'edit';

            cShare.add(csss);
        }
      }
  }
  
  insert cShare;
}