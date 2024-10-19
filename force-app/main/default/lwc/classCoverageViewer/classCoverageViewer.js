import { LightningElement, api } from 'lwc';

export default class ClassCoverageViewer extends LightningElement {
    _apexClass;
    bodyLines;

    @api
    set apexClass(value) {
        this._apexClass = value;

        if (this.apexClass) {
            const lines = JSON.parse(this.apexClass.body).split('\n');

            this.bodyLines = lines.map((line, index) => {
                return { id: this.apexClass.className + index, index: index + 1, line };
            });
        }
    }

    get apexClass() {
        return this._apexClass;
    }
}
