WITH events AS (
    SELECT * FROM {{ ref('stg_events') }}
),

users AS (
    SELECT * FROM {{ ref('stg_users') }}
)

SELECT
    e.user_id,
    e.event_name,
    e.event_at,
    e.platform,        -- Already in stg_events
    e.item_category,   -- Already in stg_events
    u.user_tier,       -- Joined from stg_users
    u.region           -- Joined from stg_users
FROM events AS e
LEFT JOIN users AS u 
    ON e.user_id = u.user_id