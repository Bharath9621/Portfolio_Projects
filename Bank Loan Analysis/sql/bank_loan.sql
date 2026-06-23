use bank_loan_db;
select * from bank;
select count(id) as Total_Applications from bank;
select count(id) as Total_Applications from bank 
where Month(issue_date)=12;
select count(id) as Total_Applications_November from bank
where month(issue_date) = 11;
select sum(loan_amount) as Total_Funded_Amount from bank
select sum(loan_amount) as Total_Funded_Amount from bank
where month(issue_date)= 11;
select sum(total_payment) as Total_Collected_Amouont from bank
where month(issue_date)= 11;

select round(avg(int_rate),4)*100 as Avg_Interest_rate from bank
where month(issue_date)=11;

select round(avg(dti),4)*100 as Average_debt_to_Income_Ratio from bank
where month(issue_date)=11;

select (count(case when loan_status ='Fully Paid' or loan_status = 'Current' then id end)*100.0)/
count(id) as Good_Loan_Percentage from bank;

select count(id) as Good_Loan_Applications from bank
where loan_status = 'Fully Paid' or loan_status = 'Current';

select sum(loan_amount) as Good_Loan_Funded_Amount from bank
where loan_status = 'Fully Paid' or loan_status = 'Current';

select sum(total_payment) as Good_Loan_Recieved_Amount from bank
where loan_status = 'Fully Paid' or loan_status = 'Current';

select (count(case when loan_status ='Charged Off' then id end)*100.0)/
count(id) as Bad_Loan_Percentage from bank;

select count(id) as Bad_Loan_Applications from bank
where loan_status = 'Charged Off';

select sum(loan_amount) as Bad_Loan_Funded_Amount from bank
where loan_status = 'Charged Off';

select sum(total_payment) as Bad_Loan_Recieved_Amount from bank
where loan_status = 'Charged Off';

select
loan_status,
count(id) as Loan_Count,
sum(total_payment) as Total_Recieved,
sum(loan_amount) as Total_Funded,
avg(int_rate * 100) as Interest_Rate,
avg(dti*100) as Debt_to_Income_Ratio
from bank
group by loan_status;


select 
month(issue_date) as Month_Number,
datename(month,issue_date) as 'Month',
count(id) as Total_Loan_Applications,
sum(loan_amount) as Total_Funded,
sum(total_payment) as Total_Recieved
from bank
group by month(issue_date), datename(month,issue_date)
order by month(issue_date);


select
address_state as 'State',
count(id) as Total_Loan_Applications,
sum(loan_amount) as Total_Funded,
sum(total_payment) as Total_Recieved
from bank 
group by address_state
order by count(id)  desc;

SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank
GROUP BY term
ORDER BY term


SELECT 
emp_length AS Employee_Length, 
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Amount_Received
FROM bank
GROUP BY emp_length
ORDER BY emp_length;


SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank
GROUP BY purpose
ORDER BY purpose;


SELECT 
home_ownership AS Home_Ownership, 
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Amount_Received
FROM bank
GROUP BY home_ownership
ORDER BY home_ownership;

SELECT 
purpose AS PURPOSE, 
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Amount_Received
FROM bank
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose

