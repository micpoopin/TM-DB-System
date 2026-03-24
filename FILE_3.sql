-- Format the output
SET PAGESIZE 50
SET COLSEP '|'
SET LINESIZE 1000

SELECT
    e.Employee_Position,
    e.Employee_Department,
    lm.Leave_Type,
    lm.Personnel_Area,
    cm.Claim_Amount,
    cm.Claim_Status,
    nn.Node_Type,
    nn.Node_Status,
    l.Location_Name,
    l.Location_Type,
    a.Coupon_Rate,
    a.Maturity_Date  
FROM Employee e
JOIN Employee_LeaveManagement elm ON e.Employee_ID = elm.Employee_ID
JOIN LeaveManagement lm ON lm.Leave_Management_ID = elm.Leave_Management_ID
JOIN Employee_Claim ecm ON e.Employee_ID = ecm.Employee_ID
JOIN Claim cm ON cm.Claim_ID = ecm.Claim_ID
JOIN Employee_NetworkNode enn ON e.Employee_ID = enn.Employee_ID
JOIN Network_Node nn ON nn.Node_ID = enn.Node_ID
JOIN Location l ON l.Location_ID = nn.Location_ID
JOIN Employee_Agreement ea ON e.Employee_ID = ea.Employee_ID
JOIN Agreement a ON a.Agreement_ID = ea.Agreement_ID
WHERE
    cm.Claim_Status = 'Rejected'
    AND cm.Claim_Amount > 1500
    AND a.Coupon_Rate > 2;