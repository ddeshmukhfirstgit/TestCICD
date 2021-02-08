global with sharing class OppsWithMatches{
    
    global List<Opportunity> Opps{get{
        Opps = [SELECT Id,Name,Description,Amount, (select id, Name from OpportunityLineitems)
                                      FROM Opportunity WHERE Id=:accountId];
        return opps;
    }set;}
    global String accountId{get;set;}
    
    
    global OppsWithMatches(){
      List<Opportunity>  posToDisplay = new List<Opportunity>();
        system.debug('000000000000000000000');
        
             Opps = [SELECT Id,Name,Description,Amount, (select id, Name from OpportunityLineitems)
                                      FROM Opportunity WHERE Id=:accountId];
    }
    
    
    
    
    global String NewLine {
        get { return '\r\n'; }
        set;
    }
    
}