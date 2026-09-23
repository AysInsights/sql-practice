-- ================================================================
-- SQL Practice — Lesson 19
-- OVER, PARTITION BY, LAG, LEAD və fərq
-- HR Schema / Oracle FreeSQL
-- ================================================================

-- Tapşırıq 1
-- Hər işçinin yanında şirkətin ümumi maaş fondunu göstərin (SUM OVER()).
-- ================================================================

SELECT first_name || ' ' || last_name AS Isci,
       SUM(salary) OVER() AS Umumi_fond
FROM hr.employees;


-- ================================================================
-- Tapşırıq 2
-- Hər işçinin yanında öz şöbəsinin ortasını göstərin (AVG OVER PARTITION).
-- ================================================================

SELECT first_name || ' ' || last_name AS Isci,
       AVG(salary) OVER(PARTITION BY department_id) AS Orta_maas
FROM hr.employees;


-- ================================================================
-- Tapşırıq 3
-- Hər işçinin şöbə fondundakı faiz payını hesablayın.
-- ================================================================

SELECT first_name || ' ' || last_name AS Isci,
       salary,
       ROUND(salary / SUM(salary) OVER(PARTITION BY department_id) * 100, 1) AS Pay_faizi
FROM hr.employees;


-- ================================================================
-- Tapşırıq 4
-- Hər şöbədə neçə işçi olduğunu hər sətirdə göstərin (COUNT OVER PARTITION).
-- ================================================================

SELECT department_id AS Sobe,
       COUNT(employee_id) OVER(PARTITION BY department_id) AS Isci_sayi
FROM hr.employees;


-- ================================================================
-- Tapşırıq 5
-- Hər işçini şöbə maksimumu ilə müqayisə edin (MAX OVER PARTITION).
-- ================================================================

SELECT first_name || ' ' || last_name AS Isci,
       salary,
       MAX(salary) OVER(PARTITION BY department_id) AS Max_maas
FROM hr.employees;


-- ================================================================
-- Tapşırıq 6
-- hire_date-ə görə işləyən cəm (running total) qurun.
-- ================================================================

SELECT first_name || ' ' || last_name AS Isci,
       salary,
       SUM(salary) OVER(PARTITION BY department_id ORDER BY hire_date) AS Cem_Maas
FROM hr.employees;


-- ================================================================
-- Tapşırıq 7
-- Maaşa görə sıralayıb LAG ilə əvvəlki maaşı göstərin.
-- ================================================================

SELECT first_name,
       last_name,
       salary,
       LAG(salary) OVER(ORDER BY salary) AS Evvelki
FROM hr.employees;


-- ================================================================
-- Tapşırıq 8
-- LEAD ilə sonrakı maaşı göstərin.
-- ================================================================

SELECT first_name,
       last_name,
       salary,
       LEAD(salary) OVER(ORDER BY salary) AS Sonraki
FROM hr.employees;


-- ================================================================
-- Tapşırıq 9
-- Hər işçinin özündən əvvəlki ilə maaş fərqini hesablayın.
-- ================================================================

SELECT first_name,
       last_name,
       salary,
       LAG(salary) OVER(ORDER BY salary) AS Evvelki,
       salary - LAG(salary) OVER(ORDER BY salary) AS Ferq
FROM hr.employees;


-- ================================================================
-- Tapşırıq 10
-- Sərhəddəki NULL-ları LAG(salary,1,0) ilə örtün.
-- ================================================================

SELECT first_name,
       last_name,
       salary,
       LAG(salary) OVER(ORDER BY salary) AS Onceki,
       salary - LAG(salary, 1, 0) OVER(ORDER BY salary) AS Ferq
FROM hr.employees;


-- ================================================================
-- Tapşırıq 11
-- Hər şöbə daxilində LAG işlədin (PARTITION BY department_id).
-- ================================================================

SELECT first_name,
       last_name,
       salary,
       department_id,
       LAG(salary) OVER(PARTITION BY department_id ORDER BY salary) AS Evvelki
FROM hr.employees;


-- ================================================================
-- Tapşırıq 12
-- hire_date-ə görə hər işçi ilə ondan sonra işə girən arasındakı gün fərqini tapın.
-- ================================================================

SELECT first_name,
       last_name,
       hire_date,
       LEAD(hire_date) OVER(ORDER BY hire_date) AS Sonraki,
       LEAD(hire_date) OVER(ORDER BY hire_date) - hire_date AS Ferq
FROM hr.employees;
