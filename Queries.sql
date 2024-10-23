--Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.'"


Insert into books (isbn,book_title,category,rental_price,status,author,publisher)
Values ('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');


--Task 2: Update an Existing Member's Address

Update member_address
Set member_address = '125 Oak St'
Where member_id = 'C103'


--Task 3: Delete a Record from the Issued Status Table -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

Delete from issued_status
Where issue_id = 'IS121'

--Task 4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.

Select isbn, book_title
From issued_status i
Join books b
  On i.issued_book_isbn = b.isbn
Where issued_emp_id = 'E101'

--Task 5: List Members Who Have Issued More Than One Book.

Select member_id, member_name
From issued_status i
Join members m
  On i.issued_member_id = m.member_id
Group by member_id, member_name
Having count(*) > 1

--Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt

Create table total_book_issued as

Select b.isbn, b.book_title, count(i.issued_id) as total_book
From issued_status i
Join books b
  On i.issued_book_isbn = b.isbn
Group by b.isbn, b.book_title
Order by total_book desc


--Task 7. Retrieve All Books in a Specific Category:

Select *
From books
Where category = 'classic'

--Task 8: Find Total Rental Income by Category:

Select category, sum(rental_price) as total_income
From books b
Join issued_book_isbn i
  On b.isbn = i.issued_book_isbn
Group by category
Order by total_income desc

--Task 9. List Members Who Registered in the Last 180 Days:

Select
From members
Where reg_date > current_date - interval 180 'days'


--Task 10. List Employees with Their Branch Manager's Name and their branch details:

CREATE TABLE branch
(
            branch_id VARCHAR(10) PRIMARY KEY,
            manager_id VARCHAR(10),
            branch_address VARCHAR(30),
            contact_no VARCHAR(15)
);


-- Create table "Employee"
DROP TABLE IF EXISTS employees;
CREATE TABLE employees
(
            emp_id VARCHAR(10) PRIMARY KEY,
            emp_name VARCHAR(30),
            position VARCHAR(30),
            salary DECIMAL(10,2),
            branch_id VARCHAR(10),
            FOREIGN KEY (branch_id) REFERENCES  branch(branch_id)
);

Select emp_id
From employees e1
Join branch 
  On e1

--Task 11. Create a Table of Books with Rental Price Above a Certain Threshold:

Select *
From books
Where rental_price > -- ;



--Task 12: Retrieve the List of Books Not Yet Returned

Select *
From issued_status 
Where issued_id not in ( Select issued_id From return_status)

--Task 13: Identify Members with Overdue Books
--Write a query to identify members who have overdue books (assume a 30-day return period). Display the 
  member's_id, member's name, book title, issue date, and days overdue.

Select
  issued_member_id,
  member_name,
   book_title,
  issued_date,
  current_date - issued_date as days_overdue
From issued_status i
Join members m
  On i.issued_member_id = m.member_id
Join books b
    On i.issued_book_isbn = b.isbn
Where issued_id not in (Select issued_id from return_status) and
      current_date - issued_date > interval 30 'days'

--Task 14: Update Book Status on Return

CREATE TABLE return_status
(
            return_id VARCHAR(10) PRIMARY KEY,
            issued_id VARCHAR(30),
            return_book_name VARCHAR(80),
            return_date DATE,
            return_book_isbn VARCHAR(50),
            FOREIGN KEY (return_book_isbn) REFERENCES books(isbn)
);


--Task 17: Find Employees with the Most Book Issues Processed
--Write a query to find the top 3 employees who have processed the most book issues. Display the employee name, number of books processed, and their branch.

Select 
  emp_name,
  count(issued_status) as no_of_books,
  branch_id
From issued_status i
Join employees e
  On i.issued_emp_id = e.emp_id
Group by emp_name, branch_id
Order by no_of_books desc
Limit 3


--Task 18: Identify Members Issuing High-Risk Books
--Write a query to identify members who have issued books more than twice with the status "damaged" in the books table. 
--Display the member name, book title, and the number of times they've issued damaged books

Select
  m.member_name,
  b.book_title,
  count(return_id) as no_of_damaged_books
From issued_status i
Join return_status r
  On i.issued_id = r.issued_id 
Join members m
  On i.issued_member_id = m.member_id
Join books b
  On i.issued_book_isbn = b.isbn
Where r.book_quality = 'Damaged'
Group by   m.member_name,
  b.book_title
Having count(return_id) > 2




















