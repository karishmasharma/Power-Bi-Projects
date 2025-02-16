
# 🚗 Car Sales Dashboard in Power BI

📌 Project Overview

Our company operates as a car dealership, selling various car models. To enhance our ability to track and analyze sales performance, we are developing a Car Sales Dashboard using Power BI. This dynamic and interactive dashboard will visualize critical Key Performance Indicators (KPIs) related to car sales, enabling data-driven decision-making.

## 🎯 Objective

The primary goal of this project is to design and implement a comprehensive Car Sales Dashboard that provides real-time insights into sales trends, average prices, and other crucial performance metrics. This will help in monitoring progress, identifying opportunities, and optimizing sales strategies.

## 🚨 Problem Statements & Requirements

### 📊 KPI Requirements

The dashboard should include real-time insights into key performance indicators (KPIs) to support business decisions.

1️⃣ Sales Overview:

• Year-to-Date (YTD)  Total Sales

• Month-to-Date (MTD) Total Sales

• Year-over-Year (YOY) Growth in Total Sales

• Difference between YTD Sales and Previous Year-to-Date (PTYD) Sales

2️⃣ Average Price Analysis:

• YTD Average Price

• MTD Average Price

• YOY Growth in Average Price

• Difference between YTD Average Price and PTYD Average Price

3️⃣ Cars Sold Metrics:

• YTD Cars Sold

• MTD Cars Sold

• YOY Growth in Cars Sold

• Difference between YTD Cars Sold and PTYD Cars Sold

### 📈 Charts & Visualization Requirements

To effectively present sales data, the dashboard should include the following charts:

• YTD Sales Weekly Trend: A line chart representing the weekly trend of YTD sales (X-axis: Weeks, Y-axis: Total Sales Amount).

• YTD Total Sales by Body Style: A pie chart visualizing the distribution of YTD total sales by different car body styles.

• YTD Total Sales by Color: A pie chart displaying the contribution of various car colors to the YTD total sales.

• YTD Cars Sold by Dealer Region: A map chart showcasing the YTD sales distribution across different dealer regions.

• Company-Wise Sales Trend: A tabular grid displaying sales trends for each company, including their YTD sales figures.

• Grid of Car Sales: A grid containing comprehensive details for each car sale, including car model, body style, color, sales amount, dealer region, date, etc.

## 🛠️ Tools & Technologies Used

Power BI (for data visualization and dashboard creation)

Excel/CSV (for data sources)

## 📜 DAX Queries Used

### 🚗 Sales Overview

YTD_Total_Sales = CALCULATE(SUM(Sales[Total Sales]), DATESYTD(Sales[Date]))
MTD_Total_Sales = CALCULATE(SUM(Sales[Total Sales]), DATESMTD(Sales[Date]))

YOY_Growth_Total_Sales = VAR CurrentYearSales = CALCULATE(SUM(Sales[Total Sales]), SAMEPERIODLASTYEAR(Sales[Date]))
RETURN 
    DIVIDE(SUM(Sales[Total Sales]) - CurrentYearSales, CurrentYearSales, 0)

### 💰 Average Price Analysis

YTD_Avg_Price = DIVIDE([YTD_Total_Sales], [YTD_Cars_Sold], 0)
MTD_Avg_Price = DIVIDE([MTD_Total_Sales], [MTD_Cars_Sold], 0)

YOY_Growth_Avg_Price = VAR LastYearAvgPrice = CALCULATE([YTD_Avg_Price], SAMEPERIODLASTYEAR(Sales[Date]))
RETURN 
    DIVIDE([YTD_Avg_Price] - LastYearAvgPrice, LastYearAvgPrice, 0)

### 📊 Cars Sold Metrics

YTD_Cars_Sold = CALCULATE(COUNT(Sales[Car ID]), DATESYTD(Sales[Date]))
MTD_Cars_Sold = CALCULATE(COUNT(Sales[Car ID]), DATESMTD(Sales[Date]))

YOY_Growth_Cars_Sold = VAR LastYearCarsSold = CALCULATE([YTD_Cars_Sold], SAMEPERIODLASTYEAR(Sales[Date]))
RETURN 
    DIVIDE([YTD_Cars_Sold] - LastYearCarsSold, LastYearCarsSold, 0)

## 📂 Project Structure

📦 Car-Sales-Dashboard
 ┣ 📂 Data
 ┃ ┣ 📜 sales_data.csv
 ┃ ┗ 📜 dealer_data.csv
 ┣ 📂 Reports
 ┃ ┗ 📜 Car_Sales_Dashboard.pbix
 ┣ 📜 README.md
 

## 🚀 How to Use

Clone this repository:

 [git clone :](https://github.com/karishmasharma/Power-Bi-Projects/tree/main/Car%20Sales%20Report)
 
Open Power BI and load the .pbix file.

Connect the dataset (if needed) and refresh the dashboard.

Explore the interactive visualizations for insights!

## 📌 Future Enhancements

Add forecasting models to predict future sales trends.

Integrate customer demographics for more detailed analysis.

Enable automated data updates via database connections.

🤝 Contributions

Contributions are welcome! Feel free to fork this repository, open issues, and submit pull requests.
    
