WITH events AS (
    SELECT * FROM {{ref('stg_events')}}
),

users AS (
    SELECT * FROM {{ref('stg_users')}}
),

user_funnel AS (
    SELECT
        user_id,
        COUNTIF(event_name = 'start_listing') AS started_listings,
        COUNTIF(event_name = 'complete_listing') AS completed_listings
    FROM events
    GROUP BY 1
)

SELECT 
    s.user_id,
    u.user_tier, -- Bringing in the dimension for analysis
    s.started_listings,
    s.completed_listings,
    -- Simple conversion logic
    CASE 
        WHEN s.started_listings > 0 THEN (s.completed_listings / s.started_listings)
        ELSE 0
    END AS conversion_rate
FROM user_funnel AS s
LEFT JOIN users AS u USING(user_id)