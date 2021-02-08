({
	loadChevron : function(component, event, helper) {		
        var action = component.get('c.getChevronData');
		var txt_recordId = component.get("v.recordId");
		var txt_FieldName = component.get("v.fieldName");
         action.setParams({
            recordId : txt_recordId,
            fieldName : txt_FieldName 
        });
        action.setStorable();        
        action.setCallback(this, function(res) { 
            console.log(res.getReturnValue());
            alert('got response from server');
            helper.handleCallback(component, event, helper,res); 
        }); 
        $A.enqueueAction(action);  
	},
    loadChevron2 : function(component, event, helper) {		
        var action = component.get('c.getChevronData2');
		var txt_recordId = component.get("v.recordId");
         action.setParams({
            recordId : txt_recordId
        });
        action.setStorable();        
        action.setCallback(this, function(res) { 
                        console.log(res.getReturnValue());

            helper.handleCallback(component, event, helper,res); 
        }); 
        $A.enqueueAction(action);  
	},
    handleCallback : function(component, event, helper,res){
        console.log('In helper:'+res.getState());
        if (res.getState() === 'SUCCESS') { 
            var retJSON = JSON.parse(res.getReturnValue());  
            component.set("v.records",retJSON);
        }
    },
    updateChevronWrapper :function(component, event){
    	var records = component.get("v.records");
        var clickedPathItem =  event.currentTarget.dataset.id;

        for(var key in records){
            
                if(records[key].docId == clickedPathItem){
                    alert('Id matched!');
                    if(records[key].docStatus != 'Passed'){
                    	records[key].cssClass = 'active';
                    }
                    else{
                        records[key].cssClass = 'active visited';
                    }
                }
                else{
                    if(records[key].docStatus != 'Passed'){
                    	records[key].cssClass = '';
                    }
                    else{
                        records[key].cssClass = 'visited';
                    }
                }
            //}
        }
        console.log('updating records');
        component.set("v.records",records);
    },
    createPdfComponent : function(component) {
		$A.createComponent(
            "c:pdfViewer",
            	{
                	"pdfData": component.get("v.pdfData")
            	},
            	function(pdfViewer, status, errorMessage){
                	//alert('PDF status: '+status);
                	if (status === "SUCCESS") {
                  		var pdfContainer = component.get("v.pdfContainer");
                   		component.set("v.pdfContainer", pdfViewer);
                	}
                	else if (status === "INCOMPLETE") {
                    	console.log("No response from server or client is offline.")
                	}
                	else if (status === "ERROR") {
                    	console.log("Error: " + errorMessage);
	                }
       			}
    	);
    	
	}
})