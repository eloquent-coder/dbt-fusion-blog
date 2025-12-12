with

order_items as (
    select * from {{ ref('order_items') }}
),

orders as (
    select * from {{ ref('orders') }}
),

customers as (
    select * from {{ ref('customers') }}
),

products as (
    select * from {{ ref('products') }}
),

locations as (
    select * from {{ ref('locations') }}
),

fact_sales as (
    select
        -- Order Item Level Identifiers
        order_items.order_item_id,
        order_items.order_id,
        order_items.product_id,
        
        -- Customer Dimensions
        orders.customer_id,
        customers.customer_name,
        customers.customer_type,
        customers.count_lifetime_orders,
        customers.first_order_date,
        customers.last_order_date,
        customers.lifetime_spend,
        customers.lifetime_spend_pretax,
        customers.lifetime_tax_paid,
        
        -- Product Dimensions
        products.product_name,
        products.product_type,
        products.product_description,
        products.product_price,
        products.is_food_item,
        products.is_drink_item,
        
        -- Location Dimensions
        orders.location_id,
        locations.location_name,
        locations.tax_rate,
        locations.opened_date,
        
        -- Order Dimensions
        orders.order_date,
        orders.subtotal as order_subtotal,
        orders.tax_paid as order_tax_paid,
        orders.order_total as order_total,
        orders.order_cost,
        orders.order_items_subtotal,
        orders.count_order_items,
        orders.count_food_items,
        orders.count_drink_items,
        orders.is_food_order,
        orders.is_drink_order,
        orders.customer_order_number,
        
        -- Order Item Metrics
        order_items.product_price as item_price,
        order_items.supply_cost as item_cost,
        (order_items.product_price - order_items.supply_cost) as item_profit,
        (order_items.product_price - order_items.supply_cost) / nullif(order_items.product_price, 0) as item_profit_margin
        
    from order_items
    
    left join orders
        on order_items.order_id = orders.order_id
    
    left join customers
        on orders.customer_id = customers.customer_id
    
    left join products
        on order_items.product_id = products.product_id
    
    left join locations
        on orders.location_id = locations.location_id

)

select * from fact_sales

