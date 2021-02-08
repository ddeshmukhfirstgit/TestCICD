import { LightningElement, wire, track } from 'lwc';
import fetchAccounts  from '@salesforce/apex/GetAccountListLWC.fetchAccounts'; 
export default class accountListLwcCmp extends LightningElement {
    //@wire(fetchAccounts) accounts;
    @track accounts;
    @track error;
    @track loading = false;
    @track isModalOpen = false;
    @track record;
    actions = [
        { label: 'Edit', name: 'show_details' },
        { label: 'Delete', name: 'delete' },
    ];
    handleOnClick(){
        this.loading = true;
        fetchAccounts().then(
            result => {
                this.accounts = result;
                this.loading = false;
                
            }).catch(
                error => {
                    this.error = error;
                    this.loading = false;
                }
            );
    }
    handleRowAction(event ){
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        alert(event.detail.action.name);
        switch (actionName) {
            case 'delete_record':
                this.deleteRow(row);
                break;
            case 'edit_record':
                this.showRowDetails(row);
                break;
            
        }
    }

    showRowDetails(row) {
        this.record = row;
        this.isModalOpen = true;
    }

    closeModal(){
        this.isModalOpen = false;
    }

    tableLabels = [
        {label: 'Website', fieldName: 'Website', type: 'url'},
        {label: 'Name', fieldName: 'Name'},
        {label: '', type: 'button-icon',
            fixedWidth: 40,
            typeAttributes: {
                iconName: 'utility:edit',
                name: 'edit_record', 
                title: 'Edit',
                variant: 'bare',
                alternativeText: 'edit',
                disabled: false
            }
        },
        {label: '', type: 'button-icon',
            fixedWidth: 40,
            typeAttributes: {
                iconName: 'utility:delete',
                name: 'delete_record', 
                title: 'Delete',
                variant: 'bare',
                alternativeText: 'Delete',
                disabled: false
            }
        }];

}