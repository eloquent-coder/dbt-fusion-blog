# Connecting Tableau Layer to Tableau

This guide will help you connect your dbt tableau layer to Tableau Desktop or Tableau Server.

## Prerequisites

1. **Build the Tableau Models**: First, ensure your tableau models are built in Snowflake
2. **Tableau Desktop/Server**: Have Tableau Desktop or access to Tableau Server
3. **Snowflake Credentials**: Your Snowflake account credentials

---

## Step 1: Build the Tableau Models

Before connecting to Tableau, you need to build the tableau models in your Snowflake database.

### Option A: Build All Models
```bash
dbt build
```

### Option B: Build Only Tableau Models
```bash
dbt run --select tableau.*
```

### Verify the Build
After building, verify that the `fact_sales` table exists in your Snowflake database:
- Database: `DBTFUSION`
- Schema: `TABLEAU`
- Table: `FACT_SALES`

You can verify this in Snowflake with:
```sql
SELECT * FROM DBTFUSION.TABLEAU.FACT_SALES LIMIT 10;
```

---

## Step 2: Connect Tableau to Snowflake

### For Tableau Desktop:

1. **Open Tableau Desktop**

2. **Connect to Data**:
   - Click "Connect to Data" or go to `Data` → `New Data Source`
   - Under "To a Server", select **Snowflake**

3. **Enter Connection Details**:
   - **Server**: `JYHJXVK-VZ40424.snowflakecomputing.com`
     - Format: `<account_identifier>.snowflakecomputing.com`
   - **Database**: `DBTFUSION`
   - **Schema**: `TABLEAU`
   - **Warehouse**: `COMPUTE_WH` (optional, can be set later)
   - **Authentication**: Choose one:
     - **Username and Password**: Enter your Snowflake username and password
     - **OAuth**: If configured in your Snowflake account

4. **Test Connection**:
   - Click "Sign In" to test the connection
   - If successful, you'll see the available tables

5. **Select the Table**:
   - In the left pane, navigate to `TABLEAU` schema
   - Drag `FACT_SALES` to the canvas or double-click it

6. **Go to Sheet**:
   - Click "Sheet 1" at the bottom to start building visualizations

### For Tableau Server/Cloud:

1. **Publish Data Source** (from Tableau Desktop):
   - After connecting in Tableau Desktop, go to `Server` → `Publish Data Source`
   - Enter your Tableau Server credentials
   - Name your data source (e.g., "Jaffle Shop Sales")
   - Select the project where you want to publish
   - Click "Publish"

2. **Or Connect Directly in Tableau Server**:
   - In Tableau Server, go to `Data` → `New Data Source`
   - Follow the same connection steps as Tableau Desktop

---

## Step 3: Using the fact_sales Table in Tableau

### Recommended Data Model Setup:

The `fact_sales` table is already denormalized, so you can use it directly:

1. **Single Table Connection** (Recommended):
   - Connect directly to `FACT_SALES` table
   - All dimensions and metrics are already joined
   - No additional joins needed

2. **Start Building Visualizations**:
   - **Dimensions** (for grouping/filtering):
     - `ORDER_DATE` - Time analysis
     - `CUSTOMER_NAME`, `CUSTOMER_TYPE` - Customer analysis
     - `PRODUCT_NAME`, `PRODUCT_TYPE` - Product analysis
     - `LOCATION_NAME` - Location analysis
     - `IS_FOOD_ITEM`, `IS_DRINK_ITEM` - Product category
   
   - **Measures** (for aggregations):
     - `ITEM_PRICE` - Revenue
     - `ITEM_COST` - Costs
     - `ITEM_PROFIT` - Profit
     - `ITEM_PROFIT_MARGIN` - Profit margin %
     - `ORDER_TOTAL` - Order-level totals
     - `LIFETIME_SPEND` - Customer lifetime value

### Example Visualizations:

1. **Sales Over Time**:
   - Rows: `ORDER_DATE` (as date)
   - Columns: `SUM(ITEM_PRICE)` (revenue)

2. **Product Performance**:
   - Rows: `PRODUCT_NAME`
   - Columns: `SUM(ITEM_PROFIT)`, `AVG(ITEM_PROFIT_MARGIN)`

3. **Customer Analysis**:
   - Rows: `CUSTOMER_TYPE`
   - Columns: `SUM(LIFETIME_SPEND)`, `COUNT_DISTINCT(CUSTOMER_ID)`

4. **Location Performance**:
   - Rows: `LOCATION_NAME`
   - Columns: `SUM(ORDER_TOTAL)`, `COUNT_DISTINCT(ORDER_ID)`

---

## Step 4: Refresh Data in Tableau

Since your dbt models are materialized as tables, you have two options:

### Option A: Manual Refresh
1. Run `dbt run --select tableau.*` to rebuild the tables
2. In Tableau, go to `Data` → `Refresh` to refresh the data source

### Option B: Automated Refresh (Recommended)
Set up a scheduled job to:
1. Run dbt models on a schedule (using dbt Cloud, Airflow, or similar)
2. Configure Tableau to refresh on a schedule (Tableau Server/Cloud)

---

## Troubleshooting

### Connection Issues:
- **"Cannot connect to server"**: Verify your Snowflake account identifier and network access
- **"Invalid credentials"**: Check username/password in Snowflake
- **"Database not found"**: Ensure the database name is `DBTFUSION` (case-sensitive in Snowflake)

### Data Issues:
- **"Table not found"**: Run `dbt run --select tableau.*` to build the models
- **"Schema not found"**: Verify the schema name is `TABLEAU` (check Snowflake)
- **Missing data**: Ensure all upstream models (staging, marts) are built first

### Performance Issues:
- The `fact_sales` table is materialized as a table for performance
- If queries are slow, consider adding indexes or clustering keys in Snowflake
- Use Tableau's extract feature for faster performance on large datasets

---

## Additional Resources

- [Tableau Snowflake Connector Documentation](https://help.tableau.com/current/pro/desktop/en-us/connector_snowflake.htm)
- [dbt Documentation](https://docs.getdbt.com/)
- [Snowflake Documentation](https://docs.snowflake.com/)

---

## Quick Reference

**Snowflake Connection Details:**
- Server: `JYHJXVK-VZ40424.snowflakecomputing.com`
- Database: `DBTFUSION`
- Schema: `TABLEAU`
- Table: `FACT_SALES`
- Warehouse: `COMPUTE_WH`

**dbt Commands:**
```bash
# Build all tableau models
dbt run --select tableau.*

# Build and test tableau models
dbt build --select tableau.*

# View compiled SQL
dbt compile --select tableau.*
```

