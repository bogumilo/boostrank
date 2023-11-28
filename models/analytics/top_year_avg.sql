with universities as (select * from {{ ref('stg_ranking') }}),

benchmark_year as (select * from universities where institution = 'Birmingham'),

comp_list_unnest as (select * from {{ ref('competitors_area_year') }} where competing_area = 'OVERALL' )

select
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
  'AVERAGE OF TOP COMPETITORS',
  rank_year,

  --==-- Results/targets --==--
  AVG(ranking_uni) as ranking_avg,
  AVG(score_uni) as score_avg,

  -- Features
  AVG(spend_uni) as spend_avg,
  AVG(ratio_uni) as ratio_avg,
  AVG(career_uni) as career_avg,
  AVG(value_score_uni) as value_score_avg,
  AVG(tariff_uni) as tariff_avg,

  -- Student survey results
  AVG(nss_teaching_uni) as nss_teaching_avg,
  AVG(nss_overall_uni) as nss_overall_avg,
  AVG(nss_feedback_uni) as nss_feedback_avg

from universities u
-- left join benchmark_year c on c.rank_year=u.rank_year

where exists (
  select rank_year, neighbor from comp_list_unnest c where u.institution = c.neighbor and u.rank_year = c.rank_year
)
group by 1, 2
