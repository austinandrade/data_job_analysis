/*
Goal: Identify the top skills based on salary.
- Look at the average salary for each skill for data engineer positions.
- Focus on roles with specified salaryies, regardless of location.
- Why? This reveals how posessing different skills affects salary levels for
    data engineers and helps identify the most well compensated skills to acquire or improve.
*/

SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Engineer' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = True
GROUP BY skills
ORDER BY
    avg_salary DESC
LIMIT 25


/*
Here are insights for the top 25 most compensated skills based on average data engineer salaries including those skills:

There is a high demand for specialized skills. 
    The list showcases a high demand for Data Engineers with expertise in diverse programming languages (like Assembly, Rust, and Julia), emerging technologies (such as Solidity and GraphQL), and niche areas.
    This indicates the value of specialized knowledge in achieving top salaries.

This is followed closely by a high demand for big data and infrastructure expertise.
    Technologies like Kafka, Cassandra, and Kubernetes highlight the critical need for skills in managing large-scale data systems and infrastructure, 
        particularly in cloud environments and data streaming.

There is an overall emphasis in versatility in various tools and technologies.
    The inclusion of tools for development, collaboration (e.g., Bitbucket, Splunk), and specialized data stores (like Neo4j and Redis) underscores the importance of versatility 
        and the ability to navigate a wide array of technological landscapes.

[
  {
    "skills": "assembly",
    "avg_salary": "192500"
  },
  {
    "skills": "mongo",
    "avg_salary": "182223"
  },
  {
    "skills": "ggplot2",
    "avg_salary": "176250"
  },
  {
    "skills": "rust",
    "avg_salary": "172819"
  },
  {
    "skills": "clojure",
    "avg_salary": "170867"
  },
  {
    "skills": "perl",
    "avg_salary": "169000"
  },
  {
    "skills": "neo4j",
    "avg_salary": "166559"
  },
  {
    "skills": "solidity",
    "avg_salary": "166250"
  },
  {
    "skills": "graphql",
    "avg_salary": "162547"
  },
  {
    "skills": "julia",
    "avg_salary": "160500"
  },
  {
    "skills": "splunk",
    "avg_salary": "160397"
  },
  {
    "skills": "bitbucket",
    "avg_salary": "160333"
  },
  {
    "skills": "zoom",
    "avg_salary": "159000"
  },
  {
    "skills": "kubernetes",
    "avg_salary": "158190"
  },
  {
    "skills": "numpy",
    "avg_salary": "157592"
  },
  {
    "skills": "mxnet",
    "avg_salary": "157500"
  },
  {
    "skills": "fastapi",
    "avg_salary": "157500"
  },
  {
    "skills": "redis",
    "avg_salary": "157000"
  },
  {
    "skills": "trello",
    "avg_salary": "155000"
  },
  {
    "skills": "jquery",
    "avg_salary": "151667"
  },
  {
    "skills": "express",
    "avg_salary": "151636"
  },
  {
    "skills": "cassandra",
    "avg_salary": "151282"
  },
  {
    "skills": "unify",
    "avg_salary": "151000"
  },
  {
    "skills": "kafka",
    "avg_salary": "150549"
  },
  {
    "skills": "vmware",
    "avg_salary": "150000"
  }
]
*/