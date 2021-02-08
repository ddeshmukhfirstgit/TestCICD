({
	clickCreateExpense : function(component, event, helper) {
        
        var validExpense = true;
        
        var nameField = component.find("expname");
        var expname = nameField.get("v.value");
        
        if($A.util.isEmpty(expname)){
            validExpense = false;
            nameField.set("v.errors",[{message:"Expense name can't be blank"}]);
        }
        else{
            nameField.set("v.errors",null);
        }
        
        // If we pass error checking, do some real work
        if(validExpense){
            // Create the new expense
            var newExpense = component.get("v.newExpense");
            //console.log('Create Expense: '+JSON.stringify(newExpense));
            helper.createExpense(component,newExpense);
        }
    },
})