with
  raw_csv as (select * from {{ source('gsheets', 'subjectareas') }} ),

  parsed as (
    select
      Institution                   as institution,
      Subject_Area                  as course,
      Subject_Area_Year             as rank_year,

      -- Results
      Subject_Area_Rank             as ranking,
      Guardian_score_100            as score,

      -- Features
      Expenditure_per_student__FTE_ as spend,
      Student_staff_ratio           as ratio,
      Career_prospects              as career,
      Value_added_score_10          as value_score,
      Average_Entry_Tariff          as tariff,

      -- Student survey results
      __Satisfied_with_Teaching     as nss_teaching,
      __Satisfied_overall_with_course as nss_overall,
      __Satisfied_with_Assessment   as nss_feedback,

      -- Supplemental
      Subject_Area_Rank__Prev_      as ranking_prev,
      Subject_Area_Rank_Change      as ranking_change
    from raw_csv

  )

select *
from parsed
