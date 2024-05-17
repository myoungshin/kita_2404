-- TASK1_0517. ���ǻ簡 '�½�����' Ȥ�� '���ѹ̵��'�� ������ �˻��Ͻÿ�. (3���� ���)
SELECT * FROM book
WHERE (publisher='�½�����') or (publisher='���ѹ̵��');


-- TASK2_0517. ���ǻ簡 '�½�����' Ȥ�� '���ѹ̵��'�� �ƴ� ������ �˻��Ͻÿ�. 
SELECT bookname, publisher FROM book
WHERE bookname not like '�౸�� ����';


-- TASK3_0517. �౸�� ���� ���� �� ������ 20,000�� �̻��� ������ �˻��Ͻÿ�.
SELECT bookname, price FROM book
WHERE bookname like '�౸' and price>=20000;


-- TASK4_0517. 2�� �迬�� ���� �ֹ��� ������ �� �Ǹž��� ���Ͻÿ�.
select sum(saleprice) as "�� �Ǹž�"
from orders
where custid=2;


--Task5_0517. ������ 8,000�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ� ������ �� ������ ���Ͻÿ�. 
--��, �� �� �̻� ������ ���� ���Ͻÿ�.
-- �̰� �� ���� Ʋ������?
SELECT custid, price, count(*) as ��������
from orders
where price>=8000
group by custid
having count(*)>2;


--Task6_0517. ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻��Ͻÿ�.
--select custid, name from customer;
--select custid, price from orders;
select customer.name, orders.saleprice
from customer join orders
on customer.custid=orders.custid;


--Task7_0517. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, ������ �����Ͻÿ�.
--�̰� �� �� �ȵǴ°���?
select customer.name, orders.sum(saleprice) as "�� �Ǹž�"
from customer join orders
on customer.custid=orders.custid;
