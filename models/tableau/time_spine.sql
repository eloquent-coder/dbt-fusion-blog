{{ config(
    materialized='table'
) }}

with dates as (

    {{ dbt.date_spine(
        datepart="day",
        start_date="date('2015-01-01')",
        end_date="dateadd(day, 1, current_date)"
    ) }}

)

select
    date_day as date_day
from dates
