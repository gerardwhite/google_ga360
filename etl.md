
# Looker/Bigquery POC ETL



| Data Name         | BQ Schema       | ETL Method                              | ETL Freq          | Future State    |
|------------------ |---------------  |---------------------------------------- |-----------------  |---------------- |
| Google Analytics  | Multiple        | BQDTS                                   | 15mins            | Done            |
| Adobe Analytics   | Multiple        |                                         |                   | Done            |
| GfK               | dyson_gfk_opi   | Feed from GfK                           | Daily to weekly   | Done            |
| SAP               |                 | Manual Ingestion via BigQuery Uploader  | Daily             | Plans/BigQuery  |
| Targets           |                 | Manual Ingestion via BigQuery Uploader  | Quarterly         | Plans/BigQuery  |
| Reference Data    |                 | Manual Ingestion via BigQuery Uploader  | Ad-hoc            |                 |
