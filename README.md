## Project: COVID-19 Data Exploration

COVID-19 data was visualized and explored using SQL and Tableau to see how the disease was spread over time and how different parts of the world were affected

### Data Source Used

https://ourworldindata.org/explorers/coronavirus-data-explorer?zoomToSelection=true&facet=none&pickerSort=asc&pickerMetric=location&Interval=7-day+rolling+average&Relative+to+Population=true&Align+outbreaks=false&country=USA~GBR~CAN~DEU~ITA~IND&Metric=Confirmed+cases

### Transforming Data for SQL Queries
The queries were used to see the percent of the population that had been infected and the death percentage of people infected.  Temporary tables and table joins were used to measure a variety of statistics in which included the sum of cases, deaths, and vaccinations over a period of time.

The two joined tables that were focused:
* Table 1: covid_deaths
* Table 2: covid_vaccinations

### Data Visualization
Visualizations of the dataset were displayed in tableau:
https://public.tableau.com/app/profile/justin3608/viz/CovidDashboardProject_16317299451110/Dashboard1
![Dashboard 1](https://user-images.githubusercontent.com/81699947/134031861-81be223d-b323-4f69-a7af-fbab0b148a2e.png)
