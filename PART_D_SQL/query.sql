-- 1. find list of titles borrowed between date, year specified.
-- make the stored procedure (sp)
DELIMITER $$
CREATE PROCEDURE sp_FindTitle(IN date1 DATE, IN date2 DATE, IN year_pub YEAR)
BEGIN
  SELECT title
  FROM borrowinghistory bh
  LEFT JOIN books b ON bh.book_id = b.book_status
  WHERE borrowing_date AND return_date BETWEEN date1 AND date2 AND year_of_publication = year_pub;
END $$
DELIMITER ;

-- example call sp
CALL sp_FindTitle('2006-01-10', '2006-02-15', 1991);


-- 2 display list visitors who borrow books more than 1 month
-- make the stored procedure (sp)
DELIMITER $$
CREATE PROCEDURE sp_BorrowMoreThanAMonth()
BEGIN
  SELECT v.*, DATEDIFF(return_date, borrowing_date) AS date_diff
  FROM `borrowinghistory` bh
  INNER JOIN visitors v ON bh.visitor_id = v.id
  WHERE DATEDIFF(return_date, borrowing_date) > 30;
END $$
DELIMITER ;

-- example call sp
CALL sp_BorrowMoreThanAMonth();


-- 3. display visitors name who borrow specified book
DELIMITER $$
CREATE PROCEDURE sp_BorrowerOfBook(IN book_title VARCHAR(255))
BEGIN
  SELECT v.name FROM visitors v
  INNER JOIN borrowinghistory bh ON v.id = bh.visitor_id
  INNER JOIN books b ON bh.book_id = b.id
  WHERE b.title = book_title;
END $$
DELIMITER ;

-- example call sp
CALL sp_BorrowerOfBook('Classical Mythology');