{% set agent_database = 'SNOWFLAKE_INTELLIGENCE' %}
{% set agent_schema = 'AGENTS' %}
{% set agent_name = 'NTA_TELEPHONY_AGENT_' ~ target.name %}

{% set create_agent_sql %}

create or replace agent JAFFLE_JARVIS
profile='{"display_name":"JAFFLE_JARVIS"}'
from specification
$$
models:
  orchestration: "auto"
orchestration: {}
tools:
  - tool_spec:
      type: "cortex_analyst_text_to_sql"
      name: "Customers"
      description: "TABLE1: CUSTOMERS\n- Database: DEMO_DBT_DEV, Schema: CURATED\n\
        - This table contains comprehensive customer records for the Jaffle Shop restaurant,\
        \ tracking individual customer purchasing behavior and lifetime value metrics.\
        \ Each record represents a unique customer with their complete order history,\
        \ spending patterns, and customer classification status.\n- The table enables\
        \ analysis of customer segmentation (new vs. returning), lifetime value calculations,\
        \ and temporal ordering patterns. It supports queries about customer acquisition\
        \ timing, spending behaviors, and order frequency over the customer lifecycle.\n\
        - LIST OF COLUMNS: CUSTOMER_ID (unique identifier for each customer), CUSTOMER_NAME\
        \ (name of the customer), CUSTOMER_TYPE (classification as new or returning\
        \ customer), COUNT_LIFETIME_ORDERS (total number of orders placed by customer),\
        \ LIFETIME_SPEND (total amount spent including tax), LIFETIME_SPEND_PRETAX\
        \ (total amount spent before tax), LIFETIME_TAX_PAID (total tax amount paid),\
        \ FIRST_ORDERED_AT (timestamp of customer's first order), LAST_ORDERED_AT\
        \ (timestamp of customer's most recent order)\n\nREASONING:\nThis semantic\
        \ view focuses on customer-centric analytics for the Jaffle Shop restaurant.\
        \ It provides a single comprehensive table that consolidates all customer\
        \ information including identification, ordering behavior, financial metrics,\
        \ and temporal data. The view enables analysis of customer lifetime value,\
        \ segmentation, acquisition patterns, and purchasing frequency. It supports\
        \ business questions about customer retention, spending patterns, order history,\
        \ and time-based customer behavior analysis. The structure is optimized for\
        \ customer relationship management and revenue analysis queries.\n\nDESCRIPTION:\n\
        The CUSTOMER semantic view provides comprehensive customer analytics for the\
        \ Jaffle Shop restaurant, containing data from the CUSTOMERS table in the\
        \ DEMO_DBT_DEV database and CURATED schema. This view tracks individual customer\
        \ profiles with their complete purchasing history, including lifetime order\
        \ counts, total spending amounts (both pre-tax and post-tax), and customer\
        \ classification (new vs. returning). It captures temporal ordering patterns\
        \ through first and last order timestamps, enabling analysis of customer acquisition,\
        \ retention, and lifecycle value. The view supports queries about customer\
        \ segmentation, spending behaviors, order frequency, and time-based customer\
        \ activity patterns across the restaurant's customer base."
  - tool_spec:
      type: "cortex_analyst_text_to_sql"
      name: "Products"
      description: "TABLE1: PRODUCTS\n- Database: DEMO_DBT_DEV, Schema: CURATED\n\
        - This table contains comprehensive product catalog information for a food\
        \ and beverage establishment. Each row represents a unique product with detailed\
        \ attributes including identification, naming, categorization, and pricing\
        \ information.\n- The table supports product classification through boolean\
        \ flags distinguishing between food and drink items, enabling easy filtering\
        \ and analysis of menu offerings. Products include various jaffles (specialty\
        \ sandwiches) and beverages with descriptive names and detailed menu descriptions.\n\
        - LIST OF COLUMNS: PRODUCT_ID (unique identifier code for each product), PRODUCT_NAME\
        \ (display name of the product), PRODUCT_DESCRIPTION (detailed menu description\
        \ of the item), PRODUCT_TYPE (category classification such as jaffle or beverage),\
        \ PRODUCT_PRICE (retail price in decimal format), IS_FOOD_ITEM (boolean flag\
        \ indicating food classification), IS_DRINK_ITEM (boolean flag indicating\
        \ beverage classification)\n\nREASONING:\nThis semantic view represents a\
        \ product dimension focused on menu items and beverages at a food service\
        \ establishment. The PRODUCTS table serves as a standalone dimension table\
        \ with one row per product, containing all necessary attributes for product\
        \ identification, categorization, pricing, and description. The view enables\
        \ analysis of product offerings through multiple lenses including product\
        \ type, food versus drink classification, and pricing tiers. This is a single-table\
        \ semantic view without relationships to other tables, making it a straightforward\
        \ product master data source.\n\nDESCRIPTION:\nThe PRODUCT semantic view provides\
        \ a comprehensive product dimension catalog from the DEMO_DBT_DEV database's\
        \ CURATED schema, containing one row per product in the PRODUCTS table. This\
        \ view encompasses menu items including specialty jaffles and beverages with\
        \ complete product information such as unique identifiers, names, detailed\
        \ descriptions, pricing, and categorical classifications. The table includes\
        \ boolean flags (IS_FOOD_ITEM and IS_DRINK_ITEM) that enable easy segmentation\
        \ between food and beverage products for analysis and reporting purposes.\
        \ This semantic view serves as the master product reference for analyzing\
        \ menu offerings, pricing strategies, and product mix across food and drink\
        \ categories."
  - tool_spec:
      type: "cortex_analyst_text_to_sql"
      name: "Orders"
      description: "TABLE1: ORDERS\n- Database: DEMO_DBT_DEV, Schema: CURATED\n- This\
        \ table contains comprehensive records of customer orders placed at various\
        \ locations, with each row representing a single order transaction. It includes\
        \ detailed financial breakdowns such as costs, taxes, and totals, along with\
        \ categorization of items by food and drink types.\n- The table tracks customer\
        \ ordering patterns through sequential order numbering and provides boolean\
        \ flags to quickly identify whether orders contain food items, drink items,\
        \ or both. It serves as the primary source for order-level analytics and financial\
        \ reporting.\n- LIST OF COLUMNS: COUNT_DRINK_ITEMS (number of drink items\
        \ in order), COUNT_FOOD_ITEMS (number of food items in order), COUNT_ORDER_ITEMS\
        \ (total number of items in order), CUSTOMER_ID (unique customer identifier),\
        \ CUSTOMER_ORDER_NUMBER (sequential order number per customer), IS_DRINK_ORDER\
        \ (boolean flag for drink orders), IS_FOOD_ORDER (boolean flag for food orders),\
        \ LOCATION_ID (unique location identifier), ORDER_ID (unique order identifier),\
        \ ORDER_TOTAL_CENTS (total order value in cents), SUBTOTAL_CENTS (order subtotal\
        \ in cents), TAX_PAID_CENTS (tax amount in cents), ORDER_COST (calculated\
        \ order cost in dollars), ORDER_ITEMS_SUBTOTAL (subtotal of all items before\
        \ taxes), ORDER_TOTAL (total monetary value in dollars), SUBTOTAL (subtotal\
        \ before taxes and fees in dollars), TAX_PAID (tax amount in dollars), ORDERED_AT\
        \ (timestamp of order placement)\n\nREASONING:\nThe ORDERS_ITEMS semantic\
        \ view provides a comprehensive order management perspective focused on analyzing\
        \ customer purchasing behavior and order composition. The view centers around\
        \ the ORDERS table which aggregates order-level information including financial\
        \ metrics, item categorization (food vs. drink), and customer ordering patterns.\
        \ This semantic view is designed to answer questions about order totals, customer\
        \ purchase frequency, item type distribution, location-based ordering patterns,\
        \ and temporal ordering trends. The structure supports both operational queries\
        \ (individual order details) and analytical queries (aggregate metrics across\
        \ customers, locations, and time periods).\n\nDESCRIPTION:\nThe ORDERS_ITEMS\
        \ semantic view from DEMO_DBT_DEV.CURATED provides a comprehensive order management\
        \ system with one row per order, containing detailed financial and item composition\
        \ data. It tracks customer orders across multiple locations with complete\
        \ breakdowns of food versus drink items, sequential customer order numbering\
        \ to identify first-time versus repeat orders, and detailed financial metrics\
        \ including subtotals, taxes, and total costs in both cents and dollar formats.\
        \ The view enables analysis of ordering patterns by customer, location, and\
        \ time, with boolean flags for quick identification of order types and item\
        \ counts for granular composition analysis. Key relationships include CUSTOMER_ID\
        \ linking orders to customers, LOCATION_ID connecting orders to physical locations,\
        \ and ORDERED_AT providing temporal context for trend analysis and time-based\
        \ reporting."
tool_resources:
  Customers:
    execution_environment:
      query_timeout: 600
      type: "warehouse"
      warehouse: ""
    semantic_view: {{ ref('sv_customer') }}
  Orders:
    execution_environment:
      query_timeout: 600
      type: "warehouse"
      warehouse: ""
    semantic_view: {{ ref('sv_orders') }}
  Products:
    execution_environment:
      query_timeout: 600
      type: "warehouse"
      warehouse: ""
    semantic_view: {{ ref('sv_products') }}
$$
{% endset %}

{% if target.name == 'prd' or target.name == 'ci' %}
        {% set roles = ["ROLE__DB__NTA_PRD__RO", 
        "ROLE__NTA_PRD__CURATED__RO"] %}
    {% else %}
        {% set roles = ["ROLE__DB__NTA_DEV__RO"] %}
{% endif %}


-- Execute the CREATE AGENT statement before the model is materialized
{% if execute and flags.WHICH not in ['compile', 'docs', 'generate'] %}
  {% do run_query(create_agent_sql) %}
  {% do log("Created Cortex AI Agent: " ~ agent_database ~ "." ~ agent_schema ~ "." ~ agent_name, info=True) %}

  {% for role in roles %}
    {% set grant_sql = "GRANT USAGE ON AGENT " ~ agent_database ~ "." ~ agent_schema ~ "." ~ agent_name ~ " TO ROLE \"" ~ role ~ "\";" %}
    {% do run_query(grant_sql) %}
    {% do log("Granted access to role: " ~ role, info=True) %}
  {% endfor %}
{% endif %}

{{
  config(
    materialized='ephemeral'
  )
}}
