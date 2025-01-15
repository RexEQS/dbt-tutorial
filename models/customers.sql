with customers as (
	select
		"AccountID" as customer_id,
		"Name" as first_name,
		bbo_navid as last_name
	from raw_crm.accounts a
),

orders as (
	select
		opportunityid as order_id,
		accountid as customer_id,
		modifiedon as order_date,
		statecodename as status
	from raw_crm.opportunity o
),

customer_orders as (
	select
		customer_id,
		min(order_date) as first_order_date,
		max(order_date) as most_recent_order_date,
		count(order_id) as number_of_orders
	from orders
	group by 1
),

final as (
	select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        COALESCE(customer_orders.number_of_orders, 0) AS number_of_orders
    FROM customers
    LEFT JOIN customer_orders USING (customer_id)
)

select * from final