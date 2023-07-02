	
CREATE TABLE departments (
	dept_no VARCHAR(8) NOT NULL PRIMARY KEY,
	dept_name VARCHAR(20) NOT NULL

);

CREATE TABLE titles(
	title_id VARCHAR(8) NOT NULL PRIMARY KEY,
	title VARCHAR(30) NOT NULL

);
	
CREATE TABLE employees(

	emp_no INTEGER NOT NULL PRIMARY KEY,
	emp_title VARCHAR(10) NOT NULL,
	FOREIGN KEY(emp_title) REFERENCES titles(title_id),
	birth_date VARCHAR NOT NULL,
	first_name VARCHAR (30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	gender VARCHAR(10) NOT NULL,
	hire_date VARCHAR NOT NULL
);

CREATE TABLE salaries(

	emp_no INTEGER NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	salary INTEGER NOT NULL
);
	
CREATE TABLE dept_manager(
	dept_no VARCHAR(8) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	emp_no INTEGER NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
	
);


CREATE TABLE dept_emp(
	emp_no INTEGER NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	dept_no VARCHAR(8) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
	
);

--List the employee number, last name, first name, sex, and salary of each employee
SELECT
e.emp_no,
e.last_name,
e.first_name,
e.gender,
s.salary
FROM employees as e
INNER JOIN salaries as s ON
e.emp_no = s.emp_no
ORDER BY e.emp_no ASC ;

-- List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT 
e.first_name,
e.last_name, 
e.hire_date
FROM employees as e
WHERE hire_date LIKE '%1986'
ORDER BY e.first_name ASC

--List the manager of each department along with their department number, department name, 
--employee number, last name, and first name.
SELECT d.dept_no, d.dept_name,d_m.emp_no, e.last_name, e.first_name
FROM departments as d 
INNER JOIN dept_manager as d_m ON
d.dept_no = d_m.dept_no
INNER JOIN employees as e ON
d_m.emp_no = e.emp_no
ORDER by d.dept_no ASC;

-- List the department number for each employee along with that
-- employee’s employee number, last name, first name, and department name.
SELECT
d_e.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees as e
INNER JOIN dept_emp as d_e ON 
e.emp_no = d_e.emp_no
INNER JOIN departments as d ON 
d_e.dept_no = d.dept_no 
ORDER BY d_e.dept_no ASC;


-- List first name, last name, and sex of each employee 
-- whose first name is Hercules and whose last name begins with the letter B.
SELECT e.first_name, e.last_name, e.gender 
FROM employees as e
WHERE e.first_name = 'Hercules' AND e.last_name LIKE 'B%'
;


-- List each employee in the Sales department,
-- including their employee number, last name, and first name.

SELECT e.emp_no, e.Last_name, e.first_name 
FROM employees as e 
INNER JOIN dept_emp ON
e.emp_no = dept_emp.emp_no
INNER JOIN departments ON
dept_emp.dept_no = departments.dept_no
WHERE departments.dept_no = 'd007'


-- List each employee in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees as e
INNER JOIN dept_emp ON
e.emp_no = dept_emp.emp_no
INNER JOIN departments as d ON
dept_emp.dept_no = d.dept_no
WHERE dept_emp.dept_no = 'd007' OR dept_emp.dept_no = 'd005'
ORDER BY dept_emp.dept_no DESC;

-- List the frequency counts, in descending order,
-- of all the employee last names (that is, how many employees share each last name).
SELECT e.last_name, COUNT(e.last_name)
FROM employees as e
GROUP BY e.last_name
ORDER BY e.last_name ASC





	