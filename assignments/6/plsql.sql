-- Name: Vitor Gabriel da Silva Ruffo

-- Oracle solution:

--------------------------------------------------
-- 0. Database definition and population:

-- defining tables:



CREATE SCHEMA AUTHORIZATION vgsr

CREATE TABLE vgsr.publisher(
	name VARCHAR(300),
	address VARCHAR(300),
	phone VARCHAR(30),
	
	CONSTRAINT pk_publisher PRIMARY KEY (name)
);

CREATE TABLE vgsr.library_branch(
	branch_id INT,
	branch_name VARCHAR(150),
	address VARCHAR (300),
	
	CONSTRAINT pk_library_branch PRIMARY KEY (branch_id)
);

CREATE TABLE vgsr.borrower (
	card_no INT, 
	name VARCHAR(150),
	address VARCHAR(300),
	phone VARCHAR (30),
	
	CONSTRAINT pk_borrower PRIMARY KEY (card_no)
);

CREATE TABLE vgsr.book(
	book_id INT,
	title VARCHAR(300),
	publisher_name VARCHAR(300),
	CONSTRAINT pk_book PRIMARY KEY (book_id),
	CONSTRAINT fk_book_publisher FOREIGN KEY (publisher_name)
		REFERENCES vgsr.publisher (name)
);

CREATE TABLE vgsr.book_authors(
	book_id INT,
	author_name VARCHAR (150),
	
	CONSTRAINT pk_book_author PRIMARY KEY (book_id, author_name),
	CONSTRAINT fk_book_id FOREIGN KEY (book_id) 
		REFERENCES vgsr.book (book_id)
);



CREATE TABLE vgsr.book_copies(
	book_id INT,
	branch_id INT,
	no_of_copies INT,
	
	CONSTRAINT pk_book_copies PRIMARY KEY (book_id, branch_id),
	CONSTRAINT fk_book_copies_book_id FOREIGN KEY (book_id)
		REFERENCES vgsr.book (book_id),
	CONSTRAINT fk_book_copies_branch_id FOREIGN KEY (branch_id)
		REFERENCES vgsr.library_branch (branch_id)
);

CREATE TABLE vgsr.book_loans(
	book_id INT,
	branch_id INT, 
	card_no INT,
	date_out DATE,
	due_date DATE,
	
	CONSTRAINT pk_book_loans PRIMARY KEY (branch_id, book_id, card_no),
	CONSTRAINT fk_book_loans_book_id FOREIGN KEY (book_id)
		REFERENCES vgsr.book (book_id),
	CONSTRAINT fk_book_loans_branch_id FOREIGN KEY (branch_id)
		REFERENCES vgsr.library_branch (branch_id),
	CONSTRAINT fk_book_loans_card_no FOREIGN KEY (card_no)
		REFERENCES vgsr.borrower (card_no)
);


COMMIT;




-- inserting data into database tables:



INSERT INTO vgsr.publisher(name, address, phone)
VALUES ('publisher1', 'Rua mesa, 901', '3110-3111');

INSERT INTO vgsr.publisher(name, address, phone)
VALUES ('publisher2', 'Rua abacate, 501', '3210-3111');

INSERT INTO vgsr.publisher(name, address, phone)
VALUES ('publisher3', 'Rua abobora, 111', '3140-3111');

INSERT INTO vgsr.publisher(name, address, phone)
VALUES ('publisher4', 'Rua almerao, 951', '3510-3111');

INSERT INTO vgsr.publisher(name, address, phone)
VALUES ('publisher5', 'Rua cebola, 201', '3140-3111');

INSERT INTO vgsr.publisher(name, address, phone)
VALUES ('publisher6', 'Rua maca, 101', '3610-3111');


INSERT INTO vgsr.library_branch(branch_id, branch_name, address)
VALUES (1, 'londrina branch', 'Rua dos alfeneiros, 4');

INSERT INTO vgsr.library_branch(branch_id, branch_name, address)
VALUES (2, 'rolandia branch', 'Rua brasilia, 15');

INSERT INTO vgsr.library_branch(branch_id, branch_name, address)
VALUES (3, 'maringa branch', 'Rua sao paulo, 100');

INSERT INTO vgsr.library_branch(branch_id, branch_name, address)
VALUES (4, 'Sharpstown', 'Rua jose de alencar, 159');

INSERT INTO vgsr.library_branch(branch_id, branch_name, address)
VALUES (5, 'Central', 'Rua luiz cabral, 531');


INSERT INTO vgsr.borrower(card_no, name, address, phone)
VALUES(911, 'Lionel Messi', 'Rua caderno, 643', '4110-6111');

INSERT INTO vgsr.borrower(card_no, name, address, phone)
VALUES(877, 'Cristiano Ronaldo', 'Rua mesa, 901', '3110-3111');

INSERT INTO vgsr.borrower(card_no, name, address, phone)
VALUES(101, 'Ronaldo Fenomeno', 'Rua goias, 1021', '3244-3111');

INSERT INTO vgsr.borrower(card_no, name, address, phone)
VALUES(201, 'Ronaldinho Gaucho', 'Rua barnabe, 1121', '3266-3111');

INSERT INTO vgsr.borrower(card_no, name, address, phone)
VALUES(301, 'Kylian Mbappe', 'Rua dos gauchos, 113', '3277-3111');

INSERT INTO vgsr.borrower(card_no, name, address, phone)
VALUES(401, 'Kaka', 'Rua para, 177', '3299-3111');

INSERT INTO vgsr.borrower(card_no, name, address, phone)
VALUES(501, 'Gabigol', 'Rua bahia, 188', '3277-3441');


INSERT INTO vgsr.book (book_id, title, publisher_name)
VALUES (1, 'The Lord of The Rings 1', 'publisher1');

INSERT INTO vgsr.book (book_id, title, publisher_name)
VALUES (2, 'The Lord of The Rings 2', 'publisher1');

INSERT INTO vgsr.book (book_id, title, publisher_name)
VALUES (3, 'Harry Potter 1', 'publisher2');

INSERT INTO vgsr.book (book_id, title, publisher_name)
VALUES (4, 'Harry Potter 2', 'publisher2');

INSERT INTO vgsr.book (book_id, title, publisher_name)
VALUES (5, 'Percy Jackson 1', 'publisher3');

INSERT INTO vgsr.book (book_id, title, publisher_name)
VALUES (6, 'Percy Jackson 2', 'publisher3');

INSERT INTO vgsr.book (book_id, title, publisher_name)
VALUES (7, 'Narnia 1', 'publisher4');

INSERT INTO vgsr.book (book_id, title, publisher_name)
VALUES (8, 'Narnia 2', 'publisher4');

INSERT INTO vgsr.book (book_id, title, publisher_name)
VALUES (9, 'Algorithms', 'publisher5');

INSERT INTO vgsr.book (book_id, title, publisher_name)
VALUES (10, 'The Lost Tribe', 'publisher5');


INSERT INTO vgsr.book_authors(book_id, author_name)
VALUES (1, 'Vitor Gabriel');

INSERT INTO vgsr.book_authors(book_id, author_name)
VALUES (2, 'Vitor Gabriel');

INSERT INTO vgsr.book_authors(book_id, author_name)
VALUES (3, 'J. K. Rowling');

INSERT INTO vgsr.book_authors(book_id, author_name)
VALUES (4, 'J. K. Rowling');

INSERT INTO vgsr.book_authors(book_id, author_name)
VALUES (5, 'Joao Coelho');

INSERT INTO vgsr.book_authors(book_id, author_name)
VALUES (6, 'Joao Coelho');

INSERT INTO vgsr.book_authors(book_id, author_name)
VALUES (7, 'James Patterson');

INSERT INTO vgsr.book_authors(book_id, author_name)
VALUES (8, 'Neymar Jr.');

INSERT INTO vgsr.book_authors(book_id, author_name)
VALUES (9, 'Lionel Messi');

INSERT INTO vgsr.book_authors(book_id, author_name)
VALUES (9, 'James Patterson');

INSERT INTO vgsr.book_authors(book_id, author_name)
VALUES (9, 'Keanu Reaves');

INSERT INTO vgsr.book_authors(book_id, author_name)
VALUES (9, 'Mark Sullivan');

INSERT INTO vgsr.book_authors(book_id, author_name)
VALUES (10, 'James Patterson');

INSERT INTO vgsr.book_authors(book_id, author_name)
VALUES (10, 'Stephen King');

INSERT INTO vgsr.book_authors(book_id, author_name)
VALUES (10, 'Mark Sullivan');



INSERT INTO vgsr.book_copies(book_id, branch_id, no_of_copies)
VALUES (1, 1, 4);

INSERT INTO vgsr.book_copies(book_id, branch_id, no_of_copies)
VALUES (2, 1, 4);

INSERT INTO vgsr.book_copies(book_id, branch_id, no_of_copies)
VALUES (3, 2, 2);

INSERT INTO vgsr.book_copies(book_id, branch_id, no_of_copies)
VALUES (4, 2, 2);

INSERT INTO vgsr.book_copies(book_id, branch_id, no_of_copies)
VALUES (1, 2, 2);

INSERT INTO vgsr.book_copies(book_id, branch_id, no_of_copies)
VALUES (2, 2, 2);

INSERT INTO vgsr.book_copies(book_id, branch_id, no_of_copies)
VALUES (5, 3, 3);

INSERT INTO vgsr.book_copies(book_id, branch_id, no_of_copies)
VALUES (6, 3, 2);

INSERT INTO vgsr.book_copies(book_id, branch_id, no_of_copies)
VALUES (7, 1, 3);

INSERT INTO vgsr.book_copies(book_id, branch_id, no_of_copies)
VALUES (8, 2, 3);

INSERT INTO vgsr.book_copies(book_id, branch_id, no_of_copies)
VALUES (9, 1, 5);

INSERT INTO vgsr.book_copies(book_id, branch_id, no_of_copies)
VALUES (10, 1, 1);

INSERT INTO vgsr.book_copies(book_id, branch_id, no_of_copies)
VALUES (10, 3, 3);

INSERT INTO vgsr.book_copies(book_id, branch_id, no_of_copies)
VALUES (10, 4, 6);

INSERT INTO vgsr.book_copies(book_id, branch_id, no_of_copies)
VALUES (1, 4, 2 );

INSERT INTO vgsr.book_copies(book_id, branch_id, no_of_copies)
VALUES (3, 4, 3);

INSERT INTO vgsr.book_copies(book_id, branch_id, no_of_copies)
VALUES (5, 4, 2);

INSERT INTO vgsr.book_copies(book_id, branch_id, no_of_copies)
VALUES (10, 5, 4);

INSERT INTO vgsr.book_copies(book_id, branch_id, no_of_copies)
VALUES (9, 5, 5);


INSERT INTO vgsr.book_loans(book_id, branch_id, card_no, date_out, due_date)
VALUES (1, 1, 911, TO_DATE('2021-03-28', 'YYYY-MM-DD'), TO_DATE('2021-04-28', 'YYYY-MM-DD'));

INSERT INTO vgsr.book_loans(book_id, branch_id, card_no, date_out, due_date)
VALUES (1, 1, 877, TO_DATE('2021-05-28', 'YYYY-MM-DD'), TO_DATE('2021-06-28', 'YYYY-MM-DD'));

INSERT INTO vgsr.book_loans(book_id, branch_id, card_no, date_out, due_date)
VALUES (2, 1, 911, TO_DATE('2021-04-28', 'YYYY-MM-DD'), TO_DATE('2021-06-28', 'YYYY-MM-DD'));

INSERT INTO vgsr.book_loans(book_id, branch_id, card_no, date_out, due_date)
VALUES (10, 4, 501,TO_DATE('2021-09-27', 'YYYY-MM-DD'), TO_DATE('2021-10-27', 'YYYY-MM-DD'));

INSERT INTO vgsr.book_loans(book_id, branch_id, card_no, date_out, due_date)
VALUES (1, 4, 401, TO_DATE('2021-10-15', 'YYYY-MM-DD'), TO_DATE('2021-11-15', 'YYYY-MM-DD'));

INSERT INTO vgsr.book_loans(book_id, branch_id, card_no, date_out, due_date)
VALUES (5, 4, 401, TO_DATE('2021-09-27', 'YYYY-MM-DD'), TO_DATE('2021-10-27', 'YYYY-MM-DD'));

INSERT INTO vgsr.book_loans(book_id, branch_id, card_no, date_out, due_date)
VALUES (3, 4, 301, TO_DATE('2021-10-15', 'YYYY-MM-DD'), TO_DATE('2021-11-15', 'YYYY-MM-DD'));

INSERT INTO vgsr.book_loans(book_id, branch_id, card_no, date_out, due_date)
VALUES (4, 2, 301, TO_DATE('2021-10-15', 'YYYY-MM-DD'), TO_DATE('2021-11-15', 'YYYY-MM-DD'));

INSERT INTO vgsr.book_loans(book_id, branch_id, card_no, date_out, due_date)
VALUES (1, 1, 201, TO_DATE('2021-10-06', 'YYYY-MM-DD'), TO_DATE('2021-11-06', 'YYYY-MM-DD'));

INSERT INTO vgsr.book_loans(book_id, branch_id, card_no, date_out, due_date)
VALUES (3, 2, 201, TO_DATE('2021-10-10', 'YYYY-MM-DD'), TO_DATE('2021-11-10', 'YYYY-MM-DD'));

INSERT INTO vgsr.book_loans(book_id, branch_id, card_no, date_out, due_date)
VALUES (5, 3, 201, TO_DATE('2021-10-15', 'YYYY-MM-DD'), TO_DATE('2021-11-15', 'YYYY-MM-DD'));

INSERT INTO vgsr.book_loans(book_id, branch_id, card_no, date_out, due_date)
VALUES (7, 1, 201, TO_DATE('2021-10-19', 'YYYY-MM-DD'), TO_DATE('2021-11-19', 'YYYY-MM-DD'));

INSERT INTO vgsr.book_loans(book_id, branch_id, card_no, date_out, due_date)
VALUES (9, 1, 201, TO_DATE('2021-10-23', 'YYYY-MM-DD'), TO_DATE('2021-11-23', 'YYYY-MM-DD'));

INSERT INTO vgsr.book_loans(book_id, branch_id, card_no, date_out, due_date)
VALUES (10, 4, 201,TO_DATE('2021-10-29', 'YYYY-MM-DD'), TO_DATE('2021-11-29', 'YYYY-MM-DD'));

INSERT INTO vgsr.book_loans(book_id, branch_id, card_no, date_out, due_date)
VALUES (7, 1, 301, TO_DATE('2021-10-22', 'YYYY-MM-DD'), TO_DATE('2021-11-22', 'YYYY-MM-DD'));

COMMIT;

SELECT * FROM vgsr.book;
SELECT * FROM vgsr.book_authors;
SELECT * FROM vgsr.book_copies;
SELECT * FROM vgsr.book_loans;
SELECT * FROM vgsr.borrower;
SELECT * FROM vgsr.library_branch;
SELECT * FROM vgsr.publisher;



--------------------------------------------------
-- 1.


CREATE MATERIALIZED VIEW 
vgsr.month_borrowers(card_no, name, address, phone, book_title, branch_name, loan_length)
AS 
SELECT mb.card_no, mb.name, mb.address, mb.phone, 
    b.title, lb.branch_name, bl.due_date - bl.date_out AS loan_length 
FROM
    (SELECT br.card_no, br.name, br.address, br.phone
    FROM vgsr.borrower br 
    JOIN vgsr.book_loans bl 
    ON br.card_no = bl.card_no
    WHERE bl.due_date - bl.date_out >= 30
    GROUP BY br.card_no, br.name, br.address, br.phone
    HAVING COUNT(*) > 1) mb
JOIN vgsr.book_loans bl 
ON mb.card_no = bl.card_no
JOIN vgsr.library_branch lb  
ON lb.branch_id = bl.branch_id
JOIN vgsr.book b 
ON b.book_id = bl.book_id
WHERE bl.due_date - bl.date_out >= 30;

COMMIT;


-- Gabigol has borrowed only one book with loan length >= 30 days, so he is not part of
-- the view state.
SELECT * FROM vgsr.month_borrowers;

-- Inserting a new loan for Gabigol with length >= 30 days so that he is included in the view.
INSERT INTO vgsr.book_loans(book_id, branch_id, card_no, date_out, due_date)
VALUES (9, 3, 501, TO_DATE('2021-10-27', 'YYYY-MM-DD'), TO_DATE('2021-12-27', 'YYYY-MM-DD'));

COMMIT;

-- After refreshing the view Gabigol becomes part of the view state.
BEGIN
DBMS_SNAPSHOT.REFRESH('vgsr.month_borrowers');
END;
COMMIT;

SELECT * FROM vgsr.month_borrowers;




--------------------------------------------------
-- 2.


-- 2.1. Create a temporary table to save the current number of copies of each book in each branch.

CREATE GLOBAL TEMPORARY TABLE old_book_copies 
(book_id INT, branch_id INT, no_of_copies INT)
ON COMMIT PRESERVE ROWS; 

INSERT INTO old_book_copies (book_id, branch_id, no_of_copies)
SELECT book_id, branch_id, no_of_copies FROM vgsr.book_copies;

COMMIT;


-- 2.2. Implement the commands to perform the necessary change to the database schema.

-- 2.2.1. altering book copies schema
ALTER TABLE vgsr.book_copies
DROP COLUMN no_of_copies;

ALTER TABLE vgsr.book_copies
RENAME TO branch_books;

CREATE TABLE vgsr.branch_books_copies (
	book_id INT,
	branch_id INT,
	copy_id INT,
	acquisition_date DATE,
	condition VARCHAR(6),
	CONSTRAINT pk_branch_books_copies PRIMARY KEY (book_id, branch_id, copy_id),
	CONSTRAINT fk_branch_books_copies FOREIGN KEY (book_id, branch_id)
 		REFERENCES vgsr.branch_books (book_id, branch_id) ON DELETE CASCADE
);

CREATE SEQUENCE bbc_cp_seq START WITH 1;

CREATE OR REPLACE TRIGGER bbc_cp_tr 
BEFORE INSERT ON vgsr.branch_books_copies
FOR EACH ROW
BEGIN
  SELECT bbc_cp_seq.NEXTVAL
  INTO   :new.copy_id
  FROM   dual;
END;
/

COMMIT;


-- 2.2.2. altering book_loans table.


ALTER TABLE vgsr.book_loans
ADD copy_id INT;

COMMIT;

-- this seems a reasonable alter to perform but users will notice a change in the database schema 
-- (e.g., book loan insertion will fail because user will not provide a copy_id )...
--
-- ALTER TABLE vgsr.book_loans
-- DROP CONSTRAINT pk_book_loans;
-- ALTER TABLE vgsr.book_loans
-- ADD CONSTRAINT pk_book_loans PRIMARY KEY (book_id, branch_id, card_no, copy_id);
-- ALTER TABLE vgsr.book_loans
-- ADD CONSTRAINT fk_book_loans FOREIGN KEY (copy_id) REFERENCES vgsr.branch_books_copies (copy_id);



-- 2.3. Populating new branch_books_copies table with individual book copies.

CREATE OR REPLACE PROCEDURE vgsr.populate_branch_books_copies IS
	it vgsr.old_book_copies%ROWTYPE;
	i INT;
BEGIN
	FOR it IN 
		(SELECT * FROM old_book_copies)
	LOOP
		i := it.no_of_copies; 
		WHILE (i > 0) LOOP
   			INSERT INTO vgsr.branch_books_copies(book_id, branch_id, acquisition_date, condition)
	  		VALUES (it.book_id, it.branch_id, CURRENT_DATE, 'good');
			i := i - 1;
  		END LOOP;
  	END LOOP;
END;
/

BEGIN
vgsr.populate_branch_books_copies();
END;

TRUNCATE TABLE old_book_copies;
DROP TABLE old_book_copies;

COMMIT;


-- 2.4. Create a view with the same name as the old table (book_copies), showing the same content.
--      That is, an application could interact with the view as it was the old table.


CREATE VIEW 
vgsr.book_copies(book_id, branch_id, no_of_copies)
AS 
SELECT book_id, branch_id, COUNT(*) AS no_of_copies
FROM vgsr.branch_books_copies
GROUP BY book_id, branch_id
ORDER BY book_id, branch_id;



CREATE OR REPLACE TRIGGER vgsr.book_copies_update_tr INSTEAD OF
INSERT OR UPDATE OR DELETE
ON vgsr.book_copies
FOR EACH ROW
DECLARE
	i INT;
BEGIN
	CASE
		WHEN INSERTING THEN
			INSERT INTO vgsr.branch_books(book_id, branch_id)
			VALUES (:new.book_id, :new.branch_id);

			i := :new.no_of_copies;
			WHILE (i > 0) LOOP
				INSERT INTO vgsr.branch_books_copies(book_id, branch_id, acquisition_date, condition)
				VALUES (:new.book_id, :new.branch_id, CURRENT_DATE, 'good');
				i := i - 1;
			END LOOP;

		WHEN UPDATING THEN
			IF :old.no_of_copies > :new.no_of_copies THEN
				RAISE_APPLICATION_ERROR(-20100, 'number of copies cannot be reduced.');
			END IF;

			IF :new.no_of_copies > :old.no_of_copies THEN
				i := :new.no_of_copies - :old.no_of_copies;
				WHILE (i > 0) LOOP
					INSERT INTO vgsr.branch_books_copies(book_id, branch_id, acquisition_date, condition)
					VALUES (:old.book_id, :old.branch_id, CURRENT_DATE, 'good');
					i := i - 1;
				END LOOP;
			END IF;

			UPDATE vgsr.branch_books
			SET book_id=:new.book_id, branch_id=:new.branch_id
			WHERE book_id=:old.book_id AND branch_id=:old.branch_id;

			UPDATE vgsr.branch_books_copies
			SET book_id=:new.book_id, branch_id=:new.branch_id
			WHERE book_id=:old.book_id AND branch_id=:old.branch_id;
			
		WHEN DELETING THEN
			DELETE FROM vgsr.branch_books 
			WHERE book_id=:old.book_id AND branch_id=:old.branch_id; -- this deletion will trigger the deletion of the corresponding tuples in branch_books_copies relation...
			
	END CASE;
END;
/

COMMIT;


-- database state before updates...
SELECT * FROM vgsr.book_copies;
SELECT * FROM vgsr.branch_books;
SELECT * FROM vgsr.branch_books_copies;


-- updating view...

-- delete
DELETE FROM vgsr.book_copies WHERE book_id=1 AND branch_id=1;

-- update
UPDATE vgsr.book_copies
SET book_id=3
WHERE book_id=2 AND branch_id=1;

-- update (error)
UPDATE vgsr.book_copies
SET no_of_copies=3
WHERE book_id=9 AND branch_id=5;

-- insert and update
INSERT INTO vgsr.book_copies(book_id, branch_id, no_of_copies)
VALUES (4, 1, 3);

UPDATE vgsr.book_copies
SET no_of_copies=5
WHERE book_id=4 AND branch_id=1;

COMMIT;

-- database state after updates...
SELECT * FROM vgsr.book_copies;
SELECT * FROM vgsr.branch_books;
SELECT * FROM vgsr.branch_books_copies;


--------------------------------------------------
-- 3.










--------------------------------------------------