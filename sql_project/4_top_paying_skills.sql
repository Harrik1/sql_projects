select b.skill_id,
    c.skills,
    round(avg(a.salary_year_avg), 2) as avg_salary
from job_postings_fact a
    inner join skills_job_dim b on a.job_id = b.job_id
    INNER JOIN skills_dim c on b.skill_id = c.skill_id
where job_title_short = 'Data Analyst'
    and salary_year_avg is NOT NULL
group by b.skill_id,
    c.skills
order by avg_salary desc
limit 25;