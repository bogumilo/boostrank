with universities as (select * from {{ ref('stg_ranking') }}),

benchmark_year as (select * from universities where institution = 'Birmingham'),

competitors_year as (select * from universities where institution != 'Birmingham'),

top_five_list as (

  select
    c.rank_year,

    array_agg(c.institution order by abs(b.ratio_uni - c.ratio_uni) limit 5) as neighbor_,
  from competitors_year c
  full join benchmark_year b on b.rank_year=c.rank_year
  group by 1

  union all

  select
    c.rank_year,

    array_agg(c.institution order by abs(b.career_uni - c.career_uni) limit 5) as neighbor_,
  from competitors_year c
  full join benchmark_year b on b.rank_year=c.rank_year
  group by 1

  union all

  select
    c.rank_year,

    array_agg(c.institution order by abs(b.value_score_uni - c.value_score_uni) limit 5) as neighbor_,
  from competitors_year c
  full join benchmark_year b on b.rank_year=c.rank_year
  group by 1

  union all

  select
    c.rank_year,

    array_agg(c.institution order by abs(b.tariff_uni - c.tariff_uni) limit 5) as neighbor_,
  from competitors_year c
  full join benchmark_year b on b.rank_year=c.rank_year
  group by 1

  union all

  select
    c.rank_year,

    array_agg(c.institution IGNORE NULLS order by abs(b.spend_uni - c.spend_uni) limit 5) as neighbor_,
  from competitors_year c
  full join benchmark_year b on b.rank_year=c.rank_year
  group by 1
),

closest_neighbor_cnt as (
  SELECT
    rank_year,
    top_five_neighbors,
    count(*) as occurance_categories_cnt
  FROM top_five_list, UNNEST(neighbor_) as top_five_neighbors
  group by 1,2
),

closest_neighbor_top as (
  select
    *,
    dense_rank() over (partition by rank_year
                      order by occurance_categories_cnt desc) as top_rank
  from closest_neighbor_cnt
)

select
  rank_year,
  string_agg(case when top_rank=1 then top_five_neighbors end, ',') as neighbors
from closest_neighbor_top
group by 1
order by 1
