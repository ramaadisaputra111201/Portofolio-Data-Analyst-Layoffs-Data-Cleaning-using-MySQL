# Portofolio-Data-Analyst-Layoffs-Data-Cleaning-using-MySQL

The “Layoffs” dataset contains information about employee layoffs that occurred across various global companies.The dataset used contains 2361 records, where each row represents a single layoff event and includes details such as company, location, industry, total laid off, percentage laid off, date, stage, and funds raised (in millions).

The purpose of data cleaning in this project is to improve the quality of the layoffs dataset so that the analysis results can serve as a valid and informative basis for decision-making in understanding global layoff trends by time, industry, and region.

The first step was to remove duplicate records by creating a temporary table named layoffs_staging and adding a row_num column using the ROW_NUMBER() function. Rows with duplicate values were deleted to ensure that each company record remained unique.

Next, data standardization was performed, such as removing extra spaces in company names using TRIM(), unifying industry values (for example, changing “Crypto%” to “Crypto”), and removing trailing periods in the country column (“United States.” → “United States”). Missing values in the industry column were also filled in using a self-join based on the same company information.

The date column was converted from text format to the DATE data type using STR_TO_DATE() and DATE to enable time-trend analysis. 

In addition, rows with missing values in total_laid_off and percentage_laid_off were deleted, as they were not relevant for analysis.

Finally, the temporary row_num column was removed to clean up the table structure. As a result, the dataset became clean, consistent, and ready for further analysis, including layoff trend identification, industry impact assessment, and accurate data visualization.
