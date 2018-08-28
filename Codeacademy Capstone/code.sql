/* https://gist.github.com/f86ea7333aee23bbbac808cddb1e14ad */

/* Task 1 */
SELECT COUNT(DISTINCT utm_campaign) AS 'unique_campaigns', 
COUNT(DISTINCT utm_source) AS 'unique_sources'
FROM page_visits;

SELECT DISTINCT utm_campaign, utm_source
FROM page_visits
GROUP BY utm_campaign
ORDER BY utm_source;

SELECT DISTINCT page_name
FROM page_visits;

/* Task 2 */
WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id),
ft_attr AS (
  SELECT ft.user_id, ft.first_touch_at, pv.utm_source, pv.utm_campaign
  FROM first_touch ft
  JOIN page_visits pv
  ON ft.user_id = pv.user_id
  AND ft.first_touch_at = pv.timestamp
  )
  SELECT ft_attr.utm_source, ft_attr.utm_campaign, COUNT (*)
  FROM ft_attr
  GROUP by utm_campaign
  ORDER BY COUNT(*) desc;
  
  WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id),
lt_attr AS (
  SELECT lt.user_id, lt.last_touch_at, pv.utm_source, pv.utm_campaign
  FROM last_touch lt
  JOIN page_visits pv
  ON lt.user_id = pv.user_id
  AND lt.last_touch_at = pv.timestamp
  )
  SELECT lt_attr.utm_source, lt_attr.utm_campaign, COUNT (*)
  FROM lt_attr
  GROUP by utm_campaign
  ORDER BY COUNT(*) desc;
  
  SELECT COUNT(DISTINCT(user_id)) as 'unique_purchases'
  FROM page_visits
  WHERE page_name = '4 - purchase';
                        
  SELECT COUNT(user_id) as 'purchases'
  FROM page_visits
  WHERE page_name = '4 - purchase';
                        
  SELECT utm_campaign, COUNT(DISTINCT(user_id)) as unique_users, MAX(timestamp) as last_touch_at
  FROM page_visits
  WHERE page_name = '4 - purchase'
  GROUP BY utm_campaign
  ORDER BY 2 desc;

  SELECT utm_campaign, COUNT(user_id) as users, MAX(timestamp) as last_touch_at
  FROM page_visits
  WHERE page_name = '4 - purchase'
  GROUP BY utm_campaign
  ORDER BY 2 desc;
                                      
  SELECT utm_campaign, COUNT(DISTINCT(user_id)) as unique_users, MIN(timestamp) as first_touch_at
  FROM page_visits
  GROUP BY utm_campaign
  ORDER BY 2 desc;
                               
WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id),
last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id),
ft_attr AS (
  SELECT ft.user_id, ft.first_touch_at, pv.utm_source, pv.utm_campaign
  FROM first_touch ft
  JOIN page_visits pv
  ON ft.user_id = pv.user_id
  AND ft.first_touch_at = pv.timestamp
  ),
lt_attr AS (
  SELECT lt.user_id, lt.last_touch_at, pv.utm_source, pv.utm_campaign
  FROM last_touch lt
  JOIN page_visits pv
  ON lt.user_id = pv.user_id
  AND lt.last_touch_at = pv.timestamp
  WHERE pv.page_name = '4 - purchase'
  )
  SELECT ft_attr.utm_campaign AS first_touch_campaign, lt_attr.utm_campaign AS last_touch_campaign, COUNT(*)
  FROM ft_attr
  JOIN lt_attr
  ON ft_attr.user_id = lt_attr.user_id
  GROUP BY first_touch_campaign, last_touch_campaign
  ORDER BY COUNT(*) DESC;