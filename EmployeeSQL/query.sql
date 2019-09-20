--1. List the following details of each employee: employee number, last name, first name, gender, and salary.

select emp_no , last_name, first_name, gender,
(select salary
from salaries
 where salaries.emp_no=employees.emp_no)
from employees 
limit 10;

--2. List employees who were hired in 1986.
SELECT * FROM employees
WHERE    hire_date >= '1986-01-01'
AND      hire_date <  '1987-01-01';

--alternate way
--SELECT * FROM employees
--WHERE    hire_date >= to_date('1986', 'YYYY');

--3. List the manager of each department with the following information: 
--department number,department name, the manager's employee number, last name, first name, and start and end employment dates.

select dept_no,
(
	select dept_name
	from departments
	where dept_manager.dept_no=departments.dept_no
) , emp_no,
(
	select last_name
	from employees
	where dept_manager.emp_no=employees.emp_no
),
(
	select first_name
	from employees
	where dept_manager.emp_no=employees.emp_no
),
(
	select from_date
	from dept_emp
	where dept_manager.emp_no=dept_emp.emp_no
),
(
	select to_date
	from dept_emp
	where dept_manager.emp_no=dept_emp.emp_no
)
from dept_manager ;

--4. List the department of each employee with the following information: 
--employee number, last name, first name, and department name.

select emp_no,
(
	select last_name
	from employees
	where dept_emp.emp_no=employees.emp_no
),
(
	select first_name
	from employees
	where dept_emp.emp_no=employees.emp_no
),
(
	select dept_name
	from departments
	where dept_emp.dept_no=departments.dept_no
)
from dept_emp limit 10;

--5.List all employees whose first name is "Hercules" and last names begin with "B."

select * from employees
where first_name='Hercules' and
last_name like'B%' ;

--6. List all employees in the Sales department, including their employee number, 
--last name, first name, and department name.

SELECT emp_no,  
(
	select last_name
	from employees
	where dept_emp.emp_no=employees.emp_no
),
(
	select first_name
	from employees
	where dept_emp.emp_no=employees.emp_no
),
(
	select dept_name
	from departments
	where dept_emp.dept_no=departments.dept_no
)
FROM dept_emp
WHERE dept_no IN
(
  SELECT dept_no
  FROM departments
  WHERE dept_name = 'Sales'
);

--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT emp_no,  
(
	select last_name
	from employees
	where dept_emp.emp_no=employees.emp_no
),
(
	select first_name
	from employees
	where dept_emp.emp_no=employees.emp_no
),
(
	select dept_name
	from departments
	where dept_emp.dept_no=departments.dept_no
) 
FROM dept_emp
WHERE dept_no IN
(
  SELECT dept_no
  FROM departments
  WHERE dept_name = 'Sales' or dept_name = 'Development'
);

--8. In descending order, list the frequency count of employee last names, i.e., 
--how many employees share each last name.

	select last_name,count(last_name)
	from employees 
	group by last_name
	order by count desc;


