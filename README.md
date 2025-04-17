
# Title: horse_power_assignment_sql

A PL/SQL-based project that showcases the power and flexibility of **window functions** in managing and analyzing database records. This project explores real-world scenarios where window functions such as `RANK()`, `DENSE_RANK()`, `ROW_NUMBER()`, `LEAD()`, `LAG()`, and others are used to provide advanced query solutions.
<BR>
<br>
<br>
## 👥  Team Members

 MUCYO BILLY &nbsp;&nbsp;&nbsp;&nbsp; ID: 26853   
UWASE Anitha &nbsp;&nbsp;&nbsp;&nbsp; ID: 26945
<BR>
<br>
<br>
## 🛠️ Technologies Used

- **Oracle SQL Developer**
- **PL/SQL**
  <BR>
  <br>
  <br>

# 🧠 QUERIES, RESULTS, EXPLANATION & SCREENSHOTS.
 <BR>

## 1.📌 _Dataset Selection_
For this assignment, We have chosen to work with one dataset only — the employees dataset. 
All required SQL window function tasks (comparisons, ranking, top records, earliest records, and aggregations) 
have been applied to this single dataset as allowed by the assignment instructions.
 <BR>
  <br>
  <br>

## 2. 📡 _CREATING TABLE AND PERFORMING QUERY OPERATIONS_

 <BR>
 


### 📊 Table Structure:

 We have to create a table for our project and we name it " _**employees**_ ". We created it using the following codes
 <BR>
 
 ```sql

CREATE TABLE employees (
    emp_id        NUMBER PRIMARY KEY,
    emp_name      VARCHAR2(50),
    department    VARCHAR2(30),
    salary        NUMBER(10,2),
    hire_date     DATE
);

```
 <BR>
 
![WhatsApp Image 2025-04-17 at 10 19 56 PM (4)](https://github.com/user-attachments/assets/6f51992c-1576-43e2-9c1b-165540836da4)








<br>
<br>

## 3. 📝 _DATA INSERTION._

 <BR>

For the purpose of keeping the readme short, I chose to use few example to demostrate the insertion of data in our Tables. 

###  Insertion for employees Table
 <BR>


```sql
INSERT INTO employees VALUES (1, 'Alice',   'HR',       4000, TO_DATE('2021-01-15', 'YYYY-MM-DD'));
INSERT INTO employees VALUES (2, 'Bob',     'IT',       6000, TO_DATE('2020-03-20', 'YYYY-MM-DD'));
INSERT INTO employees VALUES (3, 'Charlie', 'IT',       5500, TO_DATE('2022-06-10', 'YYYY-MM-DD'));
INSERT INTO employees VALUES (4, 'David',   'Finance',  4800, TO_DATE('2019-11-01', 'YYYY-MM-DD'));
INSERT INTO employees VALUES (5, 'Eva',     'HR',       4200, TO_DATE('2021-07-23', 'YYYY-MM-DD'));
INSERT INTO employees VALUES (6, 'Frank',   'Finance',  4800, TO_DATE('2023-01-09', 'YYYY-MM-DD'));
INSERT INTO employees VALUES (7, 'Grace',   'IT',       6000, TO_DATE('2022-02-14', 'YYYY-MM-DD'));
INSERT INTO employees VALUES (8, 'Helen',   'HR',       4000, TO_DATE('2020-10-30', 'YYYY-MM-DD'));
INSERT INTO employees VALUES (9, 'Ian',     'Finance',  5100, TO_DATE('2021-03-05', 'YYYY-MM-DD'));
INSERT INTO employees VALUES (10, 'Jake',   'IT',       5500, TO_DATE('2023-04-01', 'YYYY-MM-DD'));

```
 <BR>
 
![WhatsApp Image 2025-04-17 at 10 19 57 PM](https://github.com/user-attachments/assets/b14e4a6a-c095-42e1-b533-ca1acc5fdb7c)


<br>
 <BR>
 ###### _Explanation:_
 10 records were inserted to allow analysis using `LAG`, `LEAD`, `RANK`, `DENSE_RANK`, `ROW_NUMBER`, and aggregate functions.
<br>
<br>
<br>
## 4. ✅ _Compare Values with Previous or Next Records_
 <BR>
 
### 📌 Use `LAG()` and `LEAD()` to compare salaries
 <BR>
 
```sql
SELECT 
    emp_id,
    emp_name,
    department,
    salary,
    LAG(salary) OVER (ORDER BY hire_date) AS prev_salary,
    LEAD(salary) OVER (ORDER BY hire_date) AS next_salary,
    CASE 
        WHEN salary > LAG(salary) OVER (ORDER BY hire_date) THEN 'HIGHER'
        WHEN salary < LAG(salary) OVER (ORDER BY hire_date) THEN 'LOWER'
        ELSE 'EQUAL'
    END AS salary_vs_previous
FROM employees
ORDER BY hire_date;

```
 <BR>


![WhatsApp Image 2025-04-17 at 10 19 56 PM (3)](https://github.com/user-attachments/assets/14510553-0e63-4bbf-b0fb-9f0490f38a31)


 <BR>
  <br>
  ###### _Explanation:_
 Compares each employee’s salary with the previous employee by hire date.
<br>
<br>
<br>

## 5. ✅ _Ranking Data within a Category_
 <BR>

### 📌 Use `RANK()` and `DENSE_RANK()` by department (based on salary)
 <BR>
  
```sql
SELECT 
    emp_id,
    emp_name,
    department,
    salary,
    RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank_salary,
    DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dense_rank_salary
FROM employees;

```

  <br>
  
 
![WhatsApp Image 2025-04-17 at 10 19 56 PM (2)](https://github.com/user-attachments/assets/0c9436c0-d05b-44a8-9228-a4e871f142e9)


  <br>
  <br>
 #### _Explanation:_
 ###### _Difference between `RANK()` and `DENSE_RANK()`_
 
- `RANK()` skips ranks if there are ties.

- `DENSE_RANK()` does not skip; ties get the same rank, and next rank continues.

<br>

 So, the screenshot above shows the difference between `RANK()`(may skip numbers) and `DENSE_RANK()`(does not skip).
 
<br>
<br>
<br>

## 6. ✅ _Identifying Top 3 Records per Department_

  <br>
  
```sql
SELECT * FROM (
    SELECT 
        emp_id,
        emp_name,
        department,
        salary,
        RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rnk
    FROM employees
) 
WHERE rnk <= 3;

```

  <br>
  


![WhatsApp Image 2025-04-17 at 10 19 55 PM (2)](https://github.com/user-attachments/assets/a60f4f58-720e-4d18-85fa-498adc866c0f)


 <br>
  <br>
 ###### _Explanation:_
Retrieves the top 3 earners from each department.
<br>
<br>
<br>
## 7 .✅ _Finding the Earliest 2 Employees per Department_

  <br>
  
```sql
SELECT * FROM (
    SELECT 
        emp_id,
        emp_name,
        department,
        hire_date,
        ROW_NUMBER() OVER (PARTITION BY department ORDER BY hire_date ASC) AS row_num
    FROM employees
)
WHERE row_num <= 2;

```

  <br>
  
 ![WhatsApp Image 2025-04-17 at 10 19 55 PM (3)](https://github.com/user-attachments/assets/76f6aa99-4b82-43b9-8ec2-9c4398587ed9)



  <br>
  <br>
 ###### _Explanation:_
Uses `ROW_NUMBER()` to get the two earliest hires per department.
<br>
<br>
<br>
## 8. ✅ _Aggregation with Window Functions_

  <br>
  
```sql
SELECT 
    emp_id,
    emp_name,
    department,
    salary,
    MAX(salary) OVER (PARTITION BY department) AS max_salary_in_dept,
    MAX(salary) OVER () AS overall_max_salary
FROM employees;

```

  <br>
  

![WhatsApp Image 2025-04-17 at 10 19 56 PM (1)](https://github.com/user-attachments/assets/c1407d2e-c6da-4bcb-8b16-c44e266bd96d)


  <br>
  <br>
 ###### _Explanation:_
Shows the highest salary in each department and across the whole company.
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
 

<br>
<br>
<br>
<br>
<br>



