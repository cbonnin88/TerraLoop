WITH raw_data AS (
    SELECT * FROM {{source('terraloop_raw','users')}}
),

renamed AS (
    SELECT
        user_id,
        user_tier,
        region,
        SAFE_CAST(signup_date AS date) AS signup_date
    FROM raw_data
    WHERE user_id IS NOT NULL
)

SELECT * FROM renamed