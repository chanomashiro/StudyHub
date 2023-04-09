CREATE VIEW EMP_V AS 
	select
	    emp.empno,
	    ename,
	    dname
	from emp
	    join dept on emp.deptno = dept.d
DEPTNO; 

create sequence order_seq;

select order_seq.NEXTVAL from dual;