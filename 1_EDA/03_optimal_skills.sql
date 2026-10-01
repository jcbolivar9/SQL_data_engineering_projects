/*
Question: What are the most optimal skills for data engineers—balancing both demand and salary?
- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on Data Engineer positions in Texas with specified annual salaries.
- Why?
    - This approach highlights skills that balance market demand and financial reward. It weights core skills appropriately instead of letting rare, outlier skills distort the results.
    - The natural log transformation ensures that both high-salary and widely in-demand skills surface as the most practical and valuable to learn for data engineering careers.
*/

SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    --COUNT(jpf.*) AS demand_count,
    ROUND(LN(COUNT(jpf.*)), 1) AS ln_demand_count,
    ROUND((MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*))/1_000_000), 2) AS optimal_score
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd 
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd 
    ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_location LIKE '%, TX'
    AND jpf.salary_year_avg IS NOT NULL
GROUP BY sd.skills
HAVING COUNT(jpf.*) > 100
ORDER BY optimal_score DESC
LIMIT 20;

/*
Here's a breakdown of the most optimal skills for Data Engineers, based on both high demand and high salaries:

-Top Skills by Optimal Score:
    - Python leads the list with a 0.77 optimal score, driven by a $125K median salary and the highest demand weight (6.1 ln_demand).
    - SQL closely follows as a core foundational skill with a 0.74 optimal score, $120K median salary, and top demand weight (6.2 ln_demand).
    - AWS ($127K median, 5.6 ln_demand) and Azure ($125K median, 5.6 ln_demand) tied with a 0.70–0.71 optimal score, demonstrating strong enterprise cloud demand.
    - Spark ($130K median, 5.3 ln_demand) and Snowflake ($127.5K median, 5.3 ln_demand) stand out as the top optimal skills for big data processing and cloud data warehousing.
- High-Paying Streaming & Languages:
    - Kafka and Scala both command high median salaries at $137.5K (4.8 ln_demand), yielding strong optimal scores of 0.66 and 0.65, respectively.
    - Java ($132.5K median, 5.1 ln_demand) remains a premier choices for enterprise data engineering with a 0.68 optimal score.
- Databases & Data Platforms:
    - Databricks ($127.5K median), Redshift ($125K median), Hadoop ($125K median), and NoSQL ($135K median) each maintain optimal scores between 0.59 and 0.64 with steady market demand.
    - Power BI ($105K median, 4.7 ln_demand) rounds out the list with a 0.49 optimal score, serving primarily as a business intelligence interface rather than a core engineering tool.

Summary:
Skills that achieve the highest optimal scores successfully balance massive market demand with competitive financial return. Python, SQL, AWS, Spark, and Azure represent the most strategic core competencies for maximizing both job volume and overall earning potential in data engineering.

┌────────────┬───────────────┬─────────────────┬───────────────┐
│   skills   │ median_salary │ ln_demand_count │ optimal_score │
│  varchar   │    double     │     double      │    double     │
├────────────┼───────────────┼─────────────────┼───────────────┤
│ python     │      125000.0 │             6.1 │          0.77 │
│ sql        │      120000.0 │             6.2 │          0.74 │
│ aws        │      127045.0 │             5.6 │          0.71 │
│ spark      │      130000.0 │             5.3 │           0.7 │
│ azure      │      125000.0 │             5.6 │           0.7 │
│ java       │      132500.0 │             5.1 │          0.68 │
│ snowflake  │      127500.0 │             5.3 │          0.67 │
│ kafka      │      137500.0 │             4.8 │          0.66 │
│ scala      │      137500.0 │             4.8 │          0.65 │
│ nosql      │      135000.0 │             4.7 │          0.64 │
│ databricks │      127500.0 │             4.7 │           0.6 │
│ redshift   │      125000.0 │             4.8 │           0.6 │
│ hadoop     │      125000.0 │             4.8 │          0.59 │
│ power bi   │      105000.0 │             4.7 │          0.49 │
└────────────┴───────────────┴─────────────────┴───────────────┘
*/
