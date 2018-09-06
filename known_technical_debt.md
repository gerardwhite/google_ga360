# Known Technical Debt

As we've rushed to complete presentations and the POC we have accrued technical debt. This document attempts to list these areas so we can back-edit at a later date.

* SAP data - running off daily extracts, not a live data source
* Adwords - running off Google Sheets/Drive extracts - we need to set up for BigQuery transfter services to get Adwords data into BigQuery (contact Chris Martin @ Google)
* Demographics - not available in BigQuery/Looker - running off Google Sheets
- blue/fushia for male/female has been manually set, we need to assign conditional formatting here in the LookML
* China/Tmall - running off manual extracts
