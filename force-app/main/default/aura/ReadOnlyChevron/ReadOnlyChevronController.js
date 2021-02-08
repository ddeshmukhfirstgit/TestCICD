({
	loadChevron : function(component, event, helper) {
        alert('getting chevron');
		helper.loadChevron2(component, event, helper);
	},
    updateChevron : function(component, event, helper) {
    	
        helper.updateChevronWrapper(component, event);    
    },
    openPdfViewer : function(component, event, helper) {
        alert('getting pdf');
        helper.updateChevronWrapper(component, event);
    	var selectedReqDocId = event.currentTarget.dataset.id;
        component.set("v.selectedDocId",selectedReqDocId);
		
		
		var action = component.get("c.getDocumentDetails");
        
        action.setParams({ 
        	requireDocId : selectedReqDocId
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                if(result == 'File not found!'){
                	var toastEvent = $A.get("e.force:showToast");
				    toastEvent.setParams({
				        "message": result,
				        "type":"info"
				    });
				    toastEvent.fire();
                }
                else{
                	component.set('v.pdfData',result.toString());
                	helper.createPdfComponent(component);
                
                } 
            }
            else if (state === "INCOMPLETE") {
            }
                else if (state === "ERROR") {
                    console.log('Error: ');
                }
        });
        $A.enqueueAction(action);
    }
})