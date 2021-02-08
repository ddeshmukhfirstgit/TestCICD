({
    //Fetch the accounts from the Apex controller
    getCaseDetails: function(component) {
        var action = component.get("c.getCaseDetails");
        
        action.setParams({"caseId" : "5002800000AvWKj"});
        //Set up the callback
        var self = this;
        action.setCallback(this, function(actionResult) {
            console.log('case returned');
            console.log(actionResult.getReturnValue().Account.Name);
            component.set("v.userCase", actionResult.getReturnValue());     
            this.getSalesOrder(component);
        });
        $A.enqueueAction(action);
    },
    
    //Fetch the accounts from the Apex controller
    getSalesOrder: function(component) {
        var action = component.get("c.getSalesOrder");
        var userCase = component.get("v.userCase");
        action.setParams({"accountId" : userCase.Account.Id});
        //Set up the callback
        var self = this;
        action.setCallback(this, function(actionResult) {
            console.log('case returned');
            console.log(actionResult.getReturnValue());
            var js = JSON.parse(actionResult.getReturnValue());
            console.log('JSON');
            console.log(js);
            component.set("v.contactsOnAccounts", js);     
            
        });
        $A.enqueueAction(action);
    } ,
    
    getProvisionalOrders: function(component) {
        var action = component.get("c.getProvisionDetails");
        
        //Set up the callback
        var self = this;
        action.setCallback(this, function(actionResult) {
            
            var provisionalOrders = JSON.parse(actionResult.getReturnValue());
            console.log('provisionalOrders JSON');
            console.log(provisionalOrders);
            component.set("v.provisionalOrders", provisionalOrders);        
            
            /** for Console
            var navEvt = $A.get("e.force:navigateToSObject");
            navEvt.setParams({
                "recordId": component.get("v.contactsOnAccounts")[0].AccountId,
            });
            navEvt.fire();*/
        });
        $A.enqueueAction(action);
    },
    populateProvisionalTasks : function(component, event) {
    	var provisionalLists = event.getParam("tasks");
        
        component.set("v.provisionalTasks", provisionalLists);   
        console.log(provisionalLists);
        console.log('Tasks received from child component');
    }
})