CREATE TABLE
    emp (
        empno NUMBER(4),
        ename VARCHAR2(4 CHAR),
        job VARCHAR2(2 CHAR),
        sal NUMBER(6),
        age NUMBER(3),
        deptno NUMBER(4)
    );

CREATE TABLE
    dept (
        deptno NUMBER(4),
        dname VARCHAR2(3 CHAR),
        telno VARCHAR2(10)
    );

INSERT INTO emp VALUES(1001, '本山三郎', '営業', 720, 34, 2);

INSERT INTO emp VALUES(1002, '中村次郎', '総務', 720, 29, 2);

INSERT INTO emp VALUES(1003, '山田花子', '総務', 600, 31, 1);

INSERT INTO emp VALUES(1004, '三田海子', '技術', 720, 58, 3);

INSERT INTO emp VALUES(1005, '山本太郎', '技術', 900, 36, 1);

INSERT INTO emp VALUES(1006, '山田一太', '総務', 510, 22, 1);

INSERT INTO dept VALUES(2, '流通部', '0312345678');

INSERT INTO dept VALUES(1, '金融部', '0312345679');

INSERT INTO dept VALUES(3, '公共部', '0312345670');

INSERT INTO dept VALUES(4, '特別部', '0312345677');

COMMIT;

DROP TABLE emp;

DROP TABLE dept;

select dname || ':' ||
REPLACE (telno, '031234', '03-1234-') tel
from dept;

select sum(sal) from emp;

select job, count(*) from emp group by job having count(*) > 1;

create table tbl_null (i number, s varchar(16));

insert into tbl_null (i, s) values(5, '');

commit;

select * from tbl_null;

create table tbl_null2 (i number, s varchar2(16));

insert into tbl_null2 (i, s) values(5, '');

commit;

select avg(sal) from emp;

select ename, sal
from emp
where sal > (
        select avg(sal)
        from emp
    );

insert into emp values (1, '藤原頼朝', '社長', 2000, 52, NULL);

commit;