---------------------------- Task 0520 ----------------------------------------
-------------------------------------------------------------------------------

-- Task 1. 0520. 10개의 속성으로 구성되는 테이블 2개를 작성하세요. 
-- 단, foreign key를 적용하여 한쪽 테이블의 데이터를 삭제 시 다른 테이블의 관련되는 데이터도 모두 삭제되도록 하세요.
-- 모든 제약 조건을 사용해야함
-- 단, 각 테이블에 5개의 데이터를 입력하고 두번째 테이블에 첫번째 데이터를 참조하고 있는 속성을 선택하여 데이터 삭제

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
20240520001,'김','동원','Innovation','남',to_date('1980-10-03','YYYY-MM-DD'),'010-1234-1234',
'서울특별시 강남구', to_date('2004-11-23','YYYY-MM-DD'),'박성민');

insert into employee_info values(
20240520002,'강','수지','Innovation','여',to_date('1990-05-28','YYYY-MM-DD'),'010-1234-7890',
'서울특별시 강남구', to_date('2018-07-20','YYYY-MM-DD'),'박성민');

insert into employee_info values(
20240520003,'이','윤정','MSU','여',to_date('1978-12-31','YYYY-MM-DD'),'010-3456-1234',
'서울특별시 서초구', to_date('2004-11-23','YYYY-MM-DD'),'임혜랑');

insert into employee_info values(
20240520004,'임','원희','MSU','남',to_date('1975-01-21','YYYY-MM-DD'),'010-3456-5678',
'서울특별시 서초구', to_date('2004-11-23','YYYY-MM-DD'),'임혜랑');

insert into employee_info values(
20240520005,'진','이온','CEX','여',to_date('1998-04-16','YYYY-MM-DD'),'010-3456-4311',
'서울특별시 종로구', to_date('2020-06-08','YYYY-MM-DD'),'임태윤');


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
0001, '김동원', 20240520001, '그룹 회식', 
to_date('2024-05-01','YYYY-MM-DD'), 1000000, 'Innovation','박성민','approved','전혜경'); 

insert into activity_approval values(
0002, '진이온', 20240520005, '본부 회식', 
to_date('2024-04-09','YYYY-MM-DD'), 5800000, 'CEX','임태윤','approved','전혜경'); 

insert into activity_approval values(
0003, '진이온', 20240520005, '본부 회식', 
to_date('2024-04-01','YYYY-MM-DD'), 200000, 'CEX','임태윤','approved','전혜경'); 

insert into activity_approval values(
0004, '강수지', 20240520002, '팀 회식', 
to_date('2024-03-22','YYYY-MM-DD'), 180000, 'Innovation','박성민', 'approved','전혜경'); 

insert into activity_approval values(
0005, '강수지', 20240520002, '팀 회식', 
to_date('2024-03-20','YYYY-MM-DD'), 98000, 'Innovation','박성민', 'approved','전혜경'); 

delete from employee_info
where employee_id=20240520002;

select*from employee_info;
select*from activity_approval;


--Task2_0520. Customer 테이블에서 박세리 고객의 주소를 김연아 고객의 주소로 변경하시오.
-- 필요 정보: 
-- address from customer
select*from customer;
select*from orders;
select*from book;

update customer
set address=(select address from customer where name like '김연아')
where name='박세리';


--Task3_0520.도서 제목에 ‘야구’가 포함된 도서를 ‘농구’로 변경한 후 도서 목록, 가격을 보이시오.
select*from customer;
select*from orders;
select*from book;

update book
set bookname='농구' -- <== '야구'라는 단어를 '농구'로만 바꾸는 방법은 뭐지? 제목이 '농구'로만 바뀜
where bookname like '%야구%';

select bookname, price from book
where bookname like '%농구%';


--Task4_0520. 마당서점의 고객 중에서 같은 성(姓)을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하시오.
select*from customer;
select*from book;
select*from orders;

select name
from customer 
where name like '박_%'
;


--Task5_0520. 마당서점은 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하시오.
select*from customer;
select*from book;
select*from orders;

-- 1. 주문 확정일자를 받을 열 추가해주고
alter table orders add order_confirmed date;
-- 2. 주문 확정일자 열에 데이터 추가 - orderdate에서 +10 계산해서 들어가는지 고민 필요
update orders
set order_confirmed=(select orderdate+10 from orders)
where order_confirmed=null; 



--Task6_0520.마당서점이 2020년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 보이시오. 
--단 주문일은 ‘yyyy-mm-dd 요일’ 형태로 표시한다.



--Task7_0520. 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오.



--Task8_0520. '대한민국’에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.


