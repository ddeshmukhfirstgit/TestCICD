({
	myAction : function(component, event, helper) {
        var action = component.get("c.getAccountDetails");
        action.setParams({acctId : component.get("v.recordId")});
        action.setCallback(this, function(data){
            component.set("v.currentAccount", data.getReturnValue());
            
        });
        $A.enqueueAction(action);
	}
})