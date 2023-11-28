with comp_list as (
  select 'satisfaction' as competing_area, * from {{ ref('nss_neighbors') }}  union all
  select 'budget' as competing_area, * from {{ ref('budget_neighbors') }}  union all
  select 'OVERALL' as competing_area, * from {{ ref('top_neighbors') }}
),

comp_list_split as (
  select competing_area, rank_year, split(neighbors) as neighbors from comp_list
),

comp_list_unnest as (
  select competing_area, rank_year, neighbor from comp_list_split, UNNEST(neighbors) as neighbor
  group by 1,2,3
)

select * from comp_list_unnest
