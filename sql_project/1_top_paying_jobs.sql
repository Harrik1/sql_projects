select job_id,
    job_title,
    salary_year_avg,
    job_posted_date,
    name as company_name
from job_postings_fact
INNER JOIN company_dim
    on job_postings_fact.company_id = company_dim.company_id
where job_title_short = 'Data Analyst'
    and job_location = 'Anywhere'
    AND salary_year_avg is NOT NULL
order by 3 desc
limit 10;