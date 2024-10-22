import { LightningElement } from 'lwc';
import getClassCoverages from '@salesforce/apex/ApexClassHandler.getClassCoverages';
import runAllTests from '@salesforce/apex/ApexTestRunner.runAllTests';
import areTestInQueue from '@salesforce/apex/ApexTestRunner.areTestsInQueue';

export default class CoverageManager extends LightningElement {
    coverageData;
    selectedClass;
    isLoading = true;

    async connectedCallback() {
        this.coverageData = await getClassCoverages();
        this.template.querySelector('c-coverage-table').createTableData(this.coverageData);
        this.isLoading = false;
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

            // eslint-disable-next-line @lwc/lwc/no-async-operation
            const intervalId = setInterval(async () => {
                const areTestEnqueued = await areTestInQueue();

                if (!areTestEnqueued) {
                    this.coverageData = await getClassCoverages();
                    this.isLoading = false;
                    this.template.querySelector('c-coverage-table').createTableData(this.coverageData);
                    clearInterval(intervalId);
                }
            }, 1000);
        } catch (e) {
            console.error(e);
        }
    }
}
