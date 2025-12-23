<img width="1366" height="768" alt="image" src="https://github.com/user-attachments/assets/0a0ae6b8-e1b5-4293-8397-c09b1bf24bd1" /># Portofolio-Data-Analyst-Layoffs-Data-Cleaning-using-MySQL

**Project Overview**

The “**Layoffs**” dataset contains information about employee layoffs that occurred across various global companies.The dataset used contains 2361 records, where each row represents a single layoff event and includes details such as company, location, industry, total laid off, percentage laid off, date, stage, and funds raised (in millions).

The Global Layoffs dataset contains information on company layoffs across various countries, industries, and time periods. However, the raw dataset has several major issues, such as data duplication, category inconsistencies, inconsistent date formats, and missing values.

As a data analyst, the primary challenge is ensuring that the analyzed data is accurate, consistent, and reliable before using it for exploratory data analysis (EDA) and business decision-making.


**The main objectives of this data cleaning project are:**
1. Cleanse raw data from duplication, inconsistencies, and invalid values.
2. Standardize data formats to prepare them for Exploratory Data Analysis (EDA).
3. Improve data quality and reliability so that the resulting insights are not biased or misleading.
4. Prepare a final dataset that is consistent, clean, and ready for analysis using SQL or BI tools.


**Dataset Information**

Source : Global layoffs dataset
Records : Company-level layoff events
Key Columns :
* company
* location
* industry
* total_laid_off
* percentage_laid_off
* date
* stage
* country
* funds_raised_millions


**Tools & Skills Used**

* SQL (MySQL)
* Window Functions (ROW_NUMBER)
* Data Standardization
* Data Enrichment (Self-Join)
* Data Validation & Cleaning
* Analytical Thinking


**Data Cleaning**

1. Delete Duplicates
The data containing duplicates includes the company names Casper, Cazoo, Hibob, Wildlife Studios, and Yahoo. These data contain two duplicates.

<img width="925" height="235" alt="image" src="https://github.com/user-attachments/assets/abff55ff-4f4a-4f3d-a2ee-1fb2af0edfdd" />

The goal of this step is to prevent duplication of layoff information, which can lead to inaccurate analysis results. Duplicate data has the potential to inflate the total number of layoffs, distort time trends, and provide misleading insights for decision-making.

To achieve this goal, the window function ROW_NUMBER() is used with partitioning based on all key attributes of the dataset. This approach ensures that only rows with completely identical structural and value values ​​are considered duplicates. Duplicate rows are then removed, so that each layoff event is represented only once in the dataset.

2. Company Name Standardization

<img width="250" height="202" alt="image" src="https://github.com/user-attachments/assets/83ddb5a9-4ea4-4239-bedc-d18052bd60dd" />

The next step aims to standardize the spelling of company names (trim). The raw data revealed spelling differences caused by spaces at the beginning or end of text, which are technically considered different by the database system. The goal of this process is to ensure consistency in company identity, so that each company is represented as a single entity.

This standardization is crucial to ensure that the aggregation, grouping, and ranking of companies based on the number of layoffs can be carried out accurately without data fragmentation.

3. Standardization of Industrial Categories

<img width="396" height="189" alt="image" src="https://github.com/user-attachments/assets/e4a60bf9-58c5-44ab-ba74-315538095c01" />

The raw data also shows a variety of industry names that substantively refer to the same sector, particularly in the crypto industry. The goal of this step is to avoid fragmentation of industry categories that could obscure layoff patterns and trends at the sector level.

<img width="406" height="180" alt="image" src="https://github.com/user-attachments/assets/f1dc6cc6-4cf1-4af4-9973-57a60823aa1d" />

Additionally, some industries lack a name (null or ' ') but have their industry identity already filled in within the same company. Therefore, it's necessary to match the industry name to the company's non-empty or null industry.
