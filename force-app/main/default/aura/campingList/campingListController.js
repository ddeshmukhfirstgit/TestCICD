({
    handleAdditem: function(component, event, helper) {
        var item = event.getParam("item");
        //helper.createItem(component, item);
        
        /** Helper code is placed here*/ 
         var action = component.get("c.saveItem");
        console.log("Action is created!");
        action.setParams({
            "item": item
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
                var items = component.get("v.items");
                items.push(response.getReturnValue());
                component.set("v.items", items);
                console.log(response.getReturnValue()+'This is saved');
            }
            else{
                console.log('Something Happened!!!'+response.getReturnValue());
                console.log(response);
            }
        });
        $A.enqueueAction(action);
        
        /** Helper Code END*/
    },
    //LOAD CAMPINGS FROM SALESFORCE
    doInit : function(component, event, helper){
        
        //create the action
        
        var action = component.get("c.getItems");
        
        //Add callback method
        action.setCallback(this, function(response){
            var state = response.getState();
            //If valid, then set list to component attributes
            
            if(component.isValid() && state == 'SUCCESS'){
                component.set("v.items", response.getReturnValue());
            }
            else{
                console.log("Failed with state: " + state);
            }
        });
        
        
        
        //Enqueue the action
        $A.enqueueAction(action);
    },
})