with
  raw_csv as (select * from {{ source('gsheets', 'ranking') }} ),

  parsed as (
    select
      Institution                   as institution,
      Ranking_Year                  as rank_year,


      -- Results
      Ranking                       as ranking_uni,
      Guardian_score_100            as score_uni,

      -- Features
      Expenditure_per_student___10  as spend_uni,
      Student_staff_ratio           as ratio_uni,
      Career_prospects____          as career_uni,
      Value_added_score_10          as value_score_uni,
      Entry_Tariff                  as tariff_uni,

      -- Student survey results
      NSS_Teaching____              as nss_teaching_uni,
      NSS_Overall____               as nss_overall_uni,
      NSS_Feedback____              as nss_feedback_uni,

      -- Supplemental
      Ranking__Prev_                as ranking_prev_uni,
      Ranking_Change                as ranking_change_uni
    from raw_csv

  )

select *
from parsed
