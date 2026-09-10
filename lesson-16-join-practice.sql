-- ============================================================
-- SQL PRACTICE - LESSON 15
-- JOIN, INNER JOIN və LEFT JOIN
-- Oracle FreeSQL / HR.EMPLOYEES
-- ============================================================


-- ============================================================
-- INNER JOIN
-- ============================================================


-- Tapşırıq 1
-- Hər işçinin adı, soyadı və şöbə adını göstərin.
-- ============================================================

SELECT first_name,
       last_name,
       department_name
FROM hr.employees e
JOIN hr.departments d
    ON e.department_id = d.department_id;


-- ============================================================
-- Tapşırıq 2
-- Hər işçinin adı və VƏZİFƏ adını göstərin (jobs cədvəli).
-- ============================================================

SELECT first_name,
       job_title
FROM hr.employees e
JOIN hr.jobs j
    ON e.job_id = j.job_id;


-- ============================================================
-- Tapşırıq 3
-- Yalnız 'IT' şöbəsində işləyənləri tapın (JOIN + WHERE).
-- ============================================================

SELECT first_name,
       last_name,
       department_name
FROM hr.employees e
JOIN hr.departments d
    ON e.department_id = d.department_id
WHERE department_name = 'IT';


-- ============================================================
-- Tapşırıq 4
-- İşçi, şöbə və ŞƏHƏR adını birlikdə göstərin (3 cədvəl).
-- ============================================================

SELECT first_name || ' ' || last_name AS Tam_ad,
       department_name,
       city
FROM hr.employees e
JOIN hr.departments d
    ON e.department_id = d.department_id
JOIN hr.locations l
    ON d.location_id = l.location_id;


-- ============================================================
-- Tapşırıq 5
-- Maaşı 10000-dən çox olan işçilər və şöbələri.
-- ============================================================

SELECT first_name || ' ' || last_name AS Tam_ad,
       salary,
       department_name
FROM hr.employees e
JOIN hr.departments d
    ON e.department_id = d.department_id
WHERE salary > 10000;


-- ============================================================
-- Tapşırıq 6
-- JOIN-li sorğuda COUNT(*) yazıb 107 ilə müqayisə edin.
-- ============================================================

SELECT COUNT(first_name)
FROM hr.employees e
INNER JOIN hr.departments d
    ON e.manager_id = d.manager_id;


-- ============================================================
-- LEFT JOIN
-- ============================================================


-- Tapşırıq 7
-- Bütün 107 işçini şöbə adı ilə göstərin (heç kim itməsin).
-- ============================================================

SELECT first_name,
       department_name
FROM hr.employees e
LEFT JOIN hr.departments d
    ON e.department_id = d.department_id;


-- ============================================================
-- Tapşırıq 8
-- Şöbəsi olmayan işçini tapın.
-- ============================================================

SELECT first_name,
       department_name
FROM hr.employees e
LEFT JOIN hr.departments d
    ON e.department_id = d.department_id
WHERE d.department_id IS NULL;


-- ============================================================
-- Tapşırıq 9
-- Bütün şöbələri işçi sayı ilə göstərin (boş şöbələr də görünsün).
-- ============================================================

SELECT department_name,
       COUNT(e.employee_id) AS isci_sayi
FROM hr.employees e
RIGHT JOIN hr.departments d
    ON e.department_id = d.department_id
GROUP BY department_name;


-- ============================================================
-- Tapşırıq 10
-- Heç bir işçisi olmayan şöbələri sadalayın.
-- ============================================================

SELECT department_name AS sobe,
       COUNT(e.employee_id) AS isci_sayi
FROM hr.employees e
RIGHT JOIN hr.departments d
    ON e.department_id = d.department_id
GROUP BY department_name
HAVING COUNT(e.employee_id) = 0;


-- ============================================================
-- Tapşırıq 11
-- NVL ilə şöbəsizlərə 'Təyin edilməyib' yazdırın.
-- ============================================================

SELECT e.first_name || ' ' || e.last_name AS tam_ad,
       NVL(department_name, 'Teyin edilmeyib') AS Sobe
FROM hr.employees e
LEFT JOIN hr.departments d
    ON e.department_id = d.department_id;


-- ============================================================
-- Tapşırıq 12
-- Hər şöbədə işçi sayı: LEFT JOIN + GROUP BY + ORDER BY.
-- ============================================================

SELECT department_name AS Sobe,
       COUNT(e.employee_id) AS isci_sayi
FROM hr.employees e
RIGHT JOIN hr.departments d
    ON e.department_id = d.department_id
GROUP BY department_name
ORDER BY isci_sayi DESC;


--Analitik sual 1-Hər şəhərdə neçə işçi işləyir? (3 cədvəl + GROUP BY)-------------------------------------------

select city, count(EMPLOYEE_ID) isci_sayi
    from hr.locations l
    left join hr.DEPARTMENTS d
        on l.location_id = d.location_id
           left join hr.EMPLOYEES e
                on e.DEPARTMENT_ID = d.DEPARTMENT_ID
                    group by city order by isci_sayi desc

-------------------------------------------------------------

--Analitik sual 2-Hansı şöbənin ümumi maaş fondu ən böyükdür? (JOIN + SUM)-------------------------------------------

select department_name, sum(salary) umumi_maas
    from hr.EMPLOYEES e
    left join hr.DEPARTMENTS d
        on e.DEPARTMENT_ID = d.DEPARTMENT_ID
            group by department_name
                order by umumi_maas desc
                    fetch first 1 row only

-------------------------------------------------------------

--Analitik sual 3-Hər vəzifə üzrə orta maaşı vəzifə ADI ilə göstərin-------------------------------------------------

select job_title vezife_adi, round(avg(salary),2) orta_maas
    from hr.EMPLOYEES e
    right join hr.jobs j
        on e.job_id = j.job_id
            group by job_title
                order by orta_maas desc
            
 --------------------------------------------------------------   
