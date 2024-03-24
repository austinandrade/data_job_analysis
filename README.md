# Introduction
🚀 Let's explore the data job market! Focusing on data engineer roles, this project aims to explore the 💰 top-paying jobs, 🔥 in-demand skills, and where 📈 high demand meets high salary in data engineering.

🔎 the SQL queries are found [here](/project_sql/)

# Background
This project was motivated by the desire to identify the most in-demand skills within the data engineering job market to streamline the job search and upskilling process.


### I used SQL to answer the following questions:
1. What are the top-paying data engineer jobs?
2. What skills are required for those top-paying jobs?
3. What skills are most in demand across all data engineer roles?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn or improve?

# Tools I Used
For my analysis, I utilized the power of 5 key tools:

- **SQL**: The foundation of my analysis, allowing me to query the database and unearth critical insights.
**PostgreSQL**: The chosen database management system is ideal for handling the job posting data.
- **Visual Studio Code**: My go-to for database management and executing SQL queries.
- **Git & Github**: Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Each query for this project aimed to investigate specific aspects of the data engineer job market. Here's how I approached each question:

### 1. Top Paying Data Engineer Jobs
First, I aimed to identify the highest-paying roles to understand the salary ceiling for data engineer titles. To accomplish this, I filtered data engineer positions by average yearly salary and location, focusing on remote jobs. This query highlights the highest-paying opportunities in the field.

```sql
SELECT job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Engineer'
    AND job_work_from_home = True
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 100
```
Here's the breakdown of the top data engineer jobs in 2023:
- **Emphasis on Advanced Titles and Specializations**: The dataset includes a variety of job titles that go beyond the standard "Data Engineer" role, such as "Principal Data Engineer," "Data Engineering Manager," "Director of Engineering - Data Platform," and "Lead Data Engineer." This variety points to the layered and specialized nature of the field. It suggests a robust market for professionals with deep technical skills, leadership qualities, and specialized knowledge required to manage complex data ecosystems and strategic projects.

- **Competitive Salaries Reflect High Demand**: The range of salaries, with some positions offering upwards of $300,000, underscores the high demand for data engineering expertise. These competitive salaries reflect the crucial role that data engineers play in extracting valuable insights from data, optimizing data infrastructure, and contributing to data-driven decision-making processes which are vital for business growth and innovation.

- **Diverse Industries Investing in Data Engineering**: Companies from various sectors, including tech giants, finance, healthcare, digital marketing, and startups, highlight the widespread recognition of the value of data engineering across different industries. This trend suggests that data engineering skills are essential for tech companies and organizations looking to leverage big data for strategic advantage. This indicates a broad spectrum of opportunities for data engineers.

### 2. Skills Required for Top-Paying Jobs
Next, I identified the required skills for top-paying roles by counting the skills that appeared across all top jobs. This query highlights the top skills among the results.

```sql
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
```
Here's the breakdown of the skills required for the top-paying jobs in data engineering:
- **Core Programming and Database Skills Remain Essential**: The prominence of Python and SQL at the top highlights their continued importance as foundational tools for data manipulation, processing, and management. These skills are indispensable for efficiently handling data workflows and database interactions.

- **Rising Demand for Big Data and Cloud Technologies**: Expertise in big data technologies (Spark, Kafka) and cloud platforms (AWS, Azure) reflects the industry's shift towards handling large-scale data processing in cloud environments. These skills underscore the necessity for real-time analytics and scalable data storage solutions.

- **Specialized Tools for Data Workflow Management**: The inclusion of Airflow and Snowflake points to the growing need for sophisticated workflow management and data warehousing solutions that support complex data pipelines and analytics within cloud-native ecosystems.

| Skills | Total Job Count|
|--------|-------------|
| Python | 76          |
| SQL    | 61          |
| Spark  | 49          |
| AWS    | 48          |
| Kafka  | 43          |
| Airflow| 27          |
| Azure  | 25          |
| Java   | 25          |
| Scala  | 25          |
| Snowflake | 23       |

*Table of the required skills in the top 100 highest-paid data engineer jobs*

### 3. Most In-Demand Skills Across All Listings
Then, I identified which skills appeared most frequently across all engineer listings, regardless of salary. This query highlights the skills that popped up the most.

```sql
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
```
Here's the breakdown of the most in-demand skills across all data engineering:

- **SQL and Python as Pillars of Data Engineering**: SQL and Python remain the most in-demand skills, reflecting their foundational roles in the field. SQL's prominence underscores the critical need for data engineers to possess robust database querying and management capabilities, vital for interacting with relational databases. Python's near-equivalent demand highlights its versatility and widespread adoption for data manipulation, processing, and machine learning tasks, cementing its position as a core programming language for data engineers.

- **Cloud Platforms Are Indispensable**: The significant demand for AWS and Azure skills illustrates the cloud-centric approach adopted by the industry. Mastery of these platforms is crucial for designing, implementing, and managing scalable, secure, and efficient cloud-based data infrastructures. The strong demand for AWS and Azure expertise reflects the shift towards leveraging cloud services for data storage, processing, and analysis, highlighting the cloud as a critical component of modern data engineering ecosystems.

- **Big Data Technologies Remain Key**: Spark's inclusion in the top 5 skills signifies the ongoing importance of big data technologies in handling large-scale data processing and analytics. Spark, known for its speed and capability to process large datasets, is critical for building scalable data processing pipelines that support real-time analytics and data-driven decision-making.

| Skills | Demand Count|
|--------|-------------|
| SQL    | 14213       |
| Python | 13893       |
| AWS    | 8570        |
| Azure  | 6997        |
| Spark  | 6612        |

*Table of the demand for the top 5 skills in data engineer job postings*

### 4. Skill Salary Correlation
Once I got a basis for the general market, I aimed to identify how salaries aligned with different engineering skills. This query highlights the highest-paying skills.

```sql
SELECT skills,
  ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
  INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
  INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Engineer'
  AND salary_year_avg IS NOT NULL
  AND job_work_from_home = True
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 25
```

- **Niche and Emerging Technologies Command Premium Salaries**: Skills like Assembly, Rust, Solidity, and Neo4j indicate a premium on niche and emerging technologies. Assembly and Rust, known for their performance and security features, suggest high-value projects requiring low-level programming capabilities or systems-level software development. Solidity's presence reflects the growing interest and lucrative opportunities in blockchain development. Neo4j, a graph database technology, underscores the increasing importance of complex data relationships and graph analytics in solving modern data challenges.

- **Versatility Across Data Storage and Processing**: The high compensation for skills in MongoDB (mongo), Redis, Cassandra, and Kafka illustrates the demand for engineers proficient in diverse data storage and processing technologies. These skills reflect the necessity for scalable, high-performance solutions capable of handling varied data workloads, from NoSQL databases for flexible data storage to Kafka for real-time data streaming and processing.

- **Advanced Analytics and Infrastructure Management**: Skills like ggplot2, Kubernetes, and Splunk highlight the importance of advanced analytics, visualization, and infrastructure management. ggplot2's presence points to the value of data visualization skills in communicating insights, whereas Kubernetes and Splunk emphasize the need for expertise in managing containerized applications and analyzing large datasets, respectively. This trend signifies the role of data engineers not just in managing data, but also in extracting value from it and ensuring the robustness of the data infrastructure.

| Skills | Average Salary ($)|
|--------|-------------|
| Assembly | 192,500          |
| Mongo    | 182,223          |
| Ggplot2  | 176,250          |
| Rust    | 172,819          |
| Clojure  | 170,867          |
| Perl      | 169,000           |
| Neo4j     | 166,559          |
| Solidify   | 166,250          |
| Graphql  | 162,547          |
| Julia     | 160,500        |

*Table of the average salary among the top 10 paying skills for data engineers*

### 5. Optimal Skills
An optimal skill is both in high-demand and well compensated. This query provides insight into the most well-compensated data engineering roles alongside how frequently those roles appear across all data engineering positions. 

```sql
SELECT skills_dim.skill_id,
  skills_dim.skills,
  COUNT(skills_job_dim.job_id) AS demand_count,
  ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
  INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
  INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Engineer'
  AND salary_year_avg IS NOT NULL
  AND job_work_from_home = True
GROUP BY skills_dim.skill_id
HAVING COUNT(skills_job_dim.job_id) > 50
ORDER BY avg_salary DESC,
  demand_count DESC
LIMIT 25
```

Here are insights into the most ideal roles based on the highest average salaries and number of positions in data engineering:

- **Cloud and Big Data Technologies Drive High Compensation**: The prominence of Kubernetes, Docker, Kafka, and Spark at the top of the compensation scale highlights the industry's prioritization of cloud-native technologies and big data processing frameworks. These skills reflect a shift towards scalable, efficient cloud-based environments and the capability to handle real-time data processing and analytics.

- **Versatility in Data Storage Solutions**: High salaries for expertise in modern data warehousing and database technologies, such as Snowflake, Redshift, and various NoSQL databases, underscore the demand for data engineers who can navigate cloud-based and traditional data storage solutions. This trend signifies the necessity for flexible data management approaches to support diverse data types and workloads.

- **Foundational Programming and Cloud Platform Expertise**: Python and Java's enduring relevance, coupled with the high demand and compensation for AWS, Azure, and GCP skills, underline the critical role of core programming expertise and cloud platform knowledge in today’s data engineering landscape. Mastery in these areas is essential for building and managing sophisticated data infrastructure in a cloud-dominated ecosystem.

| Skills | Demand Count | Average Salary ($) |
|--------|-------------|-------| 
| Kubernetes | 56          | 158,190
| Kafka    | 134          | 150,549
| Scala  | 113          | 141,777
| Spark    | 237          | 139,838
| Pyspark  | 64          | 139,428
| Airflow      | 151           | 138,518
| Java     | 139          | 138,087
| Hadoop   | 98          | 137,707
| NoSQL  | 93          | 136,430
| Snowflake     | 202        | 134,373

*Table of the most optimal skills for data engineers sorted by salary

# What I learned

Using SQL on real-world data to acquire personal insights has been invaluable in developing my understanding and use of SQL in practical applications.

I've become comfortable:

- **🧪 Crafting Complex Queries:** Merging multiple tables using multiple JOINS clauses and scoping data using WHERE clauses.
- **➗ Aggregating Data** Using GROUP BY and aggregate functions such as COUNT() and AVG() to present data.
- 💭 Translating real-world analytical asks into actionable, insightful SQL queries.

# Conclusions

1. **Core Skills and Cloud Mastery Are Essential**: The industry highly values foundational programming skills, particularly in Python and SQL, alongside expertise in major cloud platforms like AWS and Azure. This underscores the indispensable nature of core programming abilities and cloud proficiency in creating, managing, and scaling modern, efficient data infrastructures. Mastery in these areas enables data engineers to build sophisticated data processing pipelines and manage vast datasets effectively within cloud ecosystems.

2. **High Demand for Big Data and Real-Time Processing Expertise**: Skills associated with big data technologies (e.g., Spark, Kafka) and cloud-native frameworks (e.g., Kubernetes, Docker) are crucial due to the industry's focus on scalable and real-time data processing capabilities. This trend reflects the shift towards leveraging advanced data storage and analytics solutions capable of efficiently handling large volumes of data in real time, highlighting the critical role of big data technologies in today's data-driven decision-making processes.

3. **Versatility in Data Storage Technologies**: Proficiency in data storage solutions, from modern data warehousing technologies like Snowflake and Redshift to various NoSQL databases, is highly valued. This versatility signifies the growing complexity of data landscapes and the need for data engineers to navigate cloud-based and traditional data storage mechanisms effectively, ensuring flexibility and performance across diverse data types and workloads.

4. **Premium on Niche Technologies and Advanced Analytics**: Emerging and specialized technologies command premium salaries, indicating lucrative opportunities in areas like blockchain development (e.g., Solidity), low-level programming (e.g., Assembly, Rust), and graph databases (e.g., Neo4j). Additionally, skills in advanced analytics and visualization (e.g., ggplot2) are essential, emphasizing the importance of managing data, extracting actionable insights, and ensuring effective communication through data visualization.

5. **Shift Towards Comprehensive Data Infrastructure Management**: The industry's emphasis on tools for workflow management and sophisticated data processing (e.g., Airflow, Snowflake) alongside skills in infrastructure management (e.g., Kubernetes, Splunk) reflects a holistic approach to data engineering. This approach prioritizes not just the storage and processing of data but also the efficient management of data workflows and infrastructures, highlighting data engineers' evolving role in ensuring data ecosystems' robustness and reliability.

### Closing Thoughts

This project was an excellent way to practice and evolve my SQL skills and provided fantastic insight into the data engineer job market. What I've discovered through this analysis will serve as a valuable resource in my skill development and job search and hopefully serve other active or aspiring data engineers by helping them identify high-demand, high-paying skills. This work serves as a testament to the importance of continuous learning and adaptation to emerging trends in the field of data engineering.