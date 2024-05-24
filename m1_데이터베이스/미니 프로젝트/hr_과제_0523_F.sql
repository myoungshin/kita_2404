-- 작업 중 만든 view :
select*from hr_structure;
select*from income_by_departments;
select*from income_imbalanced;
select*from employees_yr;
select*from SA_employees;

--drop view hr_structure;
--drop view income_by_departments;
--drop view income_imbalanced;
--drop view employees_yr;
--drop view SA_employees; 

-- savepoint sq1;
-- employee_id : 178, department_id: null --> 80 수정 -- 
-- savepoint sq2;

-- select*from employees;
-- update employees set department_id=80 
-- where employee_id=178;

-- commit;

---------------------------------- [ Summary ] ------------------------------------ 
-- 1. 전반적인 인력 배치 및 구조 파악
-- 2. 부서별 연봉 차이 
-- 3. 동일 부서 내 동일 직무, 근무 기간 직원 사이의 연봉 불균형 확인
-- 4. Sales 부서 커미션 테이블 
-- 5. Sales 커미션 포함한 연봉 기준 직원들의 연봉 순위
-- 6. 장기근속 보너스 (5년단위)

-- 작업에 참고할 데이터 테이블 
select*from regions; -- 권역 리스트
select*from countries; -- 국가 리스트 
select*from locations;
select*from departments; -- 부서 별 매니저와 location 위치 (주소) 정보 

select*from employees;
select*from job_history;
select*from jobs;

------------------------ Case 1. 인력 배치 및 구조 파악 ---------------------------

-- << 국가별 직원수 >>
select l.country_id, count(*) 직원수
from locations l
join departments d on l.location_id=d.location_id
join employees e on d.department_id=e.department_id
join jobs j on e.job_id=j.job_id
group by l.country_id
order by 직원수 desc;

-- << 국가 > department > city > job_title 로 정리한 직원 수 >>

create view hr_structure as -- <== 뷰 생성함. 사용 시 주의!
select l.country_id, l.city, d.department_name, j.job_title, count(*) 직원수
from locations l
join departments d on l.location_id=d.location_id
join employees e on d.department_id=e.department_id
join jobs j on e.job_id=j.job_id
group by l.country_id, l.city, d.department_name, j.job_title
order by l.country_id, l.city, d.department_name, j.job_title;

select*from hr_structure;

-- 총 4개국, 7개 도시, 11개 부서, 19개 직무, 총 107명의 직원
-- 캐나다 (1): 토론토. 마케팅 부서만 존재, 매니저 1명과 rep 1명
-- 독일 (1): 뮌헨. PR 부서만 존재, PR rep 1명
-- 영국 (2): 런던. HR 부서만, HR rep 1명
--          옥스포드. Sales 부서만, 매니저 5명, rep 30명
-- 미국 (3) : 시에틀이 본사인듯? 
--           시에틀. 총 5부서. 
--                  - executive 회장 1명, 부회장 2명 
--                  - accounting. 매니저 1명, rep 1명
--                  - adnin. assistant 1명
--                  - finance. 매니저 1명, accountant 5명
--                  - purchasing. 매니저 1명, clerk 5명
--           샌프란시스코. shipping 부서만, stock 매니저 5명, stock clerk 20명, shipping clerk 20명
--           사우스레이크 (텍사스). IT. 프로그래머 5명
-- 각 부서가 위치하고 있는 국가/도시 또한 이상함
        -- 회장/부회장 & 회사 운영 주요 부서가 세이틀에 위치. 근데 마케팅, PR, HR은 유럽 3개국에 각각 흩어져 있음. 비효율적인 운영 체제가 아닌지? 
        -- 오피스를 따로 분리해두기 보다는 운영조직들은 한 곳에 모여 있는게 더 효율적이지 않을지?
        -- IT는 텍사스에 홀로 위치하고 있음. 그 이유는 무엇인지? 


------------------------- Case 2. 부서별 연봉 및 차이 정리 ------------------------------ 

-- 전체 직원 기준, 최소, 최대, 평균 연봉
select min(salary) min_salary, max(salary) max_salary, round(avg(salary),1) avg_salary
from employees;
-- 최소: 2100, 최대: 24000, 평균 6461.8

-- << 부서별 연봉 정보 (avg_salary 기준 내림차순) >>
select d.department_name, count(*)as "직원수", min(e.salary) min_salary, max(e.salary) max_salary, 
round(avg(e.salary),0) avg_salary, (max(e.salary)-min(e.salary)) "부서 최대최소차이", round(round(avg(e.salary),0)-6461.8) "전체 대비 부서 평균"
from departments d
join employees e on d.department_id=e.department_id
group by d.department_name
order by avg_salary desc;
-- 최고 avg salary 부서 == executive : 19333
-- 최저 avg salary 부서 == shipping : 3476

-- executive 제외한, 전체 직원 기준으로 avg_salary
select min(salary) min_salary, max(salary) max_salary, round(avg(salary),1) avg_salary
from employees
where department_id not like '90';
-- executive 제외한, 전체 직원 기준으로 avg_salary는 6081.7
select*from employees;

-- << executive 제외한, 부서별 연봉 정보. avg_salary 기준으로 내림차순 >>:
select d.department_name, count(*)as "직원수", min(e.salary) min_salary, max(e.salary) max_salary, 
round(avg(e.salary),0) avg_salary, (max(e.salary)-min(e.salary)) "부서 최대최소차이", (round(round(avg(e.salary),0)-6081.7)) "전체 대비 부서 평균"
from departments d
join employees e on d.department_id=e.department_id
where d.department_name not in ('Executive')
group by d.department_name
order by avg_salary desc;
-- 최고 avg salary 부서 == accounting : 10154. 평균대비 약 4000 정도 더 높음
-- 최저 avg salary 부서 == shipping : 3476. 평균 대비 약 2600 정도 더 낮음 
-- 부서별 연봉 차이가 큼. 다만, 직무 특성에 따라 업무 강도, 요구하는 스킬 등이 상이하여 제공된 데이터만으로는 불합리라고 판단하기에는 어려울 것으로 보임.


------------------------- Case 3. 연봉 불균형 확인 ------------------------------
-- << department별, job_id 별 연차별 최소, 최대, 평균 연봉 >>
--select*from departments; -- department_id, location_id, department_name
--select*from employees; -- job_id, department_id
--select*from jobs; -- job_id, job_title
create view income_by_departments as
select d.department_id, d.department_name, j.job_id, j.job_title, trunc(months_between(sysdate,e.hire_date)/12) "근속기간", count(*) 직원수, 
round(avg(e.salary),0) 평균연봉, round(min(e.salary),0) 최소연봉, round(max(e.salary),0) 최대연봉, round(max(e.salary),0)-round(min(e.salary),0) "연봉차이"
from jobs j
join employees e on j.job_id=e.job_id
join departments d on d.department_id=e.department_id
group by d.department_id, d.department_name, j.job_id, j.job_title, trunc(months_between(sysdate,e.hire_date)/12)
order by d.department_name, j.job_title, 근속기간 desc;

select*from income_by_departments;

------------ 동일 부서, 직무, 근속기간 내 연봉 차이 확인 ----------

select min(연봉차이), max(연봉차이), round(avg(연봉차이),1)
from income_by_departments
where 연봉차이 not in (0);
-- 최소: 100, 최대: 4200, 평균차이: 1233.3


-- << 연봉 불균형자들 케이스 (동일 직무, 근속기간 직원들 간의 연봉차가 1000 이상인 경우) >> :
create view income_imbalanced as
select*from income_by_departments
where 연봉차이 >=1000
order by department_id, 근속기간 desc;
--drop view income_imbalanced;
select*from income_imbalanced;

------ 근속기간 포함한 employee 정보 
create view employees_yr as
select employee_id, first_name ||' '|| last_name as "full name", email, phone_number, hire_date, trunc(months_between(sysdate,hire_date)/12) as 근속기간, 
salary, commission_pct, department_id, job_id
from employees;
--drop view employees_yr;  
select*from employees_yr;


-- IT 부서
select*from employees_yr
where job_id='IT_PROG'
order by 근속기간 desc, salary desc; 
-- 18년차 중 Alexander Hunold가 동일 직무의 동일 근속기간 직원들 대비 4200 더 많이 받음 (AH=9000, 그 외=4800)
        -- 근속기간 != 경력. 따라서, Hunold의 연봉이 불평등하게 높다라고 판단하기엔 어려움. 추가 데이터 필요. 다른 직원들 대비 경력과 경험이 더 풍부하고 일을 잘해서일 수도 있음
-- 17년차인 Bruce와 Diana의 급여도 6000: 4200으로 1800 차이 남

-- Sales 부서

--select*from employees_yr
--where job_id='SA_MAN' and 근속기간='19'
--order by salary desc;
-- 총 3명. 각 1500씩 차이. 입사일 순으로 샐러리 차이가 남.(약 2-3개월씩 차이남)

-- << SA_Rep 에서 연봉 튀는 직원들 >> 
select*from employees_yr
where job_id='SA_REP' and 근속기간 in ('17','18','19')
order by 근속기간 desc, hire_date asc, salary desc, commission_pct desc;
-- Clara Vishney는 Louise Doran 과 비슷한 시기 입사했음에도 불구하고 10500으로 연봉 차이가 3000이나 남. 
-- Harrison Bloom 또한 연봉이 10000으로 입사시기가 비슷한 직원들 사이에서 높음. 
-- Danielle Greene 또한 근속기간이 비슷한 직원들 대비 연봉이 2000 정도는 더 높음. 

--select*from employees_yr
--where job_id='SA_REP' and 근속기간='16'
--order by 근속기간 desc, hire_date asc, salary desc, commission_pct desc;
-- 8명에 걸쳐서 균등한 편
--
--select*from employees_yr
--where job_id='SA_REP' and 근속기간='20'
--order by 근속기간 desc, hire_date asc, salary desc, commission_pct desc;
-- 500씩 차이임
--select*from employees_yr;
--drop view employees_yr;


------------------------- Case 4. SA Department commission 테이블 ------------------------------
-- Sales department는 근속기간에 따라 커미션 차이가 있는 것으로 보임
create view SA_employees as
select*from employees_yr
where department_id=80
order by job_id asc, hire_date asc, commission_pct desc;

--------- << SA department의 직원 정보 >>
select*from SA_employees;

select job_id, substr(hire_date,2,1) 입사년도, count(*) 직원수, min(salary) 최소연봉, max(salary) 최대연봉, round(avg(salary),1) 평균연봉,
min(commission_pct) "최소 커미션", max(commission_pct) "최대 커미션", round(avg(commission_pct),2) "평균 커미션"
from SA_employees
group by job_id, substr(hire_date,2,1)
order by job_id, 입사년도;

-- SA department 커미션 테이블:
-- rep 레벨: 21년차 = 0.3~0.35
        --  20년차 = 0.25~0.3
        --  19년차 = 0.2~0.25 
        --  18년차 = 0.15
        --  17년차 = 0.1
-- 본 회사에서의 입사 시점 기준으로 커미션 테이블이 정해져 있는 듯한데, 이게 맞는지? 
-- 특히 Sales 부서의 경우 개인 역량에 따라 성과 차이가 많을텐데 년차에 따라서 bracket이 정해져 있는건 부적절해 보임. 
-- 더 잘하고자 하는 모티베이션 저하시킬 수 있을 듯
    -- 잘하는 사람은 더 잘하고 싶은 욕구가 떨어질 수 있고,
    -- 못하는 사람은 년차 차면 어차피 커미션 % 오를테니까, 라고 안일해질 수 있음


------------------------- Case 5. Sales department의 commission 포함 올해 연봉 ------------------------------
-- commission이 있을 경우 현재 연봉에 곱해서 연봉 순위
-- << 직원 임금 순 ** 커미션 있는 직원은 커미션 합쳐서 계산 >>
select first_name || ' ' || last_name 이름,
nvl((1+nvl(commission_pct,0)) * nvl(salary,0), nvl(salary,0)) 연봉,
rank() over (order by nvl((1+nvl(commission_pct,0)) * nvl(salary,0), nvl(salary,0)) desc) 순위
from employees;

-- << SA 부서의 직원 임금순 ** 커미션 포함 >>
select first_name || ' ' || last_name 이름, job_id,
salary "기존 급여" ,commission_pct 인센티브,
salary * (1+commission_pct) as "최종 급여",
rank () over (order by salary * (1+commission_pct) desc) 순위
from employees
where commission_pct is not null
order by "최종 급여" desc;


------------------------- Case 6. 근속 보너스 수령인 ------------------------------
-- 올해기준 근속기간
select first_name || ' ' || last_name 이름,
trunc(months_between(sysdate,hire_date)/12) 근속기간
from employees
order by 근속기간;


-- 올해기준 근속기간이 5로 나누었을 때 나머지가 0인 사람의 이름과 근속기간
-- << 근속 보너스 수령자 >>
select 이름, 근속기간
from(
select first_name || ' ' || last_name 이름,
trunc(months_between(sysdate,hire_date)/12) 근속기간
from employees)
where mod(근속기간,5) = 0;

-- 간편화 하기위해 view 생성
create view this_year_bonus as
(select 이름, 근속기간
from(
select first_name || ' ' || last_name 이름,
trunc(months_between(sysdate,hire_date)/12) 근속기간
from employees)
where mod(근속기간,5) = 0);
--drop view this_year_bonus;
select * from this_year_bonus;


-- 올해 근속기간이 5년 단위인 사람들의 이름, 근속기간, 보너스 비
select 이름, 근속기간,
case when 근속기간 = 5 then '200만원 지급 대상자'
when 근속기간 = 10 then '300만원 지급 대상자'
when 근속기간 = 15 then '400만원 지급 대상자'
when 근속기간 = 20 then '500만원 지급 대상자'
else '600만원 지급 대상자'
end "보너스 대상자"
from this_year_bonus;

commit;

