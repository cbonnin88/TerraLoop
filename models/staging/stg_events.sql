-- Creating the Staging Model

WITH raw_data AS (
    SELECT * FROM {{source('terraloop_raw','events')}}
),

renamed AS (
    SELECT
        user_id,
        event_type AS event_name,
        SAFE_CAST(event_time AS timestamp) AS event_at,
        LOWER(platform) AS platform,
        COALESCE(item_category,'unknown') AS item_category
    FROM raw_data
    WHERE user_id IS NOT NULL
)

SELECT * FROM renamed