WITH events AS (
    SELECT * FROM {{ref('stg_events')}}
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
    user_id,
    started_listings,
    completed_listings,
    -- Simple conversion logic
    CASE 
        WHEN started_listings > 0 THEN (completed_listings / started_listings)
        ELSE 0
    END AS conversion_rate
FROM user_funnel