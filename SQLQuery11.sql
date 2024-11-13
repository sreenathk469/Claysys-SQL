--TASK 2.

--create table with auto increment..
CREATE TABLE Student(RollNo int NOT NULL IDENTITY,Name varchar(20),Address varchar(30),State Varchar(15),PinCode Int,Mobile INT,Stipend int,Subject varchar(20),University VARCHAR(30));

--insert values..
INSERT INTO Student(Name,Address,State,PinCode,Mobile,Stipend,Subject,University) VALUES('keerthy','ABC','KL','876549','98767865','1900','Computer','Calicut university');
INSERT INTO Student(Name,Address,State,PinCode,Mobile,Stipend,Subject,University) VALUES('Vineetha','DABC','KL','987549','87987678','2900','Computer','Calicut university');
INSERT INTO Student(Name,Address,State,PinCode,Mobile,Stipend,Subject,University) VALUES('Vinod','EABC','TN','876549','987678687','1900','Computer','SRM university');

-- RETRIEVE VALUE..
SELECT * FROM Student;

--Update Student table..
UPDATE Student set Name='Sree' WHERE RollNO=1;

--Delete a ROW..
DELETE FROM Student WHERE RollNo=2;


--Task 3.
--Create Table..
CREATE TABLE Employee(Id int not null,Name varchar(20),Department varchar(5),Salary int);

--Insert Value..
INSERT INTO Employee(Id,Name,Department,Salary) VALUES(1,'mandeep','B','10000');
INSERT INTO Employee(Id,Name,Department,Salary) VALUES(102,'Mohan','A','15000');
INSERT INTO Employee(Id,Name,Department,Salary) VALUES(103,'Anand','B','12000');



select top 1 Name from Employee where salary<(select Max(salary) from employee)order by salary desc;

--Task 4..
SELECT Department,COUNT(*) as counter FROM Employee group by department;

--Task 5..
-- Join Concept..
SELECT Employee.Name,Student.Name FROM Employee INNER JOIN Student ON Employee.Id=Student.RollNo;

SELECT Employee.Name,Student.Name FROM Employee LEFT JOIN Student ON Employee.Id=Student.RollNo;

SELECT Employee.Name,Student.Name FROM Employee RIGHT JOIN Student ON Employee.Id=Student.RollNo;

SELECT Employee.Name,Student.Name FROM Employee FULL JOIN Student ON Employee.Id=Student.RollNo;

SELECT Employee.Name,Student.Name FROM Employee CROSS JOIN Student;


--TASK 6..
CREATE TABLE Department(DId INT PRIMARY KEY,Name VARCHAR(10));
CREATE TABLE Doctors(Id INT NOT NULL PRIMARY KEY,Name VARCHAR(30),DepartmentID INT,FOREIGN KEY (DepartmentID)REFERENCES DEPARTMENT(DId));

--TASK 8..

--CRUD STORED PROCEEDURE
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

CREATE PROCEDURE usp_CRUD_Employee
    @Action NVARCHAR(10),        
    @EmployeeID INT = NULL,      
    @Name VARCHAR(50) = NULL,    
    @DepartmentID INT = NULL,    
    @Salary DECIMAL(10, 2) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- CREATE Operation
    IF @Action = 'CREATE'
    BEGIN 
	INSERT INTO Employee (Name, DepartmentID, Salary)
        VALUES (@Name, @DepartmentID, @Salary);
        
        PRINT 'created successfully.';
    END

    -- READ Operation
    ELSE IF @Action = 'READ'
    BEGIN
        IF @EmployeeID IS NOT NULL
        BEGIN
            SELECT * FROM Employee WHERE EmployeeID = @EmployeeID;
        END
        ELSE
        BEGIN
            SELECT * FROM Employee;
        END
    END

    -- UPDATE Operation
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Employee
        SET Name = @Name,
            DepartmentID = @DepartmentID,
            Salary = @Salary
        WHERE EmployeeID = @EmployeeID;

        PRINT 'updated.';
    END

    -- DELETE Operation
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Employee
        WHERE EmployeeID = @EmployeeID;

        PRINT 'deleted ';
    END

    ELSE
    BEGIN
        PRINT 'Invalid';
    END
END;


