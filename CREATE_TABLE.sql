CREATE TABLE Person (
    IC_No           VARCHAR2(20) PRIMARY KEY,
    Full_Name       VARCHAR2(40),
    Birth_Date      DATE,
    Nationality     VARCHAR2(20),
    Contact_No      VARCHAR2(20),
    Email           VARCHAR2(40)
);

CREATE TABLE Customer (
    Customer_ID                VARCHAR2(20) UNIQUE,
    Customer_Username          VARCHAR2(20) UNIQUE,
    Customer_Property_Type     VARCHAR2(20),
    Customer_Income_Level      VARCHAR2(20),
    Customer_Account_Password  VARCHAR2(20),
    Customer_Registration_Date DATE,
    Customer_Status            VARCHAR2(20),
    Customer_Since_Year        VARCHAR2(10),
    Customer_Occupation        VARCHAR2(20),
    Customer_Marital_Status    VARCHAR2(10),
    IC_No             VARCHAR2(20),
    PRIMARY KEY (Customer_ID,Customer_Username),
    FOREIGN KEY (IC_No) REFERENCES Person(IC_No),
    CHECK (Customer_Status IN ('Active', 'Inactive', 'Suspended')),
    CHECK (Customer_Marital_Status IN ('Married', 'Single'))
);

CREATE TABLE Employee (
    Employee_ID           VARCHAR2(20) UNIQUE,
    Income_Tax_No         VARCHAR2(20) UNIQUE,
    Education_Level       VARCHAR2(20),
    Employee_Position     VARCHAR2(40),
    Employee_Department   VARCHAR2(20),
    Health_Issues         VARCHAR2(150),
    Hired_Date            DATE,
    Shift_Timing          VARCHAR2(20),
    Salary_Rate           VARCHAR2(10),
    Total_Salary          VARCHAR2(10),
    IC_No                 VARCHAR2(20),
    PRIMARY KEY (Employee_ID, Income_Tax_No), 
    FOREIGN KEY (IC_No) REFERENCES Person(IC_No)
);

CREATE TABLE LeaveManagement (
    Leave_Management_ID     VARCHAR2(20) UNIQUE,
    Leave_Management_Code   VARCHAR2(20) UNIQUE,
    Personnel_Area          VARCHAR2(20),
    Personnel_Sub_Area      VARCHAR2(20),
    Report_to_Name          VARCHAR2(40),
    Leave_Request           VARCHAR2(20),
    Leave_Type              VARCHAR2(20),
    Management_Start_Date   DATE,
    Management_End_Date     DATE,
    Approver_Name           VARCHAR2(40),
    PRIMARY KEY (Leave_Management_ID, Leave_Management_Code)
);

CREATE TABLE Supplier (
    Supplier_ID         VARCHAR2(20) UNIQUE,
    Supplier_SSM_No     VARCHAR2(20) UNIQUE,
    Supplier_Name       VARCHAR2(40),
    Owner_Name          VARCHAR2(20),
    Business_No         VARCHAR2(20),
    Business_Email      VARCHAR2(40),
    Supplies_Type       VARCHAR2(20),
    Delivery_Type       VARCHAR2(20),
    Open_Time           VARCHAR2(5),
    Close_Time          VARCHAR2(5),
    PRIMARY KEY (Supplier_ID, Supplier_SSM_No)
);

CREATE TABLE Agreement (
    Agreement_ID         VARCHAR2(20) UNIQUE,
    ISIN_Code            VARCHAR2(20) UNIQUE,
    Coupon_Rate          NUMBER(3,2),
    Maturity_Date        DATE,
    Principal            VARCHAR2(10),
    Programme            VARCHAR2(20),
    Agreement_Start_Date DATE,
    Collable             VARCHAR2(10),
    Guarantor            VARCHAR2(20),
    Agreement_Yield      NUMBER(3,2),
    Agreement_Rating     VARCHAR2(10),
    PRIMARY KEY (Agreement_ID, ISIN_Code),
    CHECK(Collable IN ('Yes', 'No')),
    CHECK(Agreement_Yield >= 0.00)
);

CREATE TABLE Subscription (
    Subscription_ID            VARCHAR2(20) UNIQUE,
    Subscription_Code          VARCHAR2(20) UNIQUE,
    Subscription_Created_Date  DATE,
    Total_Cost                 VARCHAR2(10),
    Service_Charged            VARCHAR2(10),
    Subscription_Status        VARCHAR2(20),
    Discount_Value             VARCHAR2(10),
    Modified_Date              DATE,
    Locked                     VARCHAR2(10),
    Subscription_Remarks       CLOB,
    PRIMARY KEY (Subscription_ID, Subscription_Code),
    CHECK(Subscription_Status IN ('Active', 'Inactive', 'Cancelled', 'Suspended')),
    CHECK(Locked IN ('Yes', 'No'))
);

CREATE TABLE FinancialPerformance (
    Financial_Performance_ID    VARCHAR2(20) UNIQUE,
    Financial_Performance_Code  VARCHAR2(20) UNIQUE,
    Revenue                     VARCHAR2(10),
    Performance_Year            NUMBER(4,0),
    EBIT                        VARCHAR2(10),
    EBITDA                      VARCHAR2(10),
    PATAMI                      VARCHAR2(10),
    Normalised_EBIT             VARCHAR2(10),
    Normalised_EBITDA           VARCHAR2(10),
    Normalised_PATAMI           VARCHAR2(10),
    Dividend_per_Share          VARCHAR2(10),
    Profit_Margin               VARCHAR2(10),
    PRIMARY KEY (Financial_Performance_ID, Financial_Performance_Code) 
);

CREATE TABLE Invoice (
    Invoice_ID                VARCHAR2(20) UNIQUE,
    Bill_No                   VARCHAR2(20) UNIQUE,
    Amount_Due                VARCHAR2(10),
    Amount_Including_Tax      VARCHAR2(10),
    Bill_Date                 DATE,
    Due_Date                  DATE,
    Service_Tax               VARCHAR2(10),
    Rounding_Amount           VARCHAR2(10),
    Amount_Excluding_Tax      VARCHAR2(10),
    Credit_Limit              VARCHAR2(10),
    Subscription_ID           VARCHAR2(20),
    Financial_Performance_ID  VARCHAR2(20),
    PRIMARY KEY (Invoice_ID, Bill_No),
    FOREIGN KEY (Subscription_ID) REFERENCES Subscription(Subscription_ID),
    FOREIGN KEY (Financial_Performance_ID) REFERENCES FinancialPerformance(Financial_Performance_ID)
);

CREATE TABLE Payment (
    Payment_ID                VARCHAR2(20) UNIQUE,
    Reference_Code            VARCHAR2(20) UNIQUE,
    Payment_Date              DATE,
    Amount_Paid               VARCHAR2(10),
    Payment_Method            VARCHAR2(20),
    Payment_Channel           VARCHAR2(20),
    Card_No                   VARCHAR2(20),
    Bank_Name                 VARCHAR2(40),
    Payment_Status            VARCHAR2(20),
    Payment_Type              VARCHAR2(20),
    Financial_Performance_ID  VARCHAR2(20),
    PRIMARY KEY (Payment_ID, Reference_Code),
    FOREIGN KEY (Financial_Performance_ID) REFERENCES FinancialPerformance(Financial_Performance_ID),
    CHECK(Payment_Status IN ('Pending', 'Completed', 'Rejected'))
);

CREATE TABLE Product (
    Product_ID      VARCHAR2(20),
    Product_Name    VARCHAR2(50),
    Product_Price   NUMBER(6,2),
    Warranty_Status VARCHAR2(20),
    PRIMARY KEY (Product_ID)
);

CREATE TABLE SIM_Card (
    SIM_ID               VARCHAR2(20) UNIQUE,
    ICC_ID               VARCHAR2(20) UNIQUE,
    Phone_No             VARCHAR2(20),
    Activation_Date      DATE,
    SIM_Status           VARCHAR2(20),
    PIN_No               VARCHAR2(10),
    PUK_No               VARCHAR2(10),
    SIM_Type             VARCHAR2(20),
    Carrier_Lock_Status  VARCHAR2(10),
    Batch_No             VARCHAR2(20),
    Product_ID           VARCHAR2(20),
    PRIMARY KEY (SIM_ID, ICC_ID),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    CHECK(Carrier_Lock_Status IN ('Locked', 'Unlocked'))
);

CREATE TABLE Router (
    Router_ID          VARCHAR2(20) UNIQUE,
    MAC_No             VARCHAR2(20) UNIQUE,
    Router_Type        VARCHAR2(20),
    Network_Type       VARCHAR2(20),
    Hardware_Version   VARCHAR2(20),
    WiFi_Bands         VARCHAR2(20),
    LAN_Port_Count     NUMBER(6, 0),
    WAN_Port_Count     NUMBER(6, 0),
    SIM_Slot           VARCHAR2(10),
    Reset_Count        NUMBER(6, 0),
    Product_ID         VARCHAR2(20),
    PRIMARY KEY (Router_ID, MAC_No),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    CHECK(SIM_Slot IN ('Yes', 'No'))
);

CREATE TABLE Campaign (
    Campaign_ID           VARCHAR2(20) UNIQUE,  
    Campaign_Code         VARCHAR2(20) UNIQUE,
    Campaign_Name         VARCHAR2(40),
    Campaign_Type         VARCHAR2(20),
    Campaign_Start_Date   DATE,
    Campaign_End_Date     DATE,
    Target_Audience       VARCHAR2(20),
    Campaign_Description  VARCHAR2(150),
    Engagement_Rate       NUMBER(5,2),
    Campaign_Status       VARCHAR2(20),
    PRIMARY KEY (Campaign_ID, Campaign_Code),
    CHECK(Campaign_Status IN ('Active', 'Completed', 'Planned', 'Ended'))
);

CREATE TABLE ServicePackage (
    Service_Package_ID          VARCHAR2(20) UNIQUE,
    Service_Package_Code        VARCHAR2(20) UNIQUE,
    Package_Name                VARCHAR2(50),
    Service_Package_Type        VARCHAR2(20),
    Upload_Speed                VARCHAR2(10),
    Download_Speed              VARCHAR2(10),
    Package_Monthly_Fee         VARCHAR2(10),
    Installation_Cost           VARCHAR2(10),
    Service_24h_Availability    VARCHAR2(10),
    Coverage_Area               VARCHAR2(100),
    PRIMARY KEY (Service_Package_ID, Service_Package_Code),
    CHECK(Service_24h_Availability IN ('Yes', 'No'))
);

CREATE TABLE MobilePlan (
    Plan_ID              VARCHAR2(20) UNIQUE,
    Plan_Code            VARCHAR2(20) UNIQUE,
    Plan_Name            VARCHAR2(100),
    Mobile_Monthly_Fee   VARCHAR2(10),
    Data_Quota           VARCHAR2(10),
    Call_Charge          VARCHAR2(10),
    SMS_Charge           VARCHAR2(10),
    Roaming_Status       VARCHAR2(10),
    Capped_Data_Speed    VARCHAR2(10),
    Access_5G            VARCHAR2(10),
    PRIMARY KEY (Plan_ID, Plan_Code),
    CHECK(Roaming_Status IN ('Yes', 'No')),
    CHECK(Access_5G IN ('Yes', 'No'))
);

CREATE TABLE Complaint (
    Complaint_ID            VARCHAR2(20) UNIQUE,
    Complaint_Code          VARCHAR2(20) UNIQUE,
    Complaint_Type          VARCHAR2(40),
    Complaint_Description   VARCHAR2(150),
    Complaint_Status        VARCHAR2(20),
    Resolution_Date         DATE,
    Assigned_Department     VARCHAR2(20),
    Response_Time           VARCHAR2(20),
    Customer_Feedback       VARCHAR2(150),
    Escalation_Status       VARCHAR2(20),
    PRIMARY KEY (Complaint_ID, Complaint_Code),
    CHECK (Complaint_Status IN ('Unresolved', 'Resolved'))
);

CREATE TABLE ServiceRequest (
    Request_ID             VARCHAR2(20) UNIQUE,
    Request_Code           VARCHAR2(20) UNIQUE,
    Request_Type           VARCHAR2(40),
    Data_Requested         VARCHAR2(150),
    Schedule_Date          DATE,
    Assigned_Technician    VARCHAR2(40),
    Request_Status         VARCHAR2(20),
    Request_Priority       VARCHAR2(20),
    Request_Location       VARCHAR2(150),
    Request_Detail         VARCHAR2(150),
    PRIMARY KEY (Request_ID, Request_Code)
);

CREATE TABLE Location (
    Location_ID         VARCHAR2(20) UNIQUE,
    Location_Code       VARCHAR2(20) UNIQUE,
    Location_Name       VARCHAR2(60),
    Location_Type       VARCHAR2(20),
    Latitude            NUMBER(10,6),
    Longitude           NUMBER(10,6),
    Coverage_Radius     NUMBER(5,2),
    Street              VARCHAR2(150),
    City                VARCHAR2(20),
    State               VARCHAR2(20),
    Location_Status     VARCHAR2(20),
    PRIMARY KEY (Location_ID, Location_Code)
);

CREATE TABLE Network_Node (
    Node_ID                VARCHAR2(20) UNIQUE,
    Node_Code              VARCHAR2(20) UNIQUE,
    Node_Type              VARCHAR2(20),
    Installation_Date      DATE,
    Node_Status            VARCHAR2(10),
    Last_Inspection_Date   DATE,
    Node_Capacity          NUMBER(6,0),
    Service_Area           VARCHAR2(40),
    Provider               VARCHAR2(40),
    Firmware_Version       VARCHAR2(20),
    IP_Address             VARCHAR2(20),
    Location_ID            VARCHAR2(20),
    PRIMARY KEY (Node_ID, Node_Code),
    FOREIGN KEY (Location_ID) REFERENCES Location (Location_ID),
    CHECK(Node_Status IN ('Active', 'Inactive'))
);

CREATE TABLE Claim (
    Claim_ID          VARCHAR2(20) PRIMARY KEY,
    Approver_Name     VARCHAR2(60),
    Claim_Amount      VARCHAR2(10),
    Reference_No      VARCHAR2(10),
    Claim_Status      VARCHAR2(20),
    CHECK(Claim_Status IN ('Pending', 'Approved', 'Rejected'))
);

CREATE TABLE Miscellaneous_Claim (
    Misc_Claim_ID           VARCHAR2(20) UNIQUE,
    Misc_Claim_Code         VARCHAR2(20) UNIQUE,
    Justification_Type      VARCHAR2(20),
    Expense_Category        VARCHAR2(20),
    Sub_Category            VARCHAR2(20),
    Device_Damage_Type      VARCHAR2(20),
    Claim_Reasons           VARCHAR2(150),
    Supporting_Documents    VARCHAR2(150),
    Tax_Amount              VARCHAR2(10),
    Claim_Risk_Level        VARCHAR2(20),
    Claim_ID                VARCHAR2(20),
    PRIMARY KEY (Misc_Claim_ID, Misc_Claim_Code), 
    FOREIGN KEY (Claim_ID) REFERENCES Claim(Claim_ID)
);

CREATE TABLE Travel_Claim (
    Travel_Claim_ID           VARCHAR2(20) UNIQUE,
    Travel_Claim_Code         VARCHAR2(20) UNIQUE,
    Travelling_Date           DATE,
    Travelling_Purpose        VARCHAR2(150),
    Advance_Type              VARCHAR2(20),
    Destination               VARCHAR2(150),
    Transportation_Mode       VARCHAR2(20),
    Travel_Claim_Description  VARCHAR2(150),
    Estimated_Cost            VARCHAR2(10),
    Trip_Category             VARCHAR2(20),
    Claim_ID                  VARCHAR2(20),
    PRIMARY KEY (Travel_Claim_ID, Travel_Claim_Code),
    FOREIGN KEY (Claim_ID) REFERENCES Claim(Claim_ID)
);

CREATE TABLE Person_Campaign (
    IC_No	                  VARCHAR2(20),
    Campaign_ID	                  VARCHAR2(20),
    Campaign_Code	          VARCHAR2(20),
    PRIMARY KEY (IC_No, Campaign_ID, Campaign_Code),
    FOREIGN KEY (IC_No) REFERENCES Person(IC_No),
    FOREIGN KEY (Campaign_ID) REFERENCES Campaign(Campaign_ID),
    FOREIGN KEY (Campaign_Code) REFERENCES Campaign(Campaign_Code)
);

CREATE TABLE Person_ServicePackage (
    IC_No	                  VARCHAR2(20), 
    Service_Package_ID		  VARCHAR2(20),
    Service_Package_Code	          VARCHAR2(20),
    PRIMARY KEY (IC_No, Service_Package_ID, Service_Package_Code),
    FOREIGN KEY (IC_No) REFERENCES Person(IC_No),
    FOREIGN KEY (Service_Package_ID) REFERENCES ServicePackage(Service_Package_ID),
    FOREIGN KEY (Service_Package_Code) REFERENCES ServicePackage(Service_Package_Code)
);

CREATE TABLE Person_Product (
    IC_No	                  VARCHAR2(20),
    Product_ID		          VARCHAR2(20),
    PRIMARY KEY (IC_No, Product_ID),
    FOREIGN KEY (IC_No) REFERENCES Person(IC_No),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

CREATE TABLE Person_Complaint (
    IC_No	                  VARCHAR2(20),
    Complaint_ID	          VARCHAR2(20),
    Complaint_Code	          VARCHAR2(20), 
    PRIMARY KEY (IC_No, Complaint_ID, Complaint_Code),
    FOREIGN KEY (IC_No) REFERENCES Person(IC_No),
    FOREIGN KEY (Complaint_ID) REFERENCES Complaint(Complaint_ID),
    FOREIGN KEY (Complaint_Code) REFERENCES Complaint(Complaint_Code)
); 

CREATE TABLE Person_ServiceRequest (
    IC_No	                  VARCHAR2(20),
    Request_ID	                  VARCHAR2(20),
    Request_Code	          VARCHAR2(20),
    PRIMARY KEY (IC_No, Request_ID, Request_Code),
    FOREIGN KEY (IC_No) REFERENCES Person(IC_No),
    FOREIGN KEY (Request_ID) REFERENCES ServiceRequest(Request_ID),
    FOREIGN KEY (Request_Code) REFERENCES ServiceRequest(Request_Code)
);

CREATE TABLE Person_Location (
    IC_No	                  VARCHAR2(20),
    Location_ID	                  VARCHAR2(20),
    Location_Code	          VARCHAR2(20), 
    PRIMARY KEY (IC_No, Location_ID, Location_Code),
    FOREIGN KEY (IC_No) REFERENCES Person(IC_No),
    FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID),
    FOREIGN KEY (Location_Code) REFERENCES Location(Location_Code)
);

CREATE TABLE Person_Subscription (
    IC_No	                  VARCHAR2(20),
    Subscription_ID	          VARCHAR2(20),
    Subscription_Code	          VARCHAR2(20), 
    PRIMARY KEY (IC_No, Subscription_ID, Subscription_Code),
    FOREIGN KEY (IC_No) REFERENCES Person(IC_No),
    FOREIGN KEY (Subscription_ID) REFERENCES Subscription(Subscription_ID),
    FOREIGN KEY (Subscription_Code) REFERENCES Subscription(Subscription_Code)
); 

CREATE TABLE Person_MobilePlan (
    IC_No	                  VARCHAR2(20),
    Plan_ID	                  VARCHAR2(20),
    Plan_Code	                  VARCHAR2(20),
    PRIMARY KEY (IC_No, Plan_ID, Plan_Code),
    FOREIGN KEY (IC_No) REFERENCES Person(IC_No),
    FOREIGN KEY (Plan_ID) REFERENCES MobilePlan(Plan_ID),
    FOREIGN KEY (Plan_Code) REFERENCES MobilePlan(Plan_Code) 
); 

CREATE TABLE Person_Invoice (
    IC_No	                  VARCHAR2(20),
    Invoice_ID	                  VARCHAR2(20),
    Bill_No	                  VARCHAR2(20), 
    PRIMARY KEY (IC_No, Invoice_ID, Bill_No),
    FOREIGN KEY (IC_No) REFERENCES Person(IC_No),
    FOREIGN KEY (Invoice_ID) REFERENCES Invoice(Invoice_ID),
    FOREIGN KEY (Bill_No) REFERENCES Invoice(Bill_No)
);

CREATE TABLE Person_Payment (
    IC_No	                  VARCHAR2(20),
    Payment_ID	                  VARCHAR2(20),
    Reference_Code	          VARCHAR2(20), 
    PRIMARY KEY (IC_No, Payment_ID, Reference_Code),
    FOREIGN KEY (IC_No) REFERENCES Person(IC_No),
    FOREIGN KEY (Payment_ID) REFERENCES Payment(Payment_ID),
    FOREIGN KEY (Reference_Code) REFERENCES Payment(Reference_Code)
);

CREATE TABLE Customer_Employee (
    Customer_ID	                  VARCHAR2(20),
    Customer_Username	          VARCHAR2(20),	
    Employee_ID	                  VARCHAR2(20),
    Income_Tax_No	          VARCHAR2(20), 
    PRIMARY KEY (Customer_ID, Employee_ID, Income_Tax_No),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Customer_Username) REFERENCES Customer(Customer_Username),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID),
    FOREIGN KEY (Income_Tax_No) REFERENCES Employee(Income_Tax_No)
);

CREATE TABLE Customer_MiscellaneousClaim (
    Customer_ID	                  VARCHAR2(20),
    Customer_Username	          VARCHAR2(20),
    Misc_Claim_ID	          VARCHAR2(20),
    Misc_Claim_Code	          VARCHAR2(20), 
    PRIMARY KEY (Customer_ID, Misc_Claim_ID, Misc_Claim_Code),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Customer_Username) REFERENCES Customer(Customer_Username), 
    FOREIGN KEY (Misc_Claim_ID) REFERENCES Miscellaneous_Claim(Misc_Claim_ID),
    FOREIGN KEY (Misc_Claim_Code) REFERENCES Miscellaneous_Claim(Misc_Claim_Code)
);

CREATE TABLE Employee_LeaveManagement (
    Employee_ID	                  VARCHAR2(20),
    Income_Tax_No	          VARCHAR2(20),
    Leave_Management_ID	          VARCHAR2(20),
    Leave_Management_Code	  VARCHAR2(20), 
    PRIMARY KEY (Employee_ID, Income_Tax_No, Leave_Management_ID, Leave_Management_Code),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID),
    FOREIGN KEY (Income_Tax_No) REFERENCES Employee(Income_Tax_No),
    FOREIGN KEY (Leave_Management_ID) REFERENCES LeaveManagement(Leave_Management_ID),
    FOREIGN KEY (Leave_Management_Code) REFERENCES LeaveManagement(Leave_Management_Code)
);

CREATE TABLE Employee_Employee (
    Employee_ID1	                  VARCHAR2(20),
    Income_Tax_No1	          VARCHAR2(20), 
    Employee_ID2	                  VARCHAR2(20),
    Income_Tax_No2	          VARCHAR2(20),
    PRIMARY KEY (Employee_ID1, Income_Tax_No1,Employee_ID2, Income_Tax_No2),
    FOREIGN KEY (Employee_ID1, Income_Tax_No1) REFERENCES Employee(Employee_ID, Income_Tax_No),
    FOREIGN KEY (Employee_ID2, Income_Tax_No2) REFERENCES Employee(Employee_ID, Income_Tax_No)
); 

CREATE TABLE Employee_Supplier (
    Employee_ID	                  VARCHAR2(20),
    Income_Tax_No	          VARCHAR2(20),
    Supplier_ID	                  VARCHAR2(20),
    Supplier_SSM_No	          VARCHAR2(20),
    PRIMARY KEY (Employee_ID, Income_Tax_No, Supplier_ID, Supplier_SSM_No),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID),
    FOREIGN KEY (Income_Tax_No) REFERENCES Employee(Income_Tax_No),
    FOREIGN KEY (Supplier_ID) REFERENCES Supplier(Supplier_ID),
    FOREIGN KEY (Supplier_SSM_No) REFERENCES Supplier(Supplier_SSM_No)
);

CREATE TABLE Employee_Agreement (
    Employee_ID	                  VARCHAR2(20),
    Income_Tax_No	          VARCHAR2(20),
    Agreement_ID	          VARCHAR2(20),
    ISIN_Code	                  VARCHAR2(20), 
    PRIMARY KEY (Employee_ID, Income_Tax_No, Agreement_ID, ISIN_Code),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID),
    FOREIGN KEY (Income_Tax_No) REFERENCES Employee(Income_Tax_No),
    FOREIGN KEY (Agreement_ID) REFERENCES Agreement(Agreement_ID),
    FOREIGN KEY (ISIN_Code) REFERENCES Agreement(ISIN_Code)  
);

CREATE TABLE Employee_Claim (
    Employee_ID	                  VARCHAR2(20),
    Income_Tax_No	          VARCHAR2(20),
    Claim_ID	                  VARCHAR2(20),
    PRIMARY KEY (Employee_ID, Income_Tax_No, Claim_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID),
    FOREIGN KEY (Income_Tax_No) REFERENCES Employee(Income_Tax_No),
    FOREIGN KEY (Claim_ID) REFERENCES Claim(Claim_ID)  
);

CREATE TABLE Employee_FinancialPerformance (
    Employee_ID	                  VARCHAR2(20),
    Income_Tax_No	          VARCHAR2(20),
    Financial_Performance_ID	  VARCHAR2(20),
    Financial_Performance_Code	  VARCHAR2(30),
    PRIMARY KEY (Employee_ID, Income_Tax_No, Financial_Performance_ID, Financial_Performance_Code),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID),
    FOREIGN KEY (Income_Tax_No) REFERENCES Employee(Income_Tax_No),
    FOREIGN KEY (Financial_Performance_ID) REFERENCES FinancialPerformance(Financial_Performance_ID),
    FOREIGN KEY (Financial_Performance_Code) REFERENCES FinancialPerformance(Financial_Performance_Code)  
);

CREATE TABLE Employee_NetworkNode (
    Employee_ID	                  VARCHAR2(20),
    Income_Tax_No	          VARCHAR2(20),
    Node_ID	                  VARCHAR2(20),
    Node_Code	                  VARCHAR2(20),
    PRIMARY KEY (Employee_ID, Income_Tax_No, Node_ID, Node_Code),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID),
    FOREIGN KEY (Income_Tax_No) REFERENCES Employee(Income_Tax_No),
    FOREIGN KEY (Node_ID) REFERENCES Network_Node(Node_ID),
    FOREIGN KEY (Node_Code) REFERENCES Network_Node(Node_Code)  
);

CREATE TABLE Supplier_Agreement (
    Supplier_ID	                  VARCHAR2(20),
    Supplier_SSM_No	          VARCHAR2(20),
    Agreement_ID	          VARCHAR2(20),
    ISIN_Code	                  VARCHAR2(20), 
    PRIMARY KEY (Supplier_ID, Supplier_SSM_No, Agreement_ID, ISIN_Code),
    FOREIGN KEY (Supplier_ID) REFERENCES Supplier(Supplier_ID),
    FOREIGN KEY (Supplier_SSM_No) REFERENCES Supplier(Supplier_SSM_No),
    FOREIGN KEY (Agreement_ID) REFERENCES Agreement(Agreement_ID),
    FOREIGN KEY (ISIN_Code) REFERENCES Agreement(ISIN_Code)  
);

CREATE TABLE Supplier_Invoice (
    Supplier_ID	                  VARCHAR2(20),
    Supplier_SSM_No	          VARCHAR2(20),
    Invoice_ID	                  VARCHAR2(20),
    Bill_No	                  VARCHAR2(20),
    PRIMARY KEY (Supplier_ID, Supplier_SSM_No, Invoice_ID, Bill_No),
    FOREIGN KEY (Supplier_ID) REFERENCES Supplier(Supplier_ID),
    FOREIGN KEY (Supplier_SSM_No) REFERENCES Supplier(Supplier_SSM_No),
    FOREIGN KEY (Invoice_ID) REFERENCES Invoice(Invoice_ID),
    FOREIGN KEY (Bill_No) REFERENCES Invoice(Bill_No)  
); 

CREATE TABLE Supplier_Payment (
    Supplier_ID	                  VARCHAR2(20),
    Supplier_SSM_No	          VARCHAR2(20),
    Payment_ID	                  VARCHAR2(20),
    Reference_Code	          VARCHAR2(20),
    PRIMARY KEY (Supplier_ID, Supplier_SSM_No, Payment_ID, Reference_Code),
    FOREIGN KEY (Supplier_ID) REFERENCES Supplier(Supplier_ID),
    FOREIGN KEY (Supplier_SSM_No) REFERENCES Supplier(Supplier_SSM_No),
    FOREIGN KEY (Payment_ID) REFERENCES Payment(Payment_ID),
    FOREIGN KEY (Reference_Code) REFERENCES Payment(Reference_Code)  
);

CREATE TABLE Supplier_Product (
    Supplier_ID	                  VARCHAR2(20),
    Supplier_SSM_No	          VARCHAR2(20),
    Product_ID	                  VARCHAR2(20),
    PRIMARY KEY (Supplier_ID, Supplier_SSM_No, Product_ID),
    FOREIGN KEY (Supplier_ID) REFERENCES Supplier(Supplier_ID),
    FOREIGN KEY (Supplier_SSM_No) REFERENCES Supplier(Supplier_SSM_No),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

CREATE TABLE Location_Complaint (
    Location_ID	                  VARCHAR2(20),
    Location_Code	          VARCHAR2(20),
    Complaint_ID	          VARCHAR2(20),
    Complaint_Code	          VARCHAR2(20),
    PRIMARY KEY (Location_ID, Location_Code, Complaint_ID, Complaint_Code),
    FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID),
    FOREIGN KEY (Location_Code) REFERENCES Location(Location_Code),
    FOREIGN KEY (Complaint_ID) REFERENCES Complaint(Complaint_ID),
    FOREIGN KEY (Complaint_Code) REFERENCES Complaint(Complaint_Code)
);

CREATE TABLE Location_ServiceRequest (
    Location_ID	                  VARCHAR2(20),
    Location_Code	          VARCHAR2(20),
    Request_ID	                  VARCHAR2(20),
    Request_Code	          VARCHAR2(20),
    PRIMARY KEY (Location_ID, Location_Code, Request_ID, Request_Code),
    FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID),
    FOREIGN KEY (Location_Code) REFERENCES Location(Location_Code),
    FOREIGN KEY (Request_ID) REFERENCES ServiceRequest(Request_ID),
    FOREIGN KEY (Request_Code) REFERENCES ServiceRequest(Request_Code)  
); 

CREATE TABLE SIMCard_MobilePlan (
    SIM_ID	                  VARCHAR2(20),
    ICC_ID	                  VARCHAR2(20),
    Plan_ID	                  VARCHAR2(20),
    Plan_Code	                  VARCHAR2(50),
    PRIMARY KEY (SIM_ID, ICC_ID, Plan_ID, Plan_Code),
    FOREIGN KEY (SIM_ID) REFERENCES SIM_Card(SIM_ID),
    FOREIGN KEY (ICC_ID) REFERENCES SIM_Card(ICC_ID),
    FOREIGN KEY (Plan_ID) REFERENCES MobilePlan(Plan_ID),
    FOREIGN KEY (Plan_Code) REFERENCES MobilePlan(Plan_Code) 
);

CREATE TABLE Product_Subscription (
    Product_ID	                  VARCHAR2(20),
    Subscription_ID	          VARCHAR2(20),
    Subscription_Code	          VARCHAR2(20),
    PRIMARY KEY (Product_ID, Subscription_ID, Subscription_Code),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    FOREIGN KEY (Subscription_ID) REFERENCES Subscription(Subscription_ID),
    FOREIGN KEY (Subscription_Code) REFERENCES Subscription(Subscription_Code) 
);

CREATE TABLE Product_Invoice (
    Product_ID	                  VARCHAR2(20),
    Invoice_ID	                  VARCHAR2(20),
    Bill_No	                  VARCHAR2(20),
    PRIMARY KEY (Product_ID, Invoice_ID, Bill_No),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    FOREIGN KEY (Invoice_ID) REFERENCES Invoice(Invoice_ID),
    FOREIGN KEY (Bill_No) REFERENCES Invoice(Bill_No)
);

CREATE TABLE Product_Payment (
    Product_ID	                  VARCHAR2(20),
    Payment_ID	                  VARCHAR2(20),
    Reference_Code	          VARCHAR2(20),
    PRIMARY KEY (Product_ID, Payment_ID, Reference_Code),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    FOREIGN KEY (Payment_ID) REFERENCES Payment(Payment_ID), 
    FOREIGN KEY (Reference_Code) REFERENCES Payment(Reference_Code)
);

CREATE TABLE Product_Complaint (
    Product_ID	                  VARCHAR2(20),
    Complaint_ID	          VARCHAR2(20),
    Complaint_Code	          VARCHAR2(20),
    PRIMARY KEY (Product_ID, Complaint_ID, Complaint_Code),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    FOREIGN KEY (Complaint_ID) REFERENCES Complaint(Complaint_ID), 
    FOREIGN KEY (Complaint_Code) REFERENCES Complaint(Complaint_Code) 
);

CREATE TABLE Product_ServiceRequest (
    Product_ID	                  VARCHAR2(20),
    Request_ID	                  VARCHAR2(20),
    Request_Code	          VARCHAR2(20),
    PRIMARY KEY (Product_ID, Request_ID, Request_Code),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    FOREIGN KEY (Request_ID) REFERENCES ServiceRequest(Request_ID),
    FOREIGN KEY (Request_Code) REFERENCES ServiceRequest(Request_Code)
);

CREATE TABLE Product_MiscellaneousClaim (
    Product_ID	                  VARCHAR2(20),
    Misc_Claim_ID	          VARCHAR2(20),
    Misc_Claim_Code	          VARCHAR2(20),
    PRIMARY KEY (Product_ID, Misc_Claim_ID, Misc_Claim_Code),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    FOREIGN KEY (Misc_Claim_ID) REFERENCES Miscellaneous_Claim(Misc_Claim_ID),
    FOREIGN KEY (Misc_Claim_Code) REFERENCES Miscellaneous_Claim(Misc_Claim_Code) 
);

CREATE TABLE Product_FinancialPerformance (
    Product_ID	                  VARCHAR2(20),
    Financial_Performance_ID	  VARCHAR2(20),
    Financial_Performance_Code	  VARCHAR2(20),
    PRIMARY KEY (Product_ID, Financial_Performance_ID, Financial_Performance_Code),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    FOREIGN KEY (Financial_Performance_ID) REFERENCES FinancialPerformance(Financial_Performance_ID),
    FOREIGN KEY (Financial_Performance_Code) REFERENCES FinancialPerformance(Financial_Performance_Code)  
);

CREATE TABLE Product_ServicePackage (
    Product_ID	                  VARCHAR2(20),
    Service_Package_ID	          VARCHAR2(20),
    Service_Package_Code	  VARCHAR2(20),
    PRIMARY KEY (Product_ID, Service_Package_ID, Service_Package_Code),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    FOREIGN KEY (Service_Package_ID) REFERENCES ServicePackage(Service_Package_ID),
    FOREIGN KEY (Service_Package_Code) REFERENCES ServicePackage(Service_Package_Code) 
);

CREATE TABLE Subscription_Payment (
    Subscription_ID	          VARCHAR2(20),
    Subscription_Code	          VARCHAR2(20),
    Payment_ID	                  VARCHAR2(20),
    Reference_Code	          VARCHAR2(20),
    PRIMARY KEY (Subscription_ID, Subscription_Code, Payment_ID, Reference_Code),
    FOREIGN KEY (Subscription_ID) REFERENCES Subscription(Subscription_ID), 
    FOREIGN KEY (Subscription_Code) REFERENCES Subscription(Subscription_Code),  
    FOREIGN KEY (Payment_ID) REFERENCES Payment(Payment_ID),
    FOREIGN KEY (Reference_Code) REFERENCES Payment(Reference_Code) 
);

CREATE TABLE Invoice_Payment (
    Invoice_ID	                  VARCHAR2(20),
    Bill_No	          VARCHAR2(20),
    Payment_ID	                  VARCHAR2(20),
    Reference_Code	          VARCHAR2(20),
    PRIMARY KEY (Invoice_ID, Bill_No, Payment_ID, Reference_Code),
    FOREIGN KEY (Invoice_ID) REFERENCES Invoice(Invoice_ID),
    FOREIGN KEY (Bill_No) REFERENCES Invoice(Bill_No),
    FOREIGN KEY (Payment_ID) REFERENCES Payment(Payment_ID),
    FOREIGN KEY (Reference_Code) REFERENCES Payment(Reference_Code)      
);

CREATE TABLE ServicePackage_Subscription (
    Service_Package_ID	          VARCHAR2(20),
    Service_Package_Code	  VARCHAR2(20),
    Subscription_ID	          VARCHAR2(20),
    Subscription_Code	          VARCHAR2(20),
    PRIMARY KEY (Service_Package_ID, Service_Package_Code, Subscription_ID, Subscription_Code),
    FOREIGN KEY (Service_Package_ID) REFERENCES ServicePackage(Service_Package_ID),
    FOREIGN KEY (Service_Package_Code) REFERENCES ServicePackage(Service_Package_Code),
    FOREIGN KEY (Subscription_ID) REFERENCES Subscription(Subscription_ID), 
    FOREIGN KEY (Subscription_Code) REFERENCES Subscription(Subscription_Code)  
);

CREATE TABLE ServicePackage_Invoice (
    Service_Package_ID	          VARCHAR2(20),
    Service_Package_Code	  VARCHAR2(20),
    Invoice_ID	                  VARCHAR2(20),
    Bill_No	                  VARCHAR2(20),
    PRIMARY KEY (Service_Package_ID, Service_Package_Code, Invoice_ID, Bill_No),
    FOREIGN KEY (Service_Package_ID) REFERENCES ServicePackage(Service_Package_ID),
    FOREIGN KEY (Service_Package_Code) REFERENCES ServicePackage(Service_Package_Code),
    FOREIGN KEY (Invoice_ID) REFERENCES Invoice(Invoice_ID),
    FOREIGN KEY (Bill_No) REFERENCES Invoice(Bill_No)   
);

CREATE TABLE ServicePackage_Payment (
    Service_Package_ID	          VARCHAR2(20),
    Service_Package_Code	  VARCHAR2(20),
    Payment_ID	                  VARCHAR2(20),
    Reference_Code	          VARCHAR2(20),
    PRIMARY KEY (Service_Package_ID, Service_Package_Code, Payment_ID, Reference_Code),
    FOREIGN KEY (Service_Package_ID) REFERENCES ServicePackage(Service_Package_ID),
    FOREIGN KEY (Service_Package_Code) REFERENCES ServicePackage(Service_Package_Code),
    FOREIGN KEY (Payment_ID) REFERENCES Payment(Payment_ID),
    FOREIGN KEY (Reference_Code) REFERENCES Payment(Reference_Code)
);

CREATE TABLE ServicePackage_Complaint (
    Service_Package_ID	          VARCHAR2(20),
    Service_Package_Code	  VARCHAR2(20),
    Complaint_ID	          VARCHAR2(20),
    Complaint_Code	          VARCHAR2(20),
    PRIMARY KEY (Service_Package_ID, Service_Package_Code, Complaint_ID, Complaint_Code),
    FOREIGN KEY (Service_Package_ID) REFERENCES ServicePackage(Service_Package_ID),
    FOREIGN KEY (Service_Package_Code) REFERENCES ServicePackage(Service_Package_Code),
    FOREIGN KEY (Complaint_ID) REFERENCES Complaint(Complaint_ID), 
    FOREIGN KEY (Complaint_Code) REFERENCES Complaint(Complaint_Code)
);

CREATE TABLE ServicePackage_MobilePlan (
    Service_Package_ID	          VARCHAR2(20),
    Service_Package_Code	  VARCHAR2(20),
    Plan_ID	                  VARCHAR2(20),
    Plan_Code	                  VARCHAR2(20),
    PRIMARY KEY (Service_Package_ID, Service_Package_Code, Plan_ID, Plan_Code),
    FOREIGN KEY (Service_Package_ID) REFERENCES ServicePackage(Service_Package_ID),
    FOREIGN KEY (Service_Package_Code) REFERENCES ServicePackage(Service_Package_Code),
    FOREIGN KEY (Plan_ID) REFERENCES MobilePlan(Plan_ID),
    FOREIGN KEY (Plan_Code) REFERENCES MobilePlan(Plan_Code)
);

CREATE TABLE Campaign_ServicePackage (
    Campaign_ID	                  VARCHAR2(20),
    Campaign_Code	          VARCHAR2(20),
    Service_Package_ID	          VARCHAR2(20),
    Service_Package_Code	  VARCHAR2(20),
    PRIMARY KEY (Campaign_ID, Campaign_Code, Service_Package_ID, Service_Package_Code),
    FOREIGN KEY (Campaign_ID) REFERENCES Campaign(Campaign_ID),
    FOREIGN KEY (Campaign_Code) REFERENCES Campaign(Campaign_Code),
    FOREIGN KEY (Service_Package_ID) REFERENCES ServicePackage(Service_Package_ID),
    FOREIGN KEY (Service_Package_Code) REFERENCES ServicePackage(Service_Package_Code)
);

CREATE TABLE Complaint_ServiceRequest (
    Complaint_ID	          VARCHAR2(20),
    Complaint_Code	          VARCHAR2(20),
    Request_ID	                  VARCHAR2(20),
    Request_Code	          VARCHAR2(20),
    PRIMARY KEY (Complaint_ID, Complaint_Code, Request_ID, Request_Code),
    FOREIGN KEY (Complaint_ID) REFERENCES Complaint(Complaint_ID), 
    FOREIGN KEY (Complaint_Code) REFERENCES Complaint(Complaint_Code),
    FOREIGN KEY (Request_ID) REFERENCES ServiceRequest(Request_ID),
    FOREIGN KEY (Request_Code) REFERENCES ServiceRequest(Request_Code)  
);

CREATE TABLE MobilePlan_Subscription (
    Plan_ID	                  VARCHAR2(20),
    Plan_Code	                  VARCHAR2(50),
    Subscription_ID	                  VARCHAR2(20),
    Subscription_Code	                  VARCHAR2(20),
    PRIMARY KEY (Plan_ID, Plan_Code, Subscription_ID, Subscription_Code),
    FOREIGN KEY (Plan_ID) REFERENCES MobilePlan(Plan_ID),
    FOREIGN KEY (Plan_Code) REFERENCES MobilePlan(Plan_Code),
    FOREIGN KEY (Subscription_ID) REFERENCES Subscription(Subscription_ID), 
    FOREIGN KEY (Subscription_Code) REFERENCES Subscription(Subscription_Code)
);

CREATE TABLE MobilePlan_Invoice (
    Plan_ID	                  VARCHAR2(20),
    Plan_Code	                  VARCHAR2(20),
    Invoice_ID	                  VARCHAR2(20),
    Bill_No	                  VARCHAR2(20),
    PRIMARY KEY (Plan_ID, Plan_Code, Invoice_ID, Bill_No),
    FOREIGN KEY (Plan_ID) REFERENCES MobilePlan(Plan_ID),
    FOREIGN KEY (Plan_Code) REFERENCES MobilePlan(Plan_Code),
    FOREIGN KEY (Invoice_ID) REFERENCES Invoice(Invoice_ID),
    FOREIGN KEY (Bill_No) REFERENCES Invoice(Bill_No) 
);

CREATE TABLE MobilePlan_Payment (
    Plan_ID	                  VARCHAR2(20),
    Plan_Code	                  VARCHAR2(50),
    Payment_ID	                  VARCHAR2(20),
    Reference_Code	          VARCHAR2(20),
    PRIMARY KEY (Plan_ID, Plan_Code, Payment_ID, Reference_Code),
    FOREIGN KEY (Plan_ID) REFERENCES MobilePlan(Plan_ID),
    FOREIGN KEY (Plan_Code) REFERENCES MobilePlan(Plan_Code),
    FOREIGN KEY (Payment_ID) REFERENCES Payment(Payment_ID),
    FOREIGN KEY (Reference_Code) REFERENCES Payment(Reference_Code) 
);

CREATE TABLE MobilePlan_Complaint (
    Plan_ID	                  VARCHAR2(20),
    Plan_Code	                  VARCHAR2(50),
    Complaint_ID	          VARCHAR2(20),
    Complaint_Code                VARCHAR2(20),
    PRIMARY KEY (Plan_ID, Plan_Code, Complaint_ID, Complaint_Code),
    FOREIGN KEY (Plan_ID) REFERENCES MobilePlan(Plan_ID),
    FOREIGN KEY (Plan_Code) REFERENCES MobilePlan(Plan_Code),
    FOREIGN KEY (Complaint_ID) REFERENCES Complaint(Complaint_ID), 
    FOREIGN KEY (Complaint_Code) REFERENCES Complaint(Complaint_Code)  
);

CREATE TABLE MobilePlan_ServiceRequest (
    Plan_ID	                  VARCHAR2(20),
    Plan_Code	                  VARCHAR2(50),
    Request_ID	                  VARCHAR2(20),
    Request_Code	          VARCHAR2(20), 
    PRIMARY KEY (Plan_ID, Plan_Code, Request_ID, Request_Code),
    FOREIGN KEY (Plan_ID) REFERENCES MobilePlan(Plan_ID),
    FOREIGN KEY (Plan_Code) REFERENCES MobilePlan(Plan_Code),
    FOREIGN KEY (Request_ID) REFERENCES ServiceRequest(Request_ID),
    FOREIGN KEY (Request_Code) REFERENCES ServiceRequest(Request_Code)  
);