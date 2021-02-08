({
	createCamping : function(component,newItem) {
		
        var campings = component.get("v.items");
        
        var item = JSON.parse(JSON.stringify(newItem));
        
        campings.push(item);
        
        component.set("v.items",campings);
	},
    createItem : function(component, camping) {
        var action = component.get("c.saveItem");
        console.log("Action is created!");
        action.setParams({
            "item": camping
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
    },
})