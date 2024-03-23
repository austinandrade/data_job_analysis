/*
 Goal: Identify what skills are most in-demand across all data engineer jobs.
 - Why? It provides a detailed outlook at the top 5 skills across all data
 engineer jobs, helping job seekers understand the most valuable skills to 
 focus on developing based on total industry demand.
 */

SELECT skills,
  COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
  INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
  INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Engineer'
  AND job_work_from_home = True
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5

/*
  Here's the breakdown of the top 5 most in-demand data engineer skills in 2023
  across all data engineer job listings.
  
  - SQL ranks first with 14213 appearances.
  - Python follows close with 13893.
  - AWS ranks third, appearing 8570 times.
  - Azure is fourth with 6997.
  - Spark is last of the top 5 with 6612 appearances.
  
  [
  {
  "skills": "sql",
  "demand_count": "14213"
  },
  {
  "skills": "python",
  "demand_count": "13893"
  },
  {
  "skills": "aws",
  "demand_count": "8570"
  },
  {
  "skills": "azure",
  "demand_count": "6997"
  },
  {
  "skills": "spark",
  "demand_count": "6612"
  }
  ]
*/