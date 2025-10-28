select
    b.skill_id, 
    c.skills,
    count(1) as demand_count
from job_postings_fact a
    INNER JOIN skills_job_dim b on a.job_id = b.job_id
    INNER JOIN skills_dim c on b.skill_id = c.skill_id
where a.job_title_short = 'Data Analyst'
group BY b.skill_id, c.skills
order by demand_count desc
limit 5