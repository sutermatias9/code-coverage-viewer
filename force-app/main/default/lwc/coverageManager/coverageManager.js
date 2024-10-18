import { LightningElement } from 'lwc';
import getClassCoverages from '@salesforce/apex/ApexClassHandler.getClassCoverages';
import runAllTests from '@salesforce/apex/ApexTestRunner.runAllTests';

export default class CoverageManager extends LightningElement {
    coverageData;

    connectedCallback() {
        this.updateCoverage();
    }

    handleRowClick(event) {
        console.log(event.detail);
    }

    handleTestRun() {
        this.updateCoverage();
    }

    async updateCoverage() {
        try {
            await runAllTests();
            this.coverageData = await getClassCoverages();
            this.template.querySelector('c-coverage-table').createTableData(this.coverageData);
            console.log(JSON.stringify(this.coverageData));

            // this.body = JSON.parse(await getClassBody()); // puedo analizar el JSON y lo rompo en divs [[]..]
        } catch (e) {
            console.error(e);
        }
    }
}
