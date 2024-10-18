import { LightningElement } from 'lwc';
import runAllTests from '@salesforce/apex/ApexTestRunner.runAllTests';
import getClassCoverages from '@salesforce/apex/ApexClassHandler.getClassCoverages';
import getClassBody from '@salesforce/apex/ApexClassHandler.getClassBody';

export default class CoverageData extends LightningElement {
    body;
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

            this.body = JSON.parse(await getClassBody()); // puedo analizar el JSON y lo rompo en divs [[]..]
            this.bodysplit = this.body.split('\n');
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
