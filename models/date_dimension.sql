WITH CTE1 AS
(
select  to_timestamp(start_at) start_at
,       date(to_timestamp(start_at)) start_date
,       hour(to_timestamp(start_at)) start_hour
,       dayname(to_timestamp(start_at)) start_day
,       case when dayname(to_timestamp(start_at)) in ('Sat', 'Sun') then 'WeekEnd' else 'BusinessDay' end day_type
,       case when month(to_timestamp(start_at)) in (12,1,2) then 'Winter'
             when month(to_timestamp(start_at)) in (3,4,5) then 'Spring'
             when month(to_timestamp(start_at)) in (6,7,8) then 'Summer'
             else 'Autumn'
        end season
from {{ source('demo', 'bike') }}
where start_at <> 'start_at'
)
SELECT * FROM CTE1