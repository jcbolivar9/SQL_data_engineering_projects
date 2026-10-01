SELECT
    job_id,
    job_title_short,
    salary_year_avg,
    company_id
FROM
    job_postings_fact
LIMIT 10;

SELECT
    company_id,
    name
FROM
    company_dim
LIMIT 10;

SELECT
    *
FROM
    company_dim
WHERE
    name IN ('Facebook','Meta');

SELECT *
FROM skills_job_dim
LIMIT 5;

SELECT *
FROM skills_dim 
LIMIT 5;

SELECT *
FROM information_schema.key_column_usage
WHERE table_catalog = 'data_jobs';

SELECT
    jpf.job_id
    cd.name AS company_name
    jpf.job_title_short
FROM
    job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id


