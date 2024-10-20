import { LightningElement } from 'lwc';
import getClassCoverages from '@salesforce/apex/ApexClassHandler.getClassCoverages';
import runAllTests from '@salesforce/apex/ApexTestRunner.runAllTests';

export default class CoverageManager extends LightningElement {
    coverageData;
    selectedClass;
    isLoading = false;

    connectedCallback() {
        this.updateCoverage();
    }

    handleRowClick(event) {
        const selectedClassName = event.detail;
        this.selectedClass = this.coverageData.find((apexClass) => apexClass.className === selectedClassName);
    }

    handleTestRun() {
        this.updateCoverage();
    }

    async updateCoverage() {
        this.isLoading = true;

        try {
            await runAllTests();
            this.coverageData = await getClassCoverages();

            this.isLoading = false;
            this.template.querySelector('c-coverage-table').createTableData(this.coverageData);
        } catch (e) {
            console.error(e);
        }
    }
}
