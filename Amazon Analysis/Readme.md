
# 📊 Amazon Sales Dashboard 

This repository contains a Power BI dashboard designed to visualize and analyze Amazon sales data interactively. The dashboard includes features such as dynamic visuals, sales/unit toggles, icon-based indicators, and key performance metrics tailored for e-commerce data insights.

## 🚀 Features

Sales/Units Toggle

A dynamic switch allowing users to view either Sales Amount or Units Sold using a data table:

DataTable("Name", STRING, "Type", STRING, {{"1", "Sales"}, {"2", "Units"}})


[to check the amazon site dashbord click here ](https://github.com/karishmasharma/Power-Bi-Projects/blob/main/Amazon%20Analysis/Dashboard_overview.png)

[To see the complete products of amazon click here](https://github.com/karishmasharma/Power-Bi-Projects/blob/main/Amazon%20Analysis/Product%20Screenshot%20.png)

[another windwow to check the products details to check click here and still under consideration](https://github.com/karishmasharma/Power-Bi-Projects/blob/main/Amazon%20Analysis/Productview%20screenshot.png)

## Key Metrics

**•** Total Sales (Sale_Ammount)

**•** Units Sold (Sale_Units)

**•** Number of Orders Delivered (Order_Counts)

**•** Number of Returned Units (Return_Units)

**•** Total Sellers (Seller Count)

**•** Number of Reviews (Reviews)

**•** Category-Wise & Overall Analysis

Includes measures for filtered and unfiltered analysis across categories using DAX measures like:
CALCULATE([Sale_Units], ALL('amazon-fashion'[Category]))

### Icon-Based Visual Cues
Icons change based on selected options:

✔️ Check Icon: https://i.postimg.cc/RV3LcN3L/check-2.png

📦 Sale/Unit Icon: https://drive.google.com/uc?export=view&id=1mcmb1peVHoaU5XL2bYXinZtW9sv2bNG4

Custom Colors for Branding
Orange: #FF9F10
Background: #F8F8F8
White: #FFFFFF


🧠 DAX Highlights

Toggle Measure:
var selecting = SELECTEDVALUE(Sale_Option[Type])
return IF(selecting = "1", SUM(Amazon[Total_Ammount]), SUM(Amazon[Qty]))

Delivered Orders:
CALCULATE(COUNT('amazon-fashion'[seller_id]), CONTAINSSTRING(Amazon[Status], "Delivered"))

Returned Units:
var val = CALCULATE([Sale_Units], CONTAINSSTRING(Amazon[Status], "Return"))
return IF(val = BLANK(), 0, val)

📁 Files
This repository may include:

.pbix Power BI dashboard file

Documentation for DAX measures

Sample data 

Screenshots  of the dashboard

🛠️ Requirements
Power BI Desktop (latest version recommended)
Basic familiarity with DAX and Power BI interface

📬 Feedback
If you have suggestions or want to contribute, feel free to open an issue or submit a pull request. Let’s improve this dashboard together!

