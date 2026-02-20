WITH raw_data AS (
    SELECT * FROM {{source('terraloop_raw','users')}}
),

renamed AS (
    SELECT
        JSON_VALUE(_airbyte_meta,'$.user_id') AS user_id,
        JSON_VALUE(_airbyte_meta,'$.user_tier') AS user_tier,
        JSON_VALUE(_airbyte_meta,'$.region') AS region,
        CAST(JSON_VALUE(_airbyte_meta,'$.signup_date')AS date) AS signup_date
    FROM raw_data
)

SELECT * FROM renamed