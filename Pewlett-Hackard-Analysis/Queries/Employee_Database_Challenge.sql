-- Deliverable 1
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees as e
JOIN titles as ti
	ON e.emp_no = ti.emp_no
WHERE birth_Date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no ASC;

-- Remove duplicates and keep only most recent title of each employee (Starter code provided here)
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM retirement_titles as rt
WHERE to_date = '9999-01-01'
ORDER BY rt.emp_no, to_date DESC;

-- Retrieve the number of employees by their most recent job title who are about to retire
SELECT COUNT("title") AS "Count", "title"
INTO retiring_titles
FROM unique_titles
GROUP BY "title"
ORDER BY COUNT("title") DESC;

-- Deliverable 2
-- Create a Mentorship Eligibility table holding employees
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibility
FROM employees AS e
JOIN dept_emp AS de
	ON e.emp_no = de.emp_no
JOIN titles AS ti
	ON e.emp_no = ti.emp_no
WHERE (de.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

-- Deliverable 3
-- Remove duplicates and keep only most recent title of each employee
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	ti.title,
	ti.to_date
INTO unique_employees
FROM employees AS e
JOIN titles AS ti
	ON e.emp_no = ti.emp_no
WHERE to_date = '9999-01-01'
	AND birth_date > '1955-12-31'
ORDER BY e.emp_no, to_date DESC;

-- Find number of employees, by title, not ready for retirement.
SELECT COUNT("title") AS "Count", "title"
INTO future_titles
FROM unique_employees
GROUP BY "title"
ORDER BY COUNT("title") DESC;

-- Find number of employees, by title, ready for retirement.
SELECT COUNT("title") AS "Count", "title"
INTO mentorship_count
FROM mentorship_eligibility
GROUP BY "title"
ORDER BY COUNT("title") DESC;