-- ============================================================
-- SQL PRACTICE - LESSON 14
-- Aggregate Functions, GROUP BY və HAVING
-- Oracle FreeSQL / HR.EMPLOYEES
-- ============================================================


-- ============================================================
-- Tapşırıq 1
-- Şirkətdə neçə işçi var? (COUNT)
-- ============================================================

SELECT COUNT(*) AS isci_sayi
FROM hr.employees;


-- ============================================================
-- Tapşırıq 2
-- Bütün işçilərin ümumi maaş fondu nə qədərdir? (SUM)
-- ============================================================

SELECT COUNT(*) AS isci_sayi,
       SUM(salary) AS maas
FROM hr.employees;


-- ============================================================
-- Tapşırıq 3
-- Orta maaş nədir? ROUND ilə 2 onluğa yuvarlaqlaşdırın.
-- ============================================================

SELECT ROUND(AVG(salary), 2) AS orta_maas
FROM hr.employees;


-- ============================================================
-- Tapşırıq 4
-- Ən yüksək və ən aşağı maaşı tapın. (MAX, MIN)
-- ============================================================

SELECT MAX(salary) AS max_maas
FROM hr.employees;

-- SELECT MIN(salary) AS min_maas
-- FROM hr.employees;


-- ============================================================
-- Tapşırıq 5
-- Neçə fərqli job_id var? (COUNT DISTINCT)
-- ============================================================

SELECT COUNT(DISTINCT job_id) AS say_jobid
FROM hr.employees;


-- ============================================================
-- Tapşırıq 6
-- COUNT(*) və COUNT(department_id) yazıb fərqi izah edin.
-- ============================================================

SELECT COUNT(*) AS "butun_idler"
FROM hr.employees;

-- SELECT COUNT(department_id) AS "melumat_yazilan_idler"
-- FROM hr.employees;


-- ============================================================
-- Tapşırıq 7
-- Yalnız 80-ci şöbənin orta maaşını tapın. (WHERE + AVG)
-- ============================================================

SELECT ROUND(AVG(salary), 2) AS orta_maas
FROM hr.employees
WHERE department_id = 80;


-- ============================================================
-- Tapşırıq 8
-- Komissiya alan neçə işçi var? (COUNT(commission_pct))
-- ============================================================

SELECT COUNT(commission_pct) AS isci_sayi
FROM hr.employees;


-- ============================================================
-- Tapşırıq 9
-- AVG(commission_pct) və AVG(NVL(commission_pct,0))
-- yazıb fərqi müqayisə edin.
-- ============================================================

SELECT ROUND(AVG(commission_pct), 2) AS orta_komissiya
FROM hr.employees;

-- SELECT ROUND(AVG(NVL(commission_pct, 0)), 2) AS orta_komissiya
-- FROM hr.employees;


-- ============================================================
-- Tapşırıq 10
-- Ən erkən və ən son işə qəbul tarixini tapın.
-- (MIN/MAX hire_date)
-- ============================================================

SELECT MAX(hire_date) AS son_iq
FROM hr.employees;

-- SELECT MIN(hire_date) AS ilk_iq
-- FROM hr.employees;


-- ============================================================
-- Tapşırıq 11
-- Maaşı 10000-dən çox olanların sayı və ümumi maaşı
-- ============================================================

SELECT COUNT(*) AS isci_sayi,
       SUM(salary) AS umumi_maas
FROM hr.employees
WHERE salary > 10000;


-- ============================================================
-- Tapşırıq 12
-- job_id 'IT%' ilə başlayanların orta maaşı
-- ============================================================

SELECT AVG(salary) AS orta_maas
FROM hr.employees
WHERE job_id LIKE 'IT%';


-- ============================================================
-- GROUP BY
-- ============================================================


-- ============================================================
-- Tapşırıq 13
-- Hər şöbədə neçə işçi var? (department_id üzrə COUNT)
-- ============================================================

SELECT department_id,
       COUNT(*) AS isci_sayi
FROM hr.employees
GROUP BY department_id
ORDER BY department_id DESC;


-- ============================================================
-- Tapşırıq 14
-- Hər şöbənin orta, minimum və maksimum maaşını göstərin.
-- ============================================================

SELECT department_id,
       ROUND(AVG(salary), 2) AS orta_maas,
       MAX(salary) AS max_maas,
       MIN(salary) AS min_maas
FROM hr.employees
GROUP BY department_id
ORDER BY department_id DESC;


-- ============================================================
-- Tapşırıq 15
-- Hər job_id üzrə işçi sayı və ümumi maaş
-- ============================================================

SELECT job_id,
       COUNT(*) AS isci_sayi,
       SUM(salary) AS umumi_maas
FROM hr.employees
GROUP BY job_id;


-- ============================================================
-- Tapşırıq 16
-- department_id + job_id üzrə qruplaşdırın (iki sütun)
-- ============================================================

SELECT department_id,
       job_id,
       SUM(salary) AS umumi_maas
FROM hr.employees
GROUP BY department_id,
         job_id
ORDER BY department_id DESC;


-- ============================================================
-- Tapşırıq 17
-- Hər şöbənin ümumi maaş fondunu tapıb azalan sırada sıralayın.
-- ============================================================

SELECT department_id,
       SUM(salary) AS umumi_maas
FROM hr.employees
GROUP BY department_id
ORDER BY SUM(salary) DESC;


-- ============================================================
-- Tapşırıq 18
-- Hər manager_id üzrə cədvəldəki işçi sayını hesablayın.
-- ============================================================

SELECT manager_id,
       COUNT(*) AS isci_sayi
FROM hr.employees
GROUP BY manager_id;


-- ============================================================
-- HAVING
-- ============================================================


-- ============================================================
-- Tapşırıq 19
-- Yalnız 5-dən çox işçisi olan şöbələri göstərin.
-- ============================================================

SELECT department_id,
       COUNT(*) AS isci_sayi
FROM hr.employees
GROUP BY department_id
HAVING COUNT(*) > 5;


-- ============================================================
-- Tapşırıq 20
-- Orta maaşı 8000-dən çox olan şöbələri tapın.
-- ============================================================

SELECT department_id,
       COUNT(*) AS isci_sayi,
       ROUND(AVG(salary), 2) AS orta_maas
FROM hr.employees
GROUP BY department_id
HAVING AVG(salary) > 8000;


-- ============================================================
-- Tapşırıq 21
-- Ümumi maaş fondu 50000-dən çox olan şöbələr
-- ============================================================

SELECT department_id,
       COUNT(*) AS isci_sayi,
       SUM(salary) AS umumi_maas
FROM hr.employees
GROUP BY department_id
HAVING SUM(salary) > 50000;


-- ============================================================
-- Tapşırıq 22
-- WHERE və HAVING-i bir sorğuda birlikdə işlədin.
-- Məsələn, yalnız 2005-dən sonra işə girənlər üzrə.
-- ============================================================

SELECT department_id,
       COUNT(*) AS isci_sayi
FROM hr.employees
WHERE hire_date > DATE '2015-01-01'
GROUP BY department_id
HAVING COUNT(*) > 0;


-- ============================================================
-- Tapşırıq 23
-- Eyni job_id-də 3-dən çox işçisi olan vəzifələri tapın.
-- ============================================================

SELECT job_id,
       COUNT(*) AS isci_sayi
FROM hr.employees
GROUP BY job_id
HAVING COUNT(*) > 3;


-- ============================================================
-- Tapşırıq 24
-- HAVING-də alias işlədib xəta alın, sonra düzəldin.
-- (Öyrənmək üçün)
-- ============================================================

SELECT department_id,
       COUNT(*) AS isci_sayi
FROM hr.employees
GROUP BY department_id
HAVING COUNT(*) > 5;


-- ============================================================
-- BİZNES SUALLARI
-- ============================================================


-- ============================================================
-- Biznes sualı 1
-- Hansı şöbə ən bahalıdır? (ümumi maaş fondu üzrə)
-- ============================================================

SELECT department_id,
       SUM(salary) AS umumi_maas
FROM hr.employees
GROUP BY department_id
ORDER BY SUM(salary) DESC
FETCH FIRST 1 ROWS ONLY;


-- ============================================================
-- Biznes sualı 2
-- Hansı şöbədə maaş fərqi ən böyükdür? (MAX - MIN)
-- ============================================================

SELECT department_id,
       MAX(salary) - MIN(salary) AS maas_ferqi
FROM hr.employees
GROUP BY department_id
ORDER BY maas_ferqi DESC
FETCH FIRST 1 ROWS ONLY;


-- ============================================================
-- Biznes sualı 3
-- Orta maaşı ən yüksək 3 vəzifə hansılardır?
-- ============================================================

SELECT job_id,
       AVG(salary) AS orta_maas
FROM hr.employees
GROUP BY job_id
ORDER BY orta_maas DESC
FETCH FIRST 3 ROWS ONLY;

