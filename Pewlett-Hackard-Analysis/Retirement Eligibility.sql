-- Finds first and last names of employees from the 'employees' table born between 1952 and 1955
SELECT first_name, last_name
FROM employees
WHERE birth_Date BETWEEN '1952-01-01' AND '1955-12-31';

-- Finds first and last names of employees from the 'employees' table born in 1952
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

-- Finds first and last names of employees from the 'employees' table born in 1953
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

-- Finds first and last names of employees from the 'employees' table born in 1954
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

-- Finds first and last names of employees from the 'employees' table born in 1955
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Retirement Eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Find count of retirement eligibility
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Create a new table with new found info for retirement eligibility
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')

-- See retirement_info table
SELECT * FROM retirement_info;

-- Drop retirement info to recreate in next step
DROP TABLE retirement_info;
-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Check the table
SELECT * FROM retirement_info;

-- Use inner join for departments and dept_manager tables
SELECT departments.dept_name,
	dept_manager.emp_no,
	dept_manager.from_date,
	dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
	retirement_info.first_name,
	retirement_info.last_name,
	dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

-- Joining retirement_info and dept_emp tables updated
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;

-- Inner join for departments and dept_manager tables updated
SELECT d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

-- Use left join for retirement_info and dept_emp tables
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = '9999-01-01';

-- Employee count by department number. Ordered by dept_no. New table created "department_emp_count"
SELECT COUNT (ce.emp_no), de.dept_no
INTO department_emp_count
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- List 1 - Employee Information
SELECT * FROM salaries
ORDER BY to_date DESC;

SELECT e.emp_no,
	e.first_name,
	e.last_name,
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees AS e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	AND (de.to_date = '9999-01-01');
	
-- List 2: Managers per department
SELECT dm.dept_no,
	d.dept_name,
	dm.emp_no,
	ce.last_name,
	ce.first_name,
	dm.from_date,
	dm.to_date
INTO manager_info
FROM dept_manager AS dm
	INNER JOIN departments AS d
		ON (dm.dept_no = d.dept_no)
	INNER JOIN current_emp AS ce
		ON (dm.emp_no = ce.emp_no);

-- List 3: Department Retirees
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO dept_info
FROM current_emp AS ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

-- SKILL DRILL. Query returning emp_no, emp_first_name, emp_last_name, emp_dept_name. Contains employees only in sales department.
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	d.dept_name
INTO Sales_Team
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE dept_name = 'Sales';

-- SKILL DRILL. Query returning emp_no, emp_first_name, emp_last_name, emp_dept_name. Employees in the SALES and DEVELOPMENT departments.
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	d.dept_name
INTO sales_dev_team
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE dept_name IN ('Sales', 'Development');