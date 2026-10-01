/*
Question: What are the most in-demand skills for data engineers?
- Join job postings to inner join table similar to query 2
- Identify the top 10 in-demand skills for data engineers
- Focus on Texas job postings
- Why? Retrieves the top 10 skills with the highest demand in the remote job market,
    providing insights into the most valuable skills for data engineers seeking remote work
*/

SELECT
    sd.skills,
    COUNT(jpf.*) AS demand_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd 
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd 
    ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_location LIKE '%, TX'
GROUP BY sd.skills
ORDER BY demand_count DESC
LIMIT 10;

/*
Here's the breakdown of the most demanded skills for data engineers:
SQL and Python are by far the most in-demand skills, with around 6,400 job postings each - nearly double the next closest skill.
Cloud platforms round out the top skills, with AWS leading at ~4,000 postings, followed by Azure at ~3,300.
Apache Spark completes the top 5 with nearly 700 postings, highlighting the importance of big data processing skills.

Key takeaways:
- SQL and Python remain the foundational skills for data engineers
- Cloud platforms (AWS, Azure) are critical for modern data engineering
- Big data tools like Spark continue to be highly valued
- Data pipeline tools (Airflow, Snowflake, Databricks) show growing demand
- Hadoop and sql server round out the top 10 most requested skills
┌───────────┬──────────────┐
│  skills   │ demand_count │
│  varchar  │    int64     │
├───────────┼──────────────┤
│ sql       │         6404 │
│ python    │         6341 │
│ aws       │         3890 │
│ azure     │         3245 │
│ spark     │         3161 │
│ snowflake │         2618 │
│ java      │         2295 │
│ kafka     │         1845 │
│ hadoop    │         1746 │
│ scala     │         1736 │
└───────────┴──────────────┘
*/