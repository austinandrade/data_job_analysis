/*
 Goal: Identify what skills are required for the top-paying data engineer jobs.
 - Why? It provides a detailed outlook at which high-paying jobs demand certain skills,
 helping job seekers understand which skills to develop that align with top salaries.
 */

WITH top_paying_jobs AS (
  SELECT job_id,
    job_title,
    salary_year_avg,
    name AS company_name
  FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
  WHERE job_title_short = 'Data Engineer'
    AND job_work_from_home = True
    AND salary_year_avg IS NOT NULL
  ORDER BY salary_year_avg DESC
  LIMIT 100
)

SELECT skills_dim.skills,
  COUNT(*) AS total_job_count
FROM top_paying_jobs
  INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
  INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY skills_dim.skills
ORDER BY total_job_count DESC
LIMIT 10

/*
  Here's the breakdown of the top 10 most in-demand data engineer skills in 2023,
  based on the top 10 and top 100 highest paying jobs for that role.
  
  NOTE: The limit clause in the top_paying_jobs CTE can be modified to reflect a larger data set.
  
  By Top 10 Jobs
  - Python is the most frequently mentioned skill, appearing in 7 job postings. 
  - Spark follows with 5 mentions.
  - Hadoop, Kafka, and Scala each have 3 mentions.
  - Pandas, Numpy, Pyspark, Kubernetes, SQL, Databricks each appear twice.
  - Other skills like Go, Java, GCP (Google Cloud Platform), AWS (Amazon Web Services), NoSQL, PyTorch, Azure, R, Keras, TensorFlow, and Perl are mentioned once. 
  
  By Top 100 Jobs
  - Python is the most frequently mentioned skill, with 76 mentions.
  - SQL is a close second with 61 mentions.
  - Spark and AWS (Amazon Web Services) are also highly sought after, with 49 and 48 mentions, respectively. 
  - Kafka is mentioned 43 times.
  - Lastly, Airflow, Azure, Java, Scala are mentioned 25 times with Snowflake folllowing closely with 23 mentions.
  
  [
  {
  "skills": "python",
  "total_job_count": "76"
  },
  {
  "skills": "sql",
  "total_job_count": "61"
  },
  {
  "skills": "spark",
  "total_job_count": "49"
  },
  {
  "skills": "aws",
  "total_job_count": "48"
  },
  {
  "skills": "kafka",
  "total_job_count": "43"
  },
  {
  "skills": "airflow",
  "total_job_count": "27"
  },
  {
  "skills": "azure",
  "total_job_count": "25"
  },
  {
  "skills": "java",
  "total_job_count": "25"
  },
  {
  "skills": "scala",
  "total_job_count": "25"
  },
  {
  "skills": "snowflake",
  "total_job_count": "23"
  }
  ]
*/