WITH events AS (
    SELECT * FROM {{ ref('stg_events') }}
    WHERE user_id IS NOT NULL -- Exclude metadata rows
),

users AS (
    SELECT * FROM {{ ref('stg_users') }}
),

user_funnel AS (
    SELECT
        TRIM(UPPER(user_id)) AS user_id,
        COUNTIF(event_name = 'start_listing') AS started_listings,
        COUNTIF(event_name = 'complete_listing') AS completed_listings
    FROM events
    GROUP BY 1
)

SELECT 
    s.user_id,
    u.user_tier,
    u.region,
    s.started_listings,
    s.completed_listings,
    CASE 
        WHEN s.started_listings > 0 THEN (s.completed_listings / s.started_listings)
        ELSE 0
    END AS conversion_rate
FROM user_funnel AS s
LEFT JOIN users AS u 
    ON s.user_id = TRIM(UPPER(u.user_id))