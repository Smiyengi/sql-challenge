--DROP TABLE departments;
--DROP TABLE dept_emp;
--DROP TABLE dept_manager;
--DROP TABLE employees;
--DROP TABLE salaries;
--DROP TABLE titles;

CREATE TABLE titles (
    title_id VARCHAR   NOT NULL,
    title VARCHAR   NOT NULL,
    PRIMARY KEY (title_id)
);

CREATE TABLE employees (
    emp_no INT   NOT NULL,
    emp_title_id VARCHAR NOT NULL,
    birth_date DATE   NOT NULL,
    first_name VARCHAR   NOT NULL,
    last_name VARCHAR   NOT NULL,
    sex VARCHAR   NOT NULL,
    hire_date DATE   NOT NULL,
    FOREIGN KEY (emp_title_id) REFERENCES titles (title_id),
    PRIMARY KEY (emp_no)
);

CREATE TABLE departments (
    dept_no VARCHAR   NOT NULL,
    dept_name VARCHAR   NOT NULL,
    PRIMARY KEY (dept_no)
);

CREATE TABLE dept_manager (
    dept_no VARCHAR   NOT NULL,
    emp_no INT   NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (dept_no, emp_no)
);

CREATE TABLE dept_emp (
    emp_no INT   NOT NULL,
    dept_no VARCHAR   NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE salaries (
    emp_no INT   NOT NULL,
    salary INT   NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no)
);

-- employee_no, last_name, first_name, sex, salaries
-- left join on columns emp_no in tables employees and salaries
SELECT  employees.emp_no,
        employees.last_name,
        employees.first_name,
        employees.sex,
        salaries.salary
FROM employees
    LEFT JOIN salaries
    ON (employees.emp_no = salaries.emp_no)
ORDER BY employees.emp_no;

-- employees hired in 1986
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'
ORDER BY hire_date ASC;



-- Department managers by dept_no, dept_name, emp_no, last_name, first_name
SELECT  dept_manager.dept_no,
        departments.dept_name,
        dept_manager.emp_no,
        employees.last_name,
        employees.first_name
FROM dept_manager
    INNER JOIN departments
        ON (dept_manager.dept_no = departments.dept_no)
    INNER JOIN employees
        ON (dept_manager.emp_no = employees.emp_no);
		
-- Employees whose first name is Hercules, last name begins with B, sex
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';


-- Employees from Sales department
SELECT  employees.emp_no,
        employees.last_name,
        employees.first_name,
        departments.dept_name
FROM employees 
    INNER JOIN dept_emp
        ON (employees.emp_no = dept_emp.emp_no)
    INNER JOIN departments
        ON (dept_emp.dept_no = departments.dept_no)
WHERE departments.dept_name = 'Sales'


-- Employees from Sales and Development departments
SELECT  employees.emp_no,
        employees.last_name,
        employees.first_name,
        departments.dept_name
FROM employees
    INNER JOIN dept_emp 
        ON (employees.emp_no = dept_emp.emp_no)
    INNER JOIN departments 
        ON (dept_emp.dept_no = departments.dept_no)
WHERE departments.dept_name IN ('Sales', 'Development')
ORDER BY employees.emp_no;


-- Count of last names
SELECT last_name, COUNT(last_name)
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;

