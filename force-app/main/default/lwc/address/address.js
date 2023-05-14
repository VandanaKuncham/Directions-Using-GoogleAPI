import { LightningElement, api } from 'lwc';

export default class Directions extends LightningElement {

    @api address = {
        city: null,
        street: null,
        state: null,
        country: null,
        postalCode: null
    };

    @api addressLabel;
    
    handleAddressChange(event) {
        this.address.street = event.target.street;
        this.address.city = event.target.city;
        this.address.country = event.target.country;
        this.address.postalCode = event.target.postalCode;
        this.address.state = event.target.province;
        console.log('address', JSON.stringify(this.address));
        
    }
}