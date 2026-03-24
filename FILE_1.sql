FILE 1

SELECT 
    p.Full_Name,
    e.Employee_Department
FROM 
    Person p
JOIN 
    Employee e
ON 
    p.IC_No = e.IC_No;
