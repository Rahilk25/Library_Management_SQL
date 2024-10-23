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











