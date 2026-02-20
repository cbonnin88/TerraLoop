-- Creating the Staging Model

WITH raw_data AS (
    SELECT * FROM {{source('terraloop_raw','events')}}
),

renamed AS (
    SELECT
        -- Extractiong from the JSON and casting to correct types
        JSON_VALUE(_airbyte_meta,'$.user_id') AS user_id,
        JSON_VALUE(_airbyte_meta,'$.event_type') AS event_name,
        CAST(JSON_VALUE(_airbyte_meta,'$.event_time') AS timestamp) AS event_at,

        -- Fix: Standardizing 'WEB' and 'Web'
        LOWER(JSON_VALUE(_airbyte_meta, '$.platform')) AS platform,

        -- Fix: Handling Nulls in Category
        COALESCE(JSON_VALUE(_airbyte_meta, '$.item_category'), 'uknown') AS item_category
    FROM raw_data
)

SELECT * FROM renamed