select c.skill_id,
    c.skills,
    count(a.job_id) as demand_count,
    round(avg(a.salary_year_avg), 2) as avg_salary
from job_postings_fact a
    INNER JOIN skills_job_dim b on a.job_id = b.job_id
    INNER JOIN skills_dim c on b.skill_id = c.skill_id
where a.job_title_short = 'Data Analyst'
    and salary_year_avg is NOT NULL
    and job_work_from_home = true
group BY c.skill_id,
    c.skills
having count(a.job_id) > 10
order by avg_salary desc,
    demand_count desc
limit 25