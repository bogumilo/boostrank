with all_courses as ( select * from {{ ref('stg_subjectareas') }} ),

benchmark_courses as ( select * from all_courses where institution = 'Birmingham' ),

comp_unnest as (
  select
    a.*
  from {{ ref('competitors_area_year') }} u
  left join all_courses a
    on u.rank_year=a.rank_year and u.neighbor=a.institution
  where u.competing_area = 'OVERALL'
),

final as (
  select
    b.rank_year,
    b.course,
    c.institution as competitor,
    b.ratio as benchmark_ratio,

    --student satisfation
    AVG(c.ratio) as avg_competitor_ratio,
    (AVG(c.ratio)*100.0/b.ratio) as avg_line_ratio_index,

  from benchmark_courses b
  left join comp_unnest c on b.rank_year=c.rank_year and b.course=c.course
  group by 1,2,3,4
)

select * from final
where competitor is not null
  and benchmark_ratio is not null
  and avg_competitor_ratio is not null
-- order by avg_line_ratio_index desc
-- limit 10
