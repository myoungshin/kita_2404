-- TASK1_0517. 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서를 검색하시오. (3가지 방법)
SELECT * FROM book
WHERE (publisher='굿스포츠') or (publisher='대한미디어');


-- TASK2_0517. 출판사가 '굿스포츠' 혹은 '대한미디어'가 아닌 도서를 검색하시오. 
SELECT bookname, publisher FROM book
WHERE bookname not like '축구의 역사';


-- TASK3_0517. 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하시오.
SELECT bookname, price FROM book
WHERE bookname like '축구' and price>=20000;


-- TASK4_0517. 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오.
select sum(saleprice) as "총 판매액"
from orders
where custid=2;


--Task5_0517. 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오. 
--단, 두 권 이상 구매한 고객만 구하시오.
-- 이건 또 뭐가 틀린거지?
SELECT custid, price, count(*) as 도서수량
from orders
where price>=8000
group by custid
having count(*)>2;


--Task6_0517. 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
--select custid, name from customer;
--select custid, price from orders;
select customer.name, orders.saleprice
from customer join orders
on customer.custid=orders.custid;


--Task7_0517. 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오.
--이건 또 왜 안되는거지?
select customer.name, orders.sum(saleprice) as "총 판매액"
from customer join orders
on customer.custid=orders.custid;
