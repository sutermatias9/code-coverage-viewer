import { LightningElement, api } from 'lwc';

export default class Datatable extends LightningElement {
    @api headers;
    @api rowsData; // [[],[]...]

    handleRowClick(event) {
        event.preventDefault();
        const firstCellValue = this.getFirstCell(event.currentTarget);
        this.fireEvent(firstCellValue);
    }

    getFirstCell(rowElement) {
        return rowElement.querySelector('th a').textContent;
    }

    fireEvent(detail) {
        const event = new CustomEvent('rowclick', { detail, bubbles: true, composed: true });
        this.dispatchEvent(event);
    }
}
