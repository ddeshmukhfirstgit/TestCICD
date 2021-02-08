({
    rerender: function(cmp, helper) {
        this.superRerender();
 
        // Get the Id and Record View
        var accountId = cmp.get('v.recordId');
        var accountView = cmp.find('accountview');
 
        // Show or Hide the Account View depending on the Id value
        console.log('accountId:'+accountId);
        if (!accountId)
        {
            $A.util.addClass(accountView, 'hideme');
        }
        else
        {
            $A.util.removeClass(accountView, 'hideme');
        }
    },
})