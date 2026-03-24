SELECT 
    s.Supplier_Name, 
    COUNT(DISTINCT pay.Payment_ID) AS Total_Payments
FROM 
    Supplier s
JOIN 
    Supplier_Product sp ON s.Supplier_ID = sp.Supplier_ID
JOIN 
    Product p ON sp.Product_ID = p.Product_ID
JOIN 
    Product_Invoice pi ON p.Product_ID = pi.Product_ID
JOIN 
    Invoice i ON pi.Invoice_ID = i.Invoice_ID
JOIN 
    Invoice_Payment ip ON i.Invoice_ID = ip.Invoice_ID
JOIN 
    Payment pay ON ip.Payment_ID = pay.Payment_ID
WHERE 
    i.Amount_Due > 0 AND 
    pay.Payment_Status = 'Completed'
GROUP BY 
    s.Supplier_Name;





