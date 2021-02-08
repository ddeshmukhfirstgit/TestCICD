({
	submitForm  : function(component, event, helper) {
        
        var isCampingValid = true;
        var nameField = component.find("campingName");
        var quantityField = component.find("quantity");
        var priceField = component.find("price");
        
        if(nameField.get("v.value") == '' ){
            nameField.set("v.errors",[{message:"name can't be blank"}]);
            isCampingValid = false;
        }
        else{
            nameField.set("v.errors",null);
        }
        
        
        if( quantityField.get("v.value") == '' ){
            quantityField.set("v.errors",[{message:"Quantity can't be blank"}]);
            isCampingValid = false;
        }
        else{
            quantityField.set("v.errors",null);
        }
        
        
        if(priceField.get("v.value") == ''){
            priceField.set("v.errors",[{message:"Price can't be blank"}]);
            isCampingValid = false;
        }
        else{
            priceField.set("v.errors",null); 
        }
        
        if(isCampingValid){
            var newCampingItem = component.get("v.newItem");
            helper.createItem(component,newCampingItem);
            
            /*var campings = component.get("v.items");
            var item = JSON.parse(JSON.stringify(newCampingItem));
            
            campings.push(item);
            
            component.set("v.items",campings);
            component.set("v.newItem",{ 'sobjectType': 'Camping_Item__c','Name': '','Quantity__c': 0,
                                       'Price__c': 0,'Packed__c': false });
            */                           
        }
        
        
        
    },
})