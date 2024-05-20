-- TASK1_0517. ���ǻ簡 '�½�����' Ȥ�� '���ѹ̵��'�� ������ �˻��Ͻÿ�. (3���� ���)
SELECT * FROM book
WHERE (publisher='�½�����') or (publisher='���ѹ̵��');

-- ����� Ǯ��:
SELECT * FROM book
WHERE publisher in ('�½�����','���ѹ̵��');

-- ����� Ǯ��:
SELECT * FROM book
WHERE publisher='�½�����' 
union 
select * from book 
where publisher='���ѹ̵��';



-- TASK2_0517. ���ǻ簡 '�½�����' Ȥ�� '���ѹ̵��'�� �ƴ� ������ �˻��Ͻÿ�. 
SELECT bookname, publisher FROM book
WHERE bookname not like '�౸�� ����';

-- ����� Ǯ��:
SELECT * FROM book
WHERE publisher not in ('�½�����','���ѹ̵��');



-- TASK3_0517. �౸�� ���� ���� �� ������ 20,000�� �̻��� ������ �˻��Ͻÿ�.
SELECT bookname, price FROM book
WHERE bookname like '�౸' and price>=20000;

-- ����� Ǯ��:
--- %:  0�� �̻��� ������ ����
--_ : ��Ȯ�� 1���� ������ ����
-- '�౸'�� ���Ե� ���ǻ�
select bookname, publisher, price from book
where bookname like '%�౸%' and price>=20000;



-- TASK4_0517. 2�� �迬�� ���� �ֹ��� ������ �� �Ǹž��� ���Ͻÿ�.
select sum(saleprice) as "�� �Ǹž�"
from orders
where custid=2;

-- ����� Ǯ��:
select customer.name, orders.custid, sum(orders.saleprice) as "�� �Ǹž�"
from orders, customer
where orders.custid=2 and orders.custid=customer.custid
group by customer.name, orders.custid;

-- ����� Ǯ��:
select customer.name, orders.custid, sum(orders.saleprice)
from orders
inner join customer on orders.custid=customer.custid
where orders.custid=2
group by customer.name, orders.custid;



--Task5_0517. ������ 8,000�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ� ������ �� ������ ���Ͻÿ�. 
--��, �� �� �̻� ������ ���� ���Ͻÿ�.
-- �̰� �� ���� Ʋ������?
SELECT custid, price, count(*) as ��������
from orders
where price>=8000
group by custid
having count(*)>2;

-- ����� Ǯ��:
SELECT custid, count(*) as ��������
from orders
where saleprice>=8000
group by custid
having count(*)>=2;


--Task6_0517. ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻��Ͻÿ�.
--select custid, name from customer;
--select custid, price from orders;
select customer.name, orders.saleprice
from customer join orders
on customer.custid=orders.custid;

-- ����� Ǯ�� : DB �ٿ�Ǹ鼭 ���ư�. �ϴ� ����� �ϴ� Q 2���� ����ؼ� �����ϱ�



--Task7_0517. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, ������ �����Ͻÿ�.
--�̰� �� �� �ȵǴ°���?
select customer.name, orders.sum(saleprice) as "�� �Ǹž�"
from customer join orders
on customer.custid=orders.custid;

---- ����� Ǯ�� : DB �ٿ�Ǹ鼭 ���ư�. �ϴ� ����� �ϴ� Q 2���� ����ؼ� �����ϱ�




-- Q. ���� �̸��� ���� �ֹ��� ������ �̸��� ���Ͻÿ�.
select C.name, B.bookname
from customer C, book B, orders O
where C.custid=O.custid and O.bookid=B.bookid;

select customer.name, book.bookname
from orders
inner join customer on orders.custid=customer.custid
inner join book on orders.bookid=book.bookid;


-- Q. ������ 20000���� ������ �ֹ��� ���� �̸��� ������ �̸��� ���Ͻÿ�.
-- saleprice from orders
-- name from customer
-- bookname from book

select C.name, B.bookname
from customer C, book B, orders O
where C.custid=O.custid and O.bookid=B.bookid and B.price=20000;




