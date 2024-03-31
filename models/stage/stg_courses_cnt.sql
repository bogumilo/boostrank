with courses as ( select * from {{ ref('stg_subjectareas') }}
  -- where institution in ('Sheffield', 'Lancaster', 'Imperial College', 'London School of Economics', 'Kent', 'Durham', 'Warwick',
  --                       'Abertay Dundee','Coventry','Cardiff','Royal Holloway','Leeds', 'Nottingham', 'Newcastle')
)

select
  institution,
  rank_year,

  count(distinct course) as total_courses
from courses
group by 1,2
