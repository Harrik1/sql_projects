SELECT
    CASE
        WHEN a.salary_year_avg < 50000 THEN 'Low'
        WHEN a.salary_year_avg > 50000 and a.salary_year_avg < 200000 THEN 'Standard'
        WHEN a.salary_year_avg > 200000 and a.salary_year_avg < 2000000 THEN 'High'
        ELSE 'More than High'
    END AS Salary,
    COUNT(1)
FROM
    job_postings_fact a
WHERE 
    a.job_title = 'Data Analyst'
GROUP BY
    Salary;

select min(salary_year_avg) from job_postings_fact;

SELECT
    avg(salary_year_avg) as average_year_salary, 
    avg(salary_hour_avg) as average_hour_salary,
    job_schedule_type
FROM
    job_postings_fact
WHERE
    job_posted_date::date > '2023-06-01'
GROUP BY
    job_schedule_type;


select 
    a.skill_id,
    b.skills,
    count(1) as job_post_count
from skills_job_dim a left join skills_dim b
    on a.skill_id = b.skill_id
group by a.skill_id, b.skills
order by job_post_count desc
limit 5;

select company_id,
    company_name,
    CASE
        WHEN job_post_count < 10 THEN 'Small'
        WHEN job_post_count >= 10
        and job_post_count < 50 THEN 'Medium'
        WHEN job_post_count >= 50 THEN 'Large'
    END AS Company_Size
FROM (
        select a.company_id,
            b.name as company_name,
            count(1) as job_post_count
        from job_postings_fact a
            left join company_dim b on a.company_id = b.company_id
        group by a.company_id,
            b.name
    );

select count(1), skill_id from skills_job_dim group by skill_id;
select * from job_postings_fact where job_location = 'Anywhere'

select 
    a.skill_id,
    b.skills,
    count(1) as job_post_count
from job_postings_fact c left join skills_job_dim a 
    on c.job_id = a.job_id
    left join skills_dim b
    on a.skill_id = b.skill_id
WHERE
    job_location = 'Anywhere'
group by a.skill_id, b.skills
order by job_post_count desc
limit 5;

with job_posting as (
    select a.skill_id,
        count(1) as skill_count
    from skills_job_dim a
        inner join job_postings_fact b on a.job_id = b.job_id
    where job_work_from_home = True
    group by a.skill_id
)
select x.skill_id,
    y.skills,
    x.skill_count
from job_posting x
    inner join skills_dim y on x.skill_id = y.skill_id
order by skill_count desc
limit 5;


create table march_jobs as
select * from job_postings_fact
where extract(month from job_posted_date) = 3;

--last problem
select * from january_jobs
where salary_year_avg > 70000
UNION
select * from february_jobs
where salary_year_avg > 70000
UNION
select * from march_jobs
WHERE salary_year_avg > 70000

