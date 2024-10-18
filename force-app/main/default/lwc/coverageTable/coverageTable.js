import { LightningElement, api } from 'lwc';

export default class CoverageData extends LightningElement {
    tableHeaders = ['Apex Class', 'Total Lines', 'Covered Lines', 'Uncovered Lines', 'Coverage'];
    tableData;

    handleRunTestsClick() {
        this.fireEvent('testrun');
    }

    @api
    createTableData(coverageData) {
        this.tableData = coverageData.map((data) => {
            const totalLines = data.numLinesCovered + data.numLinesUncovered;
            const coverage = totalLines !== 0 ? Math.round((data.numLinesCovered / totalLines) * 100) : 0;
            return [data.className, totalLines, data.numLinesCovered, data.numLinesUncovered, `${coverage}%`, coverage];
        });
    }

    fireEvent(name) {
        this.dispatchEvent(new CustomEvent(name));
    }
}
