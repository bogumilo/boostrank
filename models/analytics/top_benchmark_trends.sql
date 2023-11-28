with universities as (select * from {{ ref('stg_ranking') }}),

benchmark_year as (select * from universities where institution = 'Birmingham'),

comp_list_unnest as (select * from {{ ref('competitors_area_year') }} where competing_area = 'OVERALL' )

select
  -- 'benchmark' as compare_to,
  institution,
  rank_year,
  ranking_uni,
  score_uni,
  spend_uni,
  ratio_uni,
  career_uni,
  value_score_uni,
  tariff_uni,
  nss_teaching_uni,
  nss_overall_uni,
  nss_feedback_uni

from benchmark_year

union all

select
  -- c.competing_area as compare_to,
  c.neighbor,
  c.rank_year,
  u.ranking_uni,
  u.score_uni,
  u.spend_uni,
  u.ratio_uni,
  u.career_uni,
  u.value_score_uni,
  u.tariff_uni,
  u.nss_teaching_uni,
  u.nss_overall_uni,
  u.nss_feedback_uni

from comp_list_unnest c
left join universities u on c.rank_year=u.rank_year and u.institution = c.neighbor
