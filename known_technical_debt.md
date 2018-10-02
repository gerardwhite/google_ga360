# Known Technical Debt

As we've rushed to complete presentations and the POC we have accrued technical debt. This document attempts to list these areas so we can back-edit at a later date.

* SAP data - running off daily extracts, not a live data source
* Adwords - running off Google Sheets/Drive extracts - we need to set up for BigQuery transfter services to get Adwords data into BigQuery (contact Chris Martin @ Google)
* Demographics - not available in BigQuery/Looker - running off Google Sheets
    * Blue/fushia for male/female has been manually set, we need to assign conditional formatting here in the LookML
* China/Tmall - running off manual extracts
* Some tables in BigQuery redundant. Worth removing.
* Table/view naming need cleaning up.
* Worth rolling up some views, as has been done in the ga_block to reduce junk and/or add folders when these are available.
* Currency symbols have been manually added to some KPI blocks and charts, to suit the POC/presentation. We need to create a lookup table for currency symbol by country (and local analytics logic)
* Country rank needs to be converted into 1st, 2nd, 3rd, 4th + nth fields.  For text 'insights' tiles
* Red and green style reports should be converted to up/down arrows rather than blocks of red and green.  An example for which sits on dashboard 99 (KPI change by device).
*
