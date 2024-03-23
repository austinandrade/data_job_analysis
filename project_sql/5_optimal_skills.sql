/*
Goal: Identify the most optimal skills to learn or improve (both in high demand and high paying)
- We will focus on remote positions with specified salaries
- Why? Optimal skills are those that offer job security since they are in high-demand and
    financial incentive as they are high paying.
These offer strategic insights for career development in data engineering.
*/

SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Engineer'
    AND salary_year_avg IS NOT NULL 
    AND job_work_from_home = True
GROUP BY 
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 50
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25

/*
As previously observed, the top 5 most in-demand skills are SQL, Python, AWS, Azure, and Spark. However, by compensation:
- Kubernetes ranks first as the highest paid skill at $158,190 among 56 roles.
- Kafka closley follows with $150,549 across 134 roles.
- Scala is third at $141,777 across 113 roles.
- Spark is fourth at $139,838 across 237 roles.
- Pyspark ranks last at $139,428 across 64 roles.

Among both demand and compensation Spark is the only skill that appears in both top 5 most compensated and demand.

[
  {
    "skill_id": 213,
    "skills": "kubernetes",
    "demand_count": "56",
    "avg_salary": "158190"
  },
  {
    "skill_id": 98,
    "skills": "kafka",
    "demand_count": "134",
    "avg_salary": "150549"
  },
  {
    "skill_id": 3,
    "skills": "scala",
    "demand_count": "113",
    "avg_salary": "141777"
  },
  {
    "skill_id": 92,
    "skills": "spark",
    "demand_count": "237",
    "avg_salary": "139838"
  },
  {
    "skill_id": 95,
    "skills": "pyspark",
    "demand_count": "64",
    "avg_salary": "139428"
  },
  {
    "skill_id": 96,
    "skills": "airflow",
    "demand_count": "151",
    "avg_salary": "138518"
  },
  {
    "skill_id": 4,
    "skills": "java",
    "demand_count": "139",
    "avg_salary": "138087"
  },
  {
    "skill_id": 97,
    "skills": "hadoop",
    "demand_count": "98",
    "avg_salary": "137707"
  },
  {
    "skill_id": 2,
    "skills": "nosql",
    "demand_count": "93",
    "avg_salary": "136430"
  },
  {
    "skill_id": 80,
    "skills": "snowflake",
    "demand_count": "202",
    "avg_salary": "134373"
  },
  {
    "skill_id": 214,
    "skills": "docker",
    "demand_count": "64",
    "avg_salary": "134286"
  },
  {
    "skill_id": 81,
    "skills": "gcp",
    "demand_count": "76",
    "avg_salary": "133388"
  },
  {
    "skill_id": 78,
    "skills": "redshift",
    "demand_count": "141",
    "avg_salary": "132980"
  },
  {
    "skill_id": 76,
    "skills": "aws",
    "demand_count": "367",
    "avg_salary": "132865"
  },
  {
    "skill_id": 1,
    "skills": "python",
    "demand_count": "535",
    "avg_salary": "132200"
  },
  {
    "skill_id": 75,
    "skills": "databricks",
    "demand_count": "130",
    "avg_salary": "130072"
  },
  {
    "skill_id": 74,
    "skills": "azure",
    "demand_count": "254",
    "avg_salary": "129574"
  },
  {
    "skill_id": 56,
    "skills": "mysql",
    "demand_count": "53",
    "avg_salary": "129288"
  },
  {
    "skill_id": 0,
    "skills": "sql",
    "demand_count": "568",
    "avg_salary": "129191"
  },
  {
    "skill_id": 210,
    "skills": "git",
    "demand_count": "74",
    "avg_salary": "128352"
  },
  {
    "skill_id": 77,
    "skills": "bigquery",
    "demand_count": "53",
    "avg_salary": "126627"
  },
  {
    "skill_id": 8,
    "skills": "go",
    "demand_count": "53",
    "avg_salary": "125006"
  },
  {
    "skill_id": 79,
    "skills": "oracle",
    "demand_count": "63",
    "avg_salary": "121980"
  },
  {
    "skill_id": 57,
    "skills": "postgresql",
    "demand_count": "55",
    "avg_salary": "121786"
  },
  {
    "skill_id": 61,
    "skills": "sql server",
    "demand_count": "82",
    "avg_salary": "121364"
  }
]
*/