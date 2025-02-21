use class4;

-- task-1
CREATE TABLE [dbo].[TestMultipleZero]
(
    [A] [int] NULL,
    [B] [int] NULL,
    [C] [int] NULL,
    [D] [int] NULL
);
GO

INSERT INTO [dbo].[TestMultipleZero](A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);

select * from [dbo].[TestMultipleZero]

SELECT * 
FROM [dbo].[TestMultipleZero]
WHERE A <> 0 OR B <> 0 OR C <> 0 OR D <> 0;

-- task-2
CREATE TABLE TestMax
(
    Year1 INT
    ,Max1 INT
    ,Max2 INT
    ,Max3 INT
);
GO
 
INSERT INTO TestMax 
VALUES
    (2001,10,101,87)
    ,(2002,103,19,88)
    ,(2003,21,23,89)
    ,(2004,27,28,91);

select * from TestMax;

SELECT 
    Year1,
    (SELECT MAX(val) 
     FROM (VALUES (Max1), (Max2), (Max3)) AS ValueTable(val)) AS MaxValue
FROM TestMax;

-- task-3 
CREATE TABLE EmpBirth
(
    EmpId INT  IDENTITY(1,1) 
    ,EmpName VARCHAR(50) 
    ,BirthDate DATETIME 
);
 
INSERT INTO EmpBirth(EmpName,BirthDate)
SELECT 'Pawan' , '12/04/1983'
UNION ALL
SELECT 'Zuzu' , '11/28/1986'
UNION ALL
SELECT 'Parveen', '05/07/1977'
UNION ALL
SELECT 'Mahesh', '01/13/1983'
UNION ALL
SELECT'Ramesh', '05/09/1983';

SELECT * FROM EmpBirth;

SELECT EmpId, EmpName, BirthDate
FROM EmpBirth
WHERE MONTH(BirthDate) = 5 
AND DAY(BirthDate) BETWEEN 7 AND 15;

-- task-4
create table letters
(letter char(1));

insert into letters
values ('a'), ('a'), ('a'), 
  ('b'), ('c'), ('d'), ('e'), ('f');

select * from letters;

-- 4.1
SELECT letter
FROM letters
ORDER BY CASE 
    WHEN letter = 'b' THEN 0  -- 'b' harfini birinchi joyga qo‘ydim
    ELSE 1 
END, letter;

-- 4.2
SELECT letter
FROM letters
ORDER BY CASE 
    WHEN letter = 'b' THEN 1  -- 'b' harfini oxiriga qo‘ydim
    ELSE 0 
END, letter;


--4.3
WITH OrderedLetters AS (
    SELECT letter, ROW_NUMBER() OVER (ORDER BY letter) AS rn
    FROM letters
    WHERE letter <> 'b'  -- 'b' dan boshqa hamma harflarni tartibladim
)
SELECT letter FROM OrderedLetters WHERE rn < 3  -- 1 va 2-o‘rindegi harflar
UNION ALL
SELECT 'b'  -- 3-o‘ringa 'b' ni qo‘shdim
UNION ALL
SELECT letter FROM OrderedLetters WHERE rn >= 3;  -- Qolgan harflar 4-o‘rindan keyin kelsin




