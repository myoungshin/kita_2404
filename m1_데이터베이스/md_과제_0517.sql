-- TASK1_0517. 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서를 검색하시오. (3가지 방법)
SELECT * FROM book
WHERE (publisher='굿스포츠') or (publisher='대한미디어');

-- 강사님 풀이:
SELECT * FROM book
WHERE publisher in ('굿스포츠','대한미디어');

-- 강사님 풀이:
SELECT * FROM book
WHERE publisher='굿스포츠' 
union 
select * from book 
where publisher='대한미디어';



-- TASK2_0517. 출판사가 '굿스포츠' 혹은 '대한미디어'가 아닌 도서를 검색하시오. 
SELECT bookname, publisher FROM book
WHERE bookname not like '축구의 역사';

-- 강사님 풀이:
SELECT * FROM book
WHERE publisher not in ('굿스포츠','대한미디어');



-- TASK3_0517. 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하시오.
SELECT bookname, price FROM book
WHERE bookname like '축구' and price>=20000;

-- 강사님 풀이:
--- %:  0개 이상의 임의의 문자
--_ : 정확히 1개의 임의의 문자
-- '축구'가 포함된 출판사
select bookname, publisher, price from book
where bookname like '%축구%' and price>=20000;



-- TASK4_0517. 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오.
select sum(saleprice) as "총 판매액"
from orders
where custid=2;

-- 강사님 풀이:
select customer.name, orders.custid, sum(orders.saleprice) as "총 판매액"
from orders, customer
where orders.custid=2 and orders.custid=customer.custid
group by customer.name, orders.custid;

-- 강사님 풀이:
select customer.name, orders.custid, sum(orders.saleprice)
from orders
inner join customer on orders.custid=customer.custid
where orders.custid=2
group by customer.name, orders.custid;



--Task5_0517. 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오. 
--단, 두 권 이상 구매한 고객만 구하시오.
-- 이건 또 뭐가 틀린거지?
SELECT custid, price, count(*) as 도서수량
from orders
where price>=8000
group by custid
having count(*)>2;

-- 강사님 풀이:
SELECT custid, count(*) as 도서수량
from orders
where saleprice>=8000
group by custid
having count(*)>=2;


--Task6_0517. 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
--select custid, name from customer;
--select custid, price from orders;
select customer.name, orders.saleprice
from customer join orders
on customer.custid=orders.custid;

-- 강사님 풀이 : DB 다운되면서 날아감. 하는 방식은 하단 Q 2개와 비슷해서 참고하기



--Task7_0517. 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오.
--이건 또 왜 안되는거지?
select customer.name, orders.sum(saleprice) as "총 판매액"
from customer join orders
on customer.custid=orders.custid;

---- 강사님 풀이 : DB 다운되면서 날아감. 하는 방식은 하단 Q 2개와 비슷해서 참고하기




-- Q. 고객의 이름과 고객이 주문한 도서의 이름을 구하시오.
select C.name, B.bookname
from customer C, book B, orders O
where C.custid=O.custid and O.bookid=B.bookid;

select customer.name, book.bookname
from orders
inner join customer on orders.custid=customer.custid
inner join book on orders.bookid=book.bookid;


-- Q. 가격이 20000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
-- saleprice from orders
-- name from customer
-- bookname from book

select C.name, B.bookname
from customer C, book B, orders O
where C.custid=O.custid and O.bookid=B.bookid and B.price=20000;




