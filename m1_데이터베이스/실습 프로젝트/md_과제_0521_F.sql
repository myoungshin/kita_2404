-------------------------- 0521 Task ------------------------
-- [0521 실습 - 2인 1조]
-- 학교 관리를 위하여 테이블 2개 이상으로 db를 구축하고 3개 이상 활용할 수 있는 case를 만드세요.

-- // 필요한 테이블 //
-- T1. 학생 정보 # student_info
-- T2. 강의 정보 # lecture
-- T3. 교수 정보 # professor_info 
-- T4. 학생 성적 # student_gpa
-- T5. 강의실 정보 # class


------------- T1. 학생 정보 ---------------

drop table student_info;

create table student_info(
student_id number primary key,
name varchar2(30) not null,
gender varchar2(30) not null,
birthdate number(8) not null,
s_phone varchar2(15) not null,
s_email varchar2(50) not null,
s_address varchar2(50) not null
);

-- 학생 정보 삽입
INSERT INTO student_info (student_id, name, gender, birthdate, s_phone, s_email, s_address) 
VALUES (1, '김민수', 'f', 980523, '010-1111-2222', 'kimminji@naver.com', '서울특별시 강서구');

INSERT INTO student_info (student_id, name, gender, birthdate, s_phone, s_email, s_address) 
VALUES (2, '김영수', 'm', 920815, '010-1234-5678', 'kimys@naver.com', '강원도 춘천시');

INSERT INTO student_info (student_id, name, gender, birthdate, s_phone, s_email, s_address) 
VALUES(3, '이지은', 'f', 970210, '010-9876-5432', 'leeje@naver.com', '경기도 수원시');

INSERT INTO student_info (student_id, name, gender, birthdate, s_phone, s_email, s_address) 
VALUES(4, '박성민', 'm', 990523, '010-5555-6666', 'parksm@naver.com', '서울특별시 관악구');
INSERT INTO student_info (student_id, name, gender, birthdate, s_phone, s_email, s_address) 
VALUES(5, '정수현', 'f', 980403, '010-1111-2222', 'jsh@naver.com', '서울특별시 강남구');
INSERT INTO student_info (student_id, name, gender, birthdate, s_phone, s_email, s_address) 
VALUES(6, '최영진', 'm', 960702, '010-9999-8888', 'cyj@naver.com', '경기도 고양시');
INSERT INTO student_info (student_id, name, gender, birthdate, s_phone, s_email, s_address) 
VALUES(7, '김지원', 'f', 950320, '010-7777-3333', 'kimjw@naver.com', '서울특별시 동작구');
INSERT INTO student_info (student_id, name, gender, birthdate, s_phone, s_email, s_address) 
VALUES(8, '이승우', 'm', 940825, '010-1212-3434', 'leesw@naver.com', '서울특별시 영등포구');
INSERT INTO student_info (student_id, name, gender, birthdate, s_phone, s_email, s_address) 
VALUES(9, '박지현', 'f', 930527, '010-4545-6767', 'parkjh@naver.com', '경기도 안양시');
INSERT INTO student_info (student_id, name, gender, birthdate, s_phone, s_email, s_address) 
VALUES(10, '정민재', 'm', 910703, '010-1313-5757', 'jmj@naver.com', '대구광역시 중구');


------------- T2. 강의 정보 (lecture_info) ---------------
-- 필요 정보: 
create table lecture(
student_id number, -- 강의듣는 학생id
lecture_id number primary key, -- 강의 번호(수업코드)
lecture varchar2(30) not null, -- 강의이름
professor_id varchar2(8), -- 강의하는 교수이름
foreign key(student_id) references student_info(student_id),
foreign key(professor_id) references  professor_info(professor_id) on delete cascade
);

alter table lecture drop column student_id; -- <= student_id 불필요해서 제거.

-- 강의 테이블에 데이터 삽입
INSERT INTO lecture VALUES (1, 10, '마케팅 원론', 'B2101001');
INSERT INTO lecture VALUES (2, 11, '알고리즘', 'C2202002');
INSERT INTO lecture VALUES (3, 12, '회로이론', 'E2003003');
INSERT INTO lecture VALUES (4, 13, '기계 설계', 'M1904004');
INSERT INTO lecture VALUES (5, 14, '유기화학', 'H2305005');
INSERT INTO lecture VALUES (6, 15, '재무 관리', 'B2001006');
INSERT INTO lecture VALUES (7, 16, '운영체제', 'C1802007');
INSERT INTO lecture VALUES (8, 17, '디지털 신호 처리', 'E2103008');
INSERT INTO lecture VALUES (9, 18, '기계 재료', 'M1704009');
INSERT INTO lecture VALUES (10, 19, '공업화학', 'H1905010');

select*from lecture;


------------- T3. 교수 정보 ---------------
-- 필요 정보: professor_id, name, department, gender, birthdate, p_phone, p_email, p_address, lecture1, lecture2, lecture3, lecture4, num_lectures
create table professor_info(
professor_id varchar2(8) primary key,
name varchar2(50) not null,
department varchar2(50) not null,
lecture1 varchar2(50),
lecture2 varchar2(50),
lecture3 varchar2(50),
lecture4 varchar2(50),
num_lectures number(8));


-- 경영학과 (B, 부임년도: 2021, department code: 01)
INSERT INTO professor_info VALUES ('B2101001', '김온유', '경영학과','마케팅 원론', '브랜드 매니지먼트', '소비자 행동론', '', 3);

-- 컴퓨터공학과 (C, 부임년도: 2022, department code: 02)
INSERT INTO professor_info VALUES ('C2202002', '박지수', '컴퓨터공학과','알고리즘', '자료구조', '', '', 2);

-- 전기전자공학과 (E, 부임년도: 2020, department code: 03)
INSERT INTO professor_info VALUES ('E2003003', '이동현', '전기전자공학과', '회로이론', '전자기학', '신호와 시스템', '디지털 회로', 4);

-- 기계공학과 (M, 부임년도: 2019, department code: 04)
INSERT INTO professor_info VALUES ('M1904004', '최민호', '기계공학과', '기계 설계', '열역학', '', '', 2);

-- 화학공학과 (H, 부임년도: 2023, department code: 05)
INSERT INTO professor_info VALUES ('H2305005', '정수진', '화학공학과', '유기화학', '물리화학', '화학 반응공학', '화학공정', 4);

-- 경영학과 (B, 부임년도: 2020, department code: 01)
INSERT INTO professor_info VALUES ('B2001006', '이서준', '경영학과', '재무 관리', '경영 정보 시스템', '', '', 2);

-- 컴퓨터공학과 (C, 부임년도: 2018, department code: 02)
INSERT INTO professor_info VALUES ('C1802007', '김다은', '컴퓨터공학과','운영체제', '프로그래밍 언어', '컴퓨터 네트워크', '', 3);

-- 전기전자공학과 (E, 부임년도: 2021, department code: 03)
INSERT INTO professor_info VALUES ('E2103008', '박철민', '전기전자공학과', '디지털 신호 처리', '전자 회로 설계', '', '', 2);

-- 기계공학과 (M, 부임년도: 2017, department code: 04)
INSERT INTO professor_info VALUES ('M1704009', '유미래', '기계공학과', '기계 재료', '유체 역학', '제어 시스템', '', 3);

-- 화학공학과 (H, 부임년도: 2019, department code: 05)
INSERT INTO professor_info VALUES ('H1905010', '서준혁', '화학공학과', '공업화학', '화학공학개론', '반응속도론', '', 3);


select*from professor_info;

------------- T4. 학생 성적 ---------------
-- 필요 정보: student_id, management_id, department, major, semester1_gpa, semester_2_gpa
create table student_gpa(
student_id number,
management_id number primary key,
department varchar2(50) not null,
major varchar2(50) not null,
lecture1_id varchar2(50),
lecture2_id varchar2(50),
lecture3_id varchar2(50),
lecture4_id varchar2(50),
semester1 number,
semester2 number,
overall_gpa number,
foreign key(student_id) references student_info(student_id) on delete cascade
);

INSERT INTO student_gpa VALUES (1, 1, '경영학과', '국제 경영', '10', '12', '15', '19', 3.5, 3.7, (3.5+3.7) / 2);
INSERT INTO student_gpa VALUES (2, 2, '컴퓨터공학과', '소프트웨어 공학', '11', '13', '16', '18', 3.8, 4.0, (3.8 + 4.0) / 2);
INSERT INTO student_gpa VALUES (3, 3, '전기전자공학과', '통신 공학', '10', '14', '17', '19', 3.2, 3.4, (3.2 + 3.4) / 2);
INSERT INTO student_gpa VALUES (4, 4, '기계공학과', '기계 설계', '12', '13', '15', '18', 3.9, 4.1, (3.9 + 4.1) / 2);
INSERT INTO student_gpa VALUES (5, 5, '화학공학과', '환경 공학', '11', '14', '16', '17', 3.1, 3.3, (3.1 + 3.3) / 2);
INSERT INTO student_gpa VALUES (6, 6, '경영학과', '재무 관리', '10', '13', '17', '19', 3.6, 3.8, (3.6 + 3.8) / 2);
INSERT INTO student_gpa VALUES (7, 7, '컴퓨터공학과', '정보 보안', '12', '15', '16', '18', 3.7, 3.9, (3.7 + 3.9) / 2);
INSERT INTO student_gpa VALUES (8, 8, '전기전자공학과', '전력 공학', '11', '13', '14', '19', 3.4, 3.6, (3.4 + 3.6) / 2);
INSERT INTO student_gpa VALUES (9, 9, '기계공학과', '자동차 공학', '10', '12', '15', '17', 3.0, 3.2, (3.0 + 3.2) / 2);
INSERT INTO student_gpa VALUES (10, 10, '화학공학과', '바이오 공학', '11', '14', '16', '18', 3.5, 3.9, (3.5 + 3.9) / 2);


------------- T5. 강의 정보 ---------------
-- 강의 테이블
create table class(
lecture_id number, -- 수업 코드
class_id number, -- 강의실 코드
schedule date, -- 사용하는 날짜
class_time varchar2(30),
time number, -- 사용하는 시간
student_count number not null, --강의 듣는 학생수
foreign key(lecture_id) references lecture(lecture_id) on delete cascade
);

INSERT INTO class VALUES (10, 1, TO_DATE('2024-05-20', 'YYYY-MM-DD'), '1교시', 50, 20);

-- 2번 데이터 삽입
INSERT INTO class VALUES (11, 2, TO_DATE('2024-05-21', 'YYYY-MM-DD'), '2교시', 60, 25);

-- 3번 데이터 삽입
INSERT INTO class VALUES (12, 3, TO_DATE('2024-05-22', 'YYYY-MM-DD'), '1교시', 120, 15);

-- 4번 데이터 삽입
INSERT INTO class VALUES (13, 4, TO_DATE('2024-05-22', 'YYYY-MM-DD'), '2교시', 50, 18);

-- 5번 데이터 삽입
INSERT INTO class VALUES (14, 5, TO_DATE('2024-05-24', 'YYYY-MM-DD'), '1교시', 60, 10);

-- 6번 데이터 삽입
INSERT INTO class VALUES (15, 5, TO_DATE('2024-05-25', 'YYYY-MM-DD'), '2교시', 40, 22);

-- 7번 데이터 삽입
INSERT INTO class VALUES (16, 2, TO_DATE('2024-05-26', 'YYYY-MM-DD'), '3교시', 50, 17);

-- 8번 데이터 삽입
INSERT INTO class VALUES (17, 3, TO_DATE('2024-05-27', 'YYYY-MM-DD'), '3교시', 40, 13);

-- 9번 데이터 삽입
INSERT INTO class VALUES (18, 4, TO_DATE('2024-05-28', 'YYYY-MM-DD'), '1교시', 60, 28);

INSERT INTO class VALUES (19, 5, TO_DATE('2024-05-25', 'YYYY-MM-DD'), '4교시', 50, 28);


------------------

select*from student_info; -- 학생 인적 사항
select*from professor_info; -- 교수 강의 정보
select*from lecture; -- 강의 정보
select*from student_gpa; -- 학생 소속 학과 및 성적
select*from class; -- 강의실 정보


------ 케이스 ------
-- 케이스 1: department 별 학생 수
select department,count(*) 학생수
from student_gpa
group by department;


-- 케이스 2: 학생 이름, 소속 department, major 출력
select student_info.name, student_gpa.department, student_gpa.major
from student_info
left outer join student_gpa on student_info.student_id=student_gpa.student_id;


-- 케이스 3: 각 교시 별 수업 수
select substr(class_time,1,1) 교시 , count(*) 수업수
from class
group by substr(class_time,1,1)
order by substr(class_time,1,1);

select*from class;

-- 케이스 4: 현재 시스템 시간보다 이후에 강의하는 교수 명단+수업 날짜
select*from professor_info; -- <== professor_id, name
select*from lecture; -- <== lecture id, professor_id
select*from class; -- <== lecture id, schedule

select i.name,c.schedule
from lecture l join professor_info i
on l.professor_id = i.professor_id
join class c on c.lecture_id = l.lecture_id
where c.schedule > (select sysdate from dual);


-- 케이스 5: Department별 학생 평균 성적
select department, avg(overall_gpa) as 평균성적
from student_gpa
group by department
order by 평균성적 desc;


-- 케이스 6: 성적에 따른 장학금 여부
-- 4.3점 만점 기준임.
-- 1,2학기 성적이 3.8점이 넘고 평균 학점이 4.0 이상인 학생에게 장학금 수여
-- 평균 성적 기준으로 내림차순해서 컷

select student_info.name, student_gpa.semester1, student_gpa.semester2, student_gpa.overall_gpa
from student_info
left outer join student_gpa on student_info.student_id=student_gpa.student_id
where (student_gpa.semester1>=3.6 and student_gpa.semester2>=3.6) and 
student_gpa.overall_gpa>=3.8 -- where에서는 별칭을 사용 못함
order by overall_gpa desc;
















---------------

-- 케이스 6: lecture_id=10을 듣는 학생의 학번 ==> 원래 원하는 것은 '마케팅 원론' 듣는 학생의 이름
select student_id
from student_gpa
where lecture1_id=10 or lecture2_id=10 or lecture3_id=10 or lecture4_id=10 ;


-- 케이스 3: 1교시 수업을 듣는 학생의 이름을 구하세요.
select name
from student_info
where student_id in (select student_id
    from lecture
    where lecture_id in(
        select lecture_id
        from class
        where class_time like '1교시'));

-- 시스템 시간 보다 뒤에 수업하는 교수
select name
from professor_info
where professor_id in (select professor_id from lecture
where lecture_id in (select lecture_id from class where schedule > (select sysdate from dual)));
