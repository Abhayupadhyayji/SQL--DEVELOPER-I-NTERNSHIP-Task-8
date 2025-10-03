

CREATE TABLE employees10 (
    emp_id SERIAL  PRIMARY KEY,
    emp_name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10,2)
);

-- Insert sample data
INSERT INTO employees10 (emp_name, department, salary) VALUES
('Alice', 'HR', 45000),
('Bob', 'IT', 60000),
('Charlie', 'Finance', 55000),
('David', 'IT', 75000),
('Eva', 'HR', 50000);

DELIMITER $$

CREATE PROCEDURE GetEmployeesByDept(IN dept_name VARCHAR(50))
BEGIN
    IF dept_name = 'ALL' THEN
        SELECT * FROM employees10;
    ELSE
        SELECT * FROM employees10 WHERE department = dept_name;
    END IF;
END$$

DELIMITER ;

CALL GetEmployeesByDept('IT');
CALL GetEmployeesByDept('ALL');


DELIMITER $$

CREATE FUNCTION CalculateBonus(sal DECIMAL(10,2)) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE bonus DECIMAL(10,2);

    IF sal > 70000 THEN
        SET bonus = sal * 0.15;
    ELSEIF sal BETWEEN 50000 AND 70000 THEN
        SET bonus = sal * 0.10;
    ELSE
        SET bonus = sal * 0.05;
    END IF;

    RETURN bonus;
END$$

DELIMITER ;

SELECT emp_name, salary, CalculateBonus(salary) AS Bonus 
FROM employees10;



