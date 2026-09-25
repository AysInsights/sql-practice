-- ============================================================
-- Dərs 22 — Subqueries / IN / NOT IN / ALL / ANY
-- HR.EMPLOYEES
-- ============================================================


-- ============================================================
-- Tapşırıq 1
-- İşçiləri maaşa görə şirkət ortalamasından yuxarı olanlarla tap.
-- ============================================================

SELECT first_name,
       salary,
       ROUND(AVG(salary) OVER(), 2) AS orta_maas
FROM hr.employees
WHERE salary > (
    SELECT AVG(salary)
    FROM hr.employees
);


-- ============================================================
-- Tapşırıq 2
-- Ən yüksək maaşı alan işçi(lər)i tap.
-- ============================================================

SELECT first_name || ' ' || last_name AS Isci,
       salary,
       department_id
FROM hr.employees
WHERE salary = (
    SELECT MAX(salary)
    FROM hr.employees
);


-- ============================================================
-- Tapşırıq 3
-- Ən son işə qəbul olunan işçi(lər)i tap.
-- ============================================================

SELECT first_name || ' ' || last_name AS Isci,
       hire_date
FROM hr.employees
WHERE hire_date = (
    SELECT MAX(hire_date)
    FROM hr.employees
);


-- ============================================================
-- Tapşırıq 4
-- Harrison-dan daha çox maaş alan işçiləri tap.
-- ============================================================

SELECT first_name,
       salary
FROM hr.employees
WHERE salary > (
    SELECT salary
    FROM hr.employees
    WHERE first_name = 'Harrison'
);


-- ============================================================
-- Tapşırıq 5
-- IT şöbəsində olub şirkət orta maaşından çox qazananları tap.
-- ============================================================

SELECT first_name,
       salary,
       department_id,
       ROUND(AVG(salary) OVER(), 2) AS orta_maas
FROM hr.employees
WHERE department_id = 60
  AND salary > (
      SELECT AVG(salary)
      FROM hr.employees
  );


-- ============================================================
-- Tapşırıq 6
-- 60-cı şöbədəki maksimum maaşdan çox qazanan işçiləri tap.
-- ============================================================

SELECT first_name,
       salary,
       department_id
FROM hr.employees
WHERE salary > (
    SELECT MAX(salary)
    FROM hr.employees
    WHERE department_id = 60
);


-- ============================================================
-- Tapşırıq 7
-- Manager olan işçiləri IN + subquery ilə tap.
-- ============================================================

SELECT first_name,
       employee_id
FROM hr.employees
WHERE employee_id IN (
    SELECT manager_id
    FROM hr.employees
);


-- ============================================================
-- Tapşırıq 8
-- Manager olmayan işçiləri NOT IN + IS NOT NULL ilə tap.
-- ============================================================

SELECT first_name,
       employee_id
FROM hr.employees
WHERE employee_id NOT IN (
    SELECT manager_id
    FROM hr.employees
    WHERE manager_id IS NOT NULL
);


-- ============================================================
-- Tapşırıq 9
-- 80-ci şöbədəki bütün maaşlardan çox qazananları tap.
-- > ALL
-- ============================================================

SELECT department_id,
       first_name,
       salary
FROM hr.employees
WHERE salary > ALL (
    SELECT salary
    FROM hr.employees
    WHERE department_id = 80
);


-- ============================================================
-- Tapşırıq 10
-- 60-cı şöbədəki ən azı bir maaşdan çox qazananları tap.
-- > ANY
-- ============================================================

SELECT department_id,
       first_name,
       salary
FROM hr.employees
WHERE salary > ANY (
    SELECT salary
    FROM hr.employees
    WHERE department_id = 60
);


-- ============================================================
-- Tapşırıq 11
-- Commission alan işçiləri IN + subquery ilə tap.
-- ============================================================

SELECT department_id,
       first_name,
       salary
FROM hr.employees
WHERE employee_id IN (
    SELECT employee_id
    FROM hr.employees
    WHERE commission_pct IS NOT NULL
);


-- ============================================================
-- Tapşırıq 12
-- FROM daxilində alt sorğudan istifadə et və
-- orta maaşı göstər.
-- ============================================================

SELECT *
FROM (
    SELECT first_name,
           department_id,
           salary,
           ROUND(AVG(salary) OVER(), 2) AS orta_maas
    FROM hr.employees
)
WHERE orta_maas > 3000;


-- ============================================================
-- Qısa yaddaş
-- ============================================================
-- IN      -> siyahıdakı dəyərlərdən biri ilə uyğun gəlir
-- NOT IN  -> siyahıdakı dəyərlərlə uyğun gəlmir
-- > ANY   -> ən azı birindən böyükdür
-- > ALL   -> hamısından böyükdür
-- FROM (SELECT ...)
--         -> alt sorğunun nəticəsini müvəqqəti cədvəl kimi istifadə edir
-- ============================================================
