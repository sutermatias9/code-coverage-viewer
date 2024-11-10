# Apex Code Coverage Viewer
## Quick Demo

[![Code Coverage Viewer](https://img.youtube.com/vi/xv5-8q2yGdU/sddefault.jpg)](https://www.youtube.com/watch?v=xv5-8q2yGdU)

## Technologies

  - **Apex**, **SOQL**
  - **Lightning Web Components (LWC)**: HTML, CSS, Javascript
  - **Lightning Design System** (SLDS)

## Overview
### Description
This project is a LWC application that helps developers easily track and visualize the code coverage of Apex classes. It's integrated with Tooling API to gather coverage data, run unit tests, and display the results in a table. The application also highlights the lines of code in the Apex class body that are covered by tests, making it easier to identify gaps in test coverage and optimize code quality.

The Tooling API is a Salesforce API that allows developers to interact with metadata and manage code-related information. These are the following objects that were used:

- **ApexCodeCoverageAggregate**: Used to retrieve code coverage information for Apex classes.
- **ApexTestQueueItem**: Represents a queued test in the system.
- **ApexTrigger**: Used to retrieve information about Apex triggers in the org.
- **ApexClass**: Represents Apex classes in the org.

### Features

- **Real-Time Text Execution**: Run all unit tests with the click of a button and instantly update coverage data.
- **Interactive Table**: View coverage details for each class, including:
  + Number of covered and uncovered lines
  + Percentage of coverage
- **Code Coverage Viewer**: View Apex class code with covered and uncovered lines highlighted.
     



