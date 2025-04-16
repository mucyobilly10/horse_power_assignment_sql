

-- 1.  CREATING TABLE.



--CREATING TABLE FOR THE DATASET EMPLOYEES.

CREATE TABLE employees (
    emp_id        NUMBER PRIMARY KEY,
    emp_name      VARCHAR2(50),
    department    VARCHAR2(30),
    salary        NUMBER(10,2),
    hire_date     DATE
);




desc employees;





-- 2. DATA INSERTION.


--INSERTING ATLEAST TEN RECORDS IN employees TABLE


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


select *from employees;





-- 3. QUERIES.

-- i. Compare Values with Previous or Next Records.


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





-- ii.  Ranking Data within a Category.


SELECT 
    emp_id,
    emp_name,
    department,
    salary,
    RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank_salary,
    DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dense_rank_salary
FROM employees;






-- iii. Identifying Top Records.


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







-- iv. Finding the Earliest Records 


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






-- v. Aggregation with Window Functions 


SELECT 
    emp_id,
    emp_name,
    department,
    salary,
    MAX(salary) OVER (PARTITION BY department) AS max_salary_in_dept,
    MAX(salary) OVER () AS overall_max_salary
FROM employees;




