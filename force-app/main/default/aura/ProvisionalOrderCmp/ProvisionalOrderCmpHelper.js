({
	getProvisionalTasks: function(component, event) {
        var action = component.get("c.getProvisionalTasks");
         action.setParams({"conId" : component.get("v.selectedContact").Id});
        //Set up the callback
        var self = this;
        action.setCallback(this, function(actionResult) {
            
            var provisionalTasks = JSON.parse(actionResult.getReturnValue());
            console.log('provisionalTasks recevied');
            console.log(provisionalTasks);
            var compEvent = component.getEvent("provisionalTasksEvent");
			compEvent.setParams({"tasks" : provisionalTasks });
            compEvent.fire();
			console.log('Event Fired');
                 
        });
        $A.enqueueAction(action);
    }, 
})