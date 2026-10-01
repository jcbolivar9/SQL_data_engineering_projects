/*
Question: What are the highest-paying skills for data engineers?
- Calculate the median salary for each skill required in data engineer positions
- Focus on Texas located positions with specified salaries
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command the highest compensation while also showing 
    how common those skills are, providing a more complete picture for skill development priorities
*/

SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
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
HAVING COUNT (jpf.*) > 100
ORDER BY median_salary DESC
LIMIT 20;

/*
Here's a breakdown of the highest-paying skills for Data Engineers in Texas:

Key Insights:
- Mongo leads as the top-paying skill at $207K median salary, with moderate demand (264 postings).
- Elasticsearch and T-SQL both command high median salaries at $177.25K and $160K, respectively, with strong demand (Elasticsearch: 109 postings; T-SQL: 233 postings).
- Other notable skills with both high pay and moderate-to-high frequency include:
    - TensorFlow: $147K median salary (116 postings)
    - PostgreSQL: $146.25K median salary (355 postings)
    - PowerShell: $143.75K median salary (164 postings)
    - Kubernetes: $142.82K median salary (678 postings)
    - Linux: $141.42K median salary (450 postings)
- Heavyweight enterprise data and backend technologies like Kafka ($137.5K; 1,845 postings), Scala ($137.5K; 1,736 postings), NoSQL ($135K; 1,532 postings), and Java ($132.5K; 2,295 postings) anchor the highest volume of postings in this tier.
- Specialized datastores (DynamoDB, MySQL, Cassandra) and systems programming tools (Go, Docker, C) regularly land in the top 20 for pay while maintaining strong overall market demand.

Takeaway: While specialized database solutions like Mongo and search/analytics engines like Elasticsearch take the top compensation spots, high-demand streaming and infrastructure skills (Kafka, Scala, NoSQL, Java, Kubernetes) offer high salaries alongside massive job availability. Combining niche datastore expertise with core distributed systems and DevOps tools provides the best mix of elite earning potential and job security.
┌───────────────┬───────────────┬──────────────┐
│    skills     │ median_salary │ demand_count │
│    varchar    │    double     │    int64     │
├───────────────┼───────────────┼──────────────┤
│ mongo         │      207000.0 │          264 │
│ elasticsearch │      177250.0 │          109 │
│ t-sql         │      160000.0 │          233 │
│ tensorflow    │      147000.0 │          116 │
│ postgresql    │      146250.0 │          355 │
│ powershell    │      143750.0 │          164 │
│ kubernetes    │      142819.0 │          678 │
│ linux         │      141420.0 │          450 │
│ scala         │      137500.0 │         1736 │
│ dynamodb      │      137500.0 │          274 │
│ mysql         │      137500.0 │          790 │
│ kafka         │      137500.0 │         1845 │
│ cassandra     │      137500.0 │          572 │
│ go            │      136250.0 │          552 │
│ c             │      135000.0 │          115 │
│ nosql         │      135000.0 │         1532 │
│ java          │      132500.0 │         2295 │
│ sap           │      132500.0 │          202 │
│ pandas        │      131250.0 │          215 │
│ docker        │      130147.0 │          504 │
└───────────────┴───────────────┴──────────────┘

*/