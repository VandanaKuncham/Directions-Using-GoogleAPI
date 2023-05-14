import { LightningElement } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import getTravelCost from "@salesforce/apex/DirectionsController.getTravelCost";

export default class GetDirections extends LightningElement {
    origin = {};
    destination = {};
    travelOptions = [];
    uiResults = [];
    showSpinner = false;
    error;
    value = 'Driving';
    mode = 'Driving';

    get options() {
        return [
            { label: 'Driving', value: 'Driving'},
            { label: 'Walking', value: 'Walking'},
            { label: 'Biking', value: 'Biking'},
            { label: 'Transit', value: 'Transit'},
        ];
    }
    
    getTravelCost() {
        this.travelOptions = [];
        this.origin = this.template.querySelector(
            "c-address[data-my-id=origin]"
        ).address;
        this.destination = this.template.querySelector(
            "c-address[data-my-id=destination]"
        ).address;      
        if (this.origin.street != null && this.origin.city != null && this.origin.state != null && this.origin.postalCode != null && this.origin.country != null
                && this.destination.street != null && this.destination.city != null && this.destination.state != null && this.destination.postalCode != null  && this.destination.country != null) {
            this.showSpinner = true;
            getTravelCost({
                origin: JSON.stringify(this.origin),
                destination: JSON.stringify(this.destination),
                transportationMode: this.mode
            }).then((result) => {
                if (result) {  
                    console.log('result is', result);   
                    this.showSpinner = false;
                    this.travelOptions = result;
                }
            })
            .catch((error) => {
                console.log('error is' + error.body.message);
                this.showSpinner = false;
                const event = new ShowToastEvent({
                    title: "Error fetching travel details",
                    variant: "error",
                    mode: "sticky",
                    message: error.body.message
                });
                this.dispatchEvent(event); 
            });
        } else {
            const event = new ShowToastEvent({
                title: "Missing Required Information!",
                variant: "error",
                message: "Please verify that the From and To addresses are populated."
            });
            this.dispatchEvent(event);
        }
    }

    handleChange(event) {
        console.log('value is ' + event.detail.value);
        this.mode = event.detail.value;
    }
}