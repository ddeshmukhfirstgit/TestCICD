({
    doInit: function(component, event, helper) {      
        helper.getCaseDetails(component);
         
    },
    handleProvisionalTasksEvent: function(component, event, helper) {      
        helper.populateProvisionalTasks(component, event);
         
    },
    
})