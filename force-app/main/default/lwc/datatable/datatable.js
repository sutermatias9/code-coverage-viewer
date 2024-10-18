import { LightningElement, api } from 'lwc';

export default class Datatable extends LightningElement {
    @api headers;
    @api rowsData; // [[],[]...]
}
