({
	getJsonFromSource : function(component, event) {
		var actionName = component.get("v.methodName");
        var sObjectId = component.get("v.sObjectId");
        var paramName = component.get("v.parameterName");

        var action = component.get("c."+actionName);
        action.setParams({paramName : sObjectId});
     
        //Set up the callback
        action.setCallback(this, function(actionResult) {
            var response = actionResult.getReturnValue();
            var jsonOutput = JSON.parse(actionResult.getReturnValue());
            console.log('jsonOutput recevied');
            console.log(response);
         
            var key;
            
            var labels;
            
            for(key in jsonOutput){
               labels  = Object.keys( jsonOutput[key]);
              
            }
            var index = labels.indexOf("attributes");
            console.log(labels);
            if (index > -1) {
                labels.splice(index, 1);
            }
            var namesArr = [];
            for(key in labels){
                console.log(labels[key]);
                namesArr.push(labels[key]);
            }
            console.log('setting attribute');
            console.log('setting attribute: '+jsonOutput.length);
          	component.set("v.outputList",jsonOutput);
            component.set("v.outputLabelList",namesArr);
           /*
            var jsonEvent = component.getEvent("jsonOutputEvent");
			jsonEvent.setParams({"jsonOutput" : jsonOutput });
            jsonEvent.setParams({"jsonOutputLabels" : labels });
            jsonEvent.fire();
			console.log('Event Fired');*/
        });
        $A.enqueueAction(action);
	}
})