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

    renderedCallback() {
        if (this.bodyLines) {
            this.highlightLines();
        }
    }

    highlightLines() {
        const { coveredLines, uncoveredLines } = this.apexClass;
        const lines = this.template.querySelectorAll('div[data-index]');

        lines.forEach((line) => {
            const lineIndex = parseInt(line.dataset.index, 10);

            if (coveredLines.includes(lineIndex)) {
                line.classList.add('covered');
            } else if (uncoveredLines.includes(lineIndex)) {
                line.classList.add('uncovered');
            }
        });
    }
}
