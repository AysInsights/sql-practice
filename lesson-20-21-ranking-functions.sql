-- ================================================================
-- SQL Practice — Lesson 20
-- ROW_NUMBER, RANK, DENSE_RANK və PARTITION BY
-- HR Schema / Oracle FreeSQL
-- ================================================================

-- Tapşırıq 1
-- İşçiləri maaşa görə sıralayıb ROW_NUMBER verin.
-- ================================================================

SELECT employee_id,
       first_name || ' ' || last_name AS Tam_ad,
       salary AS Maas,
       ROW_NUMBER() OVER(ORDER BY salary) AS rn
FROM hr.employees;


-- ================================================================
-- Tapşırıq 2
-- Eyni sorğuya RANK və DENSE_RANK əlavə edin,
-- 3 sütunu müqayisə edin.
-- ================================================================

SELECT employee_id,
       first_name || ' ' || last_name AS Tam_ad,
       salary AS Maas,
       RANK() OVER(ORDER BY salary) AS rnk,
       DENSE_RANK() OVER(ORDER BY salary) AS drnk
FROM hr.employees;


-- ================================================================
-- Tapşırıq 3
-- Bərabərlik olan sıraları tapıb 3 funksiyanın fərqini izah edin.
-- ================================================================

-- Eyni maaş olduqda:
-- ROW_NUMBER hər işçiyə fərqli sıra nömrəsi verir.
-- RANK eyni maaşa eyni sıra verir və növbəti sırada boşluq yaradır.
-- DENSE_RANK eyni maaşa eyni sıra verir, amma boşluq yaratmır.


-- ================================================================
-- Tapşırıq 4
-- hire_date-ə görə ən son işə girən 5 nəfəri tapın (ROW_NUMBER).
-- ================================================================

SELECT *
FROM (
    SELECT first_name || ' ' || last_name AS Tam_ad,
           hire_date,
           ROW_NUMBER() OVER(ORDER BY hire_date DESC) AS rn
    FROM hr.employees
)
WHERE rn < 6;


-- ================================================================
-- Tapşırıq 5
-- Maaş üzrə ilk 10 işçini göstərin (Top-N).
-- ================================================================

SELECT *
FROM (
    SELECT first_name || ' ' || last_name AS Tam_ad,
           salary AS Maas,
           ROW_NUMBER() OVER(ORDER BY salary DESC) AS rn
    FROM hr.employees
)
WHERE rn < 11;


-- ================================================================
-- PARTITION BY ilə birlikdə
-- ================================================================

-- Tapşırıq 6
-- Hər şöbədə maaşa görə sıra nömrəsi verin (PARTITION BY).
-- ================================================================

SELECT employee_id,
       first_name || ' ' || last_name AS Tam_ad,
       department_id AS Sobe,
       salary AS Maas,
       ROW_NUMBER() OVER(
           PARTITION BY department_id
           ORDER BY salary DESC
       ) AS rn
FROM hr.employees;


-- ================================================================
-- Tapşırıq 7
-- Hər şöbənin ən yüksək maaşlı işçisini tapın (rnk = 1).
-- ================================================================

SELECT *
FROM (
    SELECT employee_id,
           first_name || ' ' || last_name AS Tam_ad,
           department_id AS Sobe,
           salary AS Maas,
           RANK() OVER(
               PARTITION BY department_id
               ORDER BY salary DESC
           ) AS rnk
    FROM hr.employees
)
WHERE rnk = 1;


-- ================================================================
-- Tapşırıq 8
-- Hər şöbənin TOP 3 işçisini tapın (alt-sorğu + WHERE).
-- ================================================================

SELECT *
FROM (
    SELECT employee_id,
           first_name || ' ' || last_name AS Tam_ad,
           department_id AS Sobe,
           salary AS Maas,
           ROW_NUMBER() OVER(
               PARTITION BY department_id
               ORDER BY salary DESC
           ) AS rn
    FROM hr.employees
)
WHERE rn < 4;


-- ================================================================
-- Tapşırıq 9
-- Hər vəzifə (job_id) üzrə ən yüksək maaşlı işçini tapın.
-- ================================================================

SELECT *
FROM (
    SELECT employee_id,
           first_name || ' ' || last_name AS Tam_ad,
           job_id,
           salary AS Maas,
           ROW_NUMBER() OVER(
               PARTITION BY job_id
               ORDER BY salary DESC
           ) AS rn
    FROM hr.employees
)
WHERE rn = 1;


-- ================================================================
-- Tapşırıq 10
-- Top-N-i həm RANK, həm ROW_NUMBER ilə yazıb fərqi göstərin.
-- ================================================================

SELECT employee_id,
       first_name || ' ' || last_name AS Tam_ad,
       department_id AS Sobe,
       salary AS Maas,
       ROW_NUMBER() OVER(ORDER BY salary DESC) AS rn,
       RANK() OVER(ORDER BY salary DESC) AS rnk
FROM hr.employees
ORDER BY salary DESC;
