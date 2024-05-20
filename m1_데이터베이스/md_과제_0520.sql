---------------------------- Task 0520 ----------------------------------------
-------------------------------------------------------------------------------

-- Task 1. 0520. 10���� �Ӽ����� �����Ǵ� ���̺� 2���� �ۼ��ϼ���. 
-- ��, foreign key�� �����Ͽ� ���� ���̺��� �����͸� ���� �� �ٸ� ���̺��� ���õǴ� �����͵� ��� �����ǵ��� �ϼ���.
-- ��� ���� ������ ����ؾ���
-- ��, �� ���̺� 5���� �����͸� �Է��ϰ� �ι�° ���̺� ù��° �����͸� �����ϰ� �ִ� �Ӽ��� �����Ͽ� ������ ����

-- table 1: employee_info 
create table employee_info(
employee_id varchar2(50) primary key,
first_name varchar2(50) not null,
last_name varchar2(50) not null,
service_line varchar2(50) not null,
sex varchar2(10) not null,
birthday date not null,
mobile varchar2(50) not null,
address varchar2(50) not null,
entry_date date not null,
manager varchar2(50) not null);

insert into employee_info values(
20240520001,'��','����','Innovation','��',to_date('1980-10-03','YYYY-MM-DD'),'010-1234-1234',
'����Ư���� ������', to_date('2004-11-23','YYYY-MM-DD'),'�ڼ���');

insert into employee_info values(
20240520002,'��','����','Innovation','��',to_date('1990-05-28','YYYY-MM-DD'),'010-1234-7890',
'����Ư���� ������', to_date('2018-07-20','YYYY-MM-DD'),'�ڼ���');

insert into employee_info values(
20240520003,'��','����','MSU','��',to_date('1978-12-31','YYYY-MM-DD'),'010-3456-1234',
'����Ư���� ���ʱ�', to_date('2004-11-23','YYYY-MM-DD'),'������');

insert into employee_info values(
20240520004,'��','����','MSU','��',to_date('1975-01-21','YYYY-MM-DD'),'010-3456-5678',
'����Ư���� ���ʱ�', to_date('2004-11-23','YYYY-MM-DD'),'������');

insert into employee_info values(
20240520005,'��','�̿�','CEX','��',to_date('1998-04-16','YYYY-MM-DD'),'010-3456-4311',
'����Ư���� ���α�', to_date('2020-06-08','YYYY-MM-DD'),'������');


-- table 2: activity_approval 
create table activity_approval(
idx number not null,
reporter varchar2(50) not null,
employee_id varchar2(50) not null,
activity varchar2(50) not null,
activity_date date not null,
amount number not null,
service_line_name varchar2(50) not null,
head_of_SL varchar2(50) not null,
approval_status varchar2(50) not null,
approved_by varchar2(50) not null,
primary key(idx),
foreign key(employee_id) references employee_info(employee_id) on delete cascade);


insert into activity_approval values(
0001, '�赿��', 20240520001, '�׷� ȸ��', 
to_date('2024-05-01','YYYY-MM-DD'), 1000000, 'Innovation','�ڼ���','approved','������'); 

insert into activity_approval values(
0002, '���̿�', 20240520005, '���� ȸ��', 
to_date('2024-04-09','YYYY-MM-DD'), 5800000, 'CEX','������','approved','������'); 

insert into activity_approval values(
0003, '���̿�', 20240520005, '���� ȸ��', 
to_date('2024-04-01','YYYY-MM-DD'), 200000, 'CEX','������','approved','������'); 

insert into activity_approval values(
0004, '������', 20240520002, '�� ȸ��', 
to_date('2024-03-22','YYYY-MM-DD'), 180000, 'Innovation','�ڼ���', 'approved','������'); 

insert into activity_approval values(
0005, '������', 20240520002, '�� ȸ��', 
to_date('2024-03-20','YYYY-MM-DD'), 98000, 'Innovation','�ڼ���', 'approved','������'); 

delete from employee_info
where employee_id=20240520002;

select*from employee_info;
select*from activity_approval;


--Task2_0520. Customer ���̺��� �ڼ��� ���� �ּҸ� �迬�� ���� �ּҷ� �����Ͻÿ�.
-- �ʿ� ����: 
-- address from customer
select*from customer;
select*from orders;
select*from book;

update customer
set address=(select address from customer where name like '�迬��')
where name='�ڼ���';


--Task3_0520.���� ���� ���߱����� ���Ե� ������ ���󱸡��� ������ �� ���� ���, ������ ���̽ÿ�.
select*from customer;
select*from orders;
select*from book;

update book
set bookname='��' -- <== '�߱�'��� �ܾ '��'�θ� �ٲٴ� ����� ����? ������ '��'�θ� �ٲ�
where bookname like '%�߱�%';

select bookname, price from book
where bookname like '%��%';


--Task4_0520. ���缭���� �� �߿��� ���� ��(��)�� ���� ����� �� ���̳� �Ǵ��� ���� �ο����� ���Ͻÿ�.
select*from customer;
select*from book;
select*from orders;

select name
from customer 
where name like '��_%'
;


--Task5_0520. ���缭���� �ֹ��Ϸκ��� 10�� �� ������ Ȯ���Ѵ�. �� �ֹ��� Ȯ�����ڸ� ���Ͻÿ�.
select*from customer;
select*from book;
select*from orders;

-- 1. �ֹ� Ȯ�����ڸ� ���� �� �߰����ְ�
alter table orders add order_confirmed date;
-- 2. �ֹ� Ȯ������ ���� ������ �߰� - orderdate���� +10 ����ؼ� ������ ��� �ʿ�
update orders
set order_confirmed=(select orderdate+10 from orders)
where order_confirmed=null; 



--Task6_0520.���缭���� 2020�� 7�� 7�Ͽ� �ֹ����� ������ �ֹ���ȣ, �ֹ���, ����ȣ, ������ȣ�� ��� ���̽ÿ�. 
--�� �ֹ����� ��yyyy-mm-dd ���ϡ� ���·� ǥ���Ѵ�.



--Task7_0520. ��� �ֹ��ݾ� ������ �ֹ��� ���ؼ� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.



--Task8_0520. '���ѹα����� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�.


