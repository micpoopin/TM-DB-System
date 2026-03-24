SET PAGESIZE 100
SET LINESIZE 500

SELECT
    p.Full_Name,
    c.Customer_Status,
    sp.Package_Name,
    S.Subscription_Created_Date,
    inv.Amount_Due,
    cp.Complaint_Status,
    sr.Request_Status,
    cpg.Engagement_Rate
FROM Person p
JOIN Customer c ON p.IC_No = c.IC_No
JOIN Person_ServicePackage psp ON p.IC_No = psp.IC_No
JOIN ServicePackage sp ON psp.Service_Package_ID = sp.Service_Package_ID
JOIN ServicePackage_Invoice spinv ON sp.Service_Package_ID = spinv.Service_Package_ID
JOIN Invoice inv ON spinv.Invoice_ID = inv.Invoice_ID
JOIN ServicePackage_Subscription sps ON sp.Service_Package_ID = sps.Service_Package_ID
JOIN Subscription s ON sps.Subscription_ID =  s.Subscription_ID
JOIN ServicePackage_Complaint spcp ON sp.Service_Package_ID = spcp.Service_Package_ID
JOIN Complaint cp ON spcp.Complaint_ID = cp.Complaint_ID
JOIN Complaint_ServiceRequest cpsr ON cp.Complaint_ID = cpsr.Complaint_ID
JOIN ServiceRequest sr ON cpsr.Request_ID = sr.Request_ID
JOIN Campaign_ServicePackage cpgsp ON sp.Service_Package_ID = cpgsp.Service_Package_ID
JOIN Campaign cpg ON cpgsp.Campaign_ID = cpg.Campaign_ID
WHERE
    c.Customer_Status = 'Active'
    AND cp.Complaint_Status = 'Resolved'
    AND sr.Request_Status = 'Scheduled'
    AND inv.Amount_Due > 100    
ORDER BY c.Customer_Status DESC;