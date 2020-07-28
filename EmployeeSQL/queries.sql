--drop tables--

--DATA ENGINEERING--
--create tables--
CREATE TABLE dept_emp (
    emp_no INTEGER NOT NULL,
    dept_no VARCHAR(30) NOT NULL 
);
CREATE TABLE dept_manager (
    dept_no VARCHAR(30) NOT NULL,
	emp_no INTEGER NOT NULL
);
CREATE TABLE departments (
    dept_name VARCHAR(30) NOT NULL,
    dept_no VARCHAR(30) NOT NULL
);
CREATE TABLE employees (
 	emp_no INTEGER NOT NULL,
	emp_title VARCHAR(30) NOT NULL,
	birth_date VARCHAR(30) NOT NULL,
	first_name VARCHAR(200) NOT NULL,
	last_name VARCHAR(200) NOT NULL,
	sex VARCHAR(10) NOT NULL,
	hire_date DATE NOT NULL
);
CREATE TABLE salaries (
    emp_no INTEGER NOT NULL,
    salary INTEGER NOT NULL
);
CREATE TABLE titles (
    title_id VARCHAR(200) NOT NULL,
    emp_title VARCHAR(200) NOT NULL
);

--Add FK to tables: dept_emp,

ALTER TABLE dept_emp ADD ID SERIAL, ADD PRIMARY KEY(ID)
;
ALTER TABLE dept_manager ADD ID SERIAL, ADD PRIMARY KEY(ID)
;
ALTER TABLE departments ADD PRIMARY KEY (dept_name)
;
ALTER TABLE departments ADD FOREIGN KEY (dept_no) REFERENCES dept_emp(dept_no)
;
ALTER TABLE employees ADD PRIMARY KEY (emp_no)
;
ALTER TABLE salaries ADD PRIMARY KEY (emp_no)
;
ALTER TABLE salaries ADD FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
;
ALTER TABLE titles ADD PRIMARY KEY (title_id)
;
--ALTER TABLE departments RENAME COLUMN dept_name TO dept_no1;
--ALTER TABLE departments RENAME COLUMN dept_no TO dept_name;
--ALTER TABLE departments RENAME COLUMN dept_no1 TO dept_no;
--Check that tables were made--
SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;

--DATA ANALYSIS--
--List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT employees.emp_no,employees.first_name, employees.last_name, employees.sex, salaries.salary
FROM employees
INNER JOIN salaries ON
employees.emp_no = salaries.emp_no
;

--List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date FROM employees
WHERE hire_date >= '1986-01-01' AND hire_date < '1987-01-01'
;

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT dept_manager.dept_no,  dept_manager.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_manager
INNER JOIN employees ON dept_manager.emp_no = employees.emp_no
INNER JOIN departments ON dept_manager.dept_no = departments.dept_no;

--List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT dept_emp.dept_no,  dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
INNER JOIN employees ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no;

--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'
;

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT dept_emp.dept_no,  dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp 
INNER JOIN employees ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE dept_name = 'Sales';

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT dept_emp.dept_no,  dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp 
INNER JOIN employees ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development';


--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(*)
FROM employees 
GROUP BY last_name
ORDER BY 2 DESC;