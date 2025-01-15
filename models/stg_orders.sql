select
	opportunityid as order_id,
	accountid as customer_id,
	modifiedon as order_date,
	statecodename as status
from raw_crm.opportunity o