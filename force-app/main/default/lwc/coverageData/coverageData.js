import { LightningElement } from 'lwc';
import runAllTests from '@salesforce/apex/ApexTestRunner.runAllTests';
import getClassCoverages from '@salesforce/apex/ApexClassHandler.getClassCoverages';

export default class CoverageData extends LightningElement {
    coverageData;

    tableHeaders = ['Apex Class', 'Total Lines', 'Covered Lines', 'Uncovered Lines', 'Coverage'];
    tableData;

    connectedCallback() {
        this.updateCoverage();
    }

    handleRunTestsClick() {
        this.updateCoverage();
    }

    async updateCoverage() {
        try {
            await runAllTests();
            this.coverageData = await getClassCoverages();
            this.createTableData();
            console.log(JSON.stringify(this.coverageData));
        } catch (e) {
            console.error(e);
        }
    }

    createTableData() {
        this.tableData = this.coverageData.map((data) => {
            const totalLines = data.numLinesCovered + data.numLinesUncovered;
            const coverage = totalLines !== 0 ? Math.round((data.numLinesCovered / totalLines) * 100) : 0;
            return [data.className, totalLines, data.numLinesCovered, data.numLinesUncovered, `${coverage}%`, coverage];
        });
    }
}
