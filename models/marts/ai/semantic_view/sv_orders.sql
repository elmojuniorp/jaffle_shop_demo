{{config(materialized='semantic_view', alias='sv_orders')}}

tables (
    {{ ref('orders') }} comment='The table contains records of customers and their purchasing history. Each record represents a single customer and includes details about their order activity over time, total spending amounts, and customer classification.'
)
facts (
    CUSTOMERS.LIFETIME_SPEND as LIFETIME_SPEND comment='The total amount of money spent by the customer across all transactions.',
    CUSTOMERS.LIFETIME_SPEND_PRETAX as LIFETIME_SPEND_PRETAX comment='The total amount spent by the customer before taxes over their entire relationship with the company.',
    CUSTOMERS.LIFETIME_TAX_PAID as LIFETIME_TAX_PAID comment='The total amount of tax paid by the customer over their lifetime.'
)
dimensions (
    CUSTOMERS.COUNT_LIFETIME_ORDERS as COUNT_LIFETIME_ORDERS comment='The total number of orders placed by the customer over their entire relationship with the business.',
    CUSTOMERS.CUSTOMER_ID as CUSTOMER_ID comment='Unique identifier for each customer in the system.',
    CUSTOMERS.CUSTOMER_NAME as CUSTOMER_NAME comment='The name of the customer.',
    CUSTOMERS.CUSTOMER_TYPE as CUSTOMER_TYPE comment='The classification of the customer based on their purchasing history or relationship with the business.',
    CUSTOMERS.FIRST_ORDERED_AT as FIRST_ORDERED_AT comment='The date and time when the customer placed their first order.',
    CUSTOMERS.LAST_ORDERED_AT as LAST_ORDERED_AT comment='The date and time when the customer most recently placed an order.'
)
comment='This is a agent for exploring the data behind the restaurant called the Jaffle Shop that serves jaffles.'
