-- =========================================================
-- DƏRS 18 — SET OPERATORS və TEXT FUNKSİYALARI
-- HR schema / FreeSQL
-- =========================================================

-- =========================================================
-- Tapşırıq 1
-- employees və job_history-dən department_id-ləri UNION ilə birləşdirin.
-- =========================================================

SELECT department_id
FROM hr.employees
UNION
SELECT department_id
FROM hr.job_history;


-- =========================================================
-- Tapşırıq 2
-- Eyni sorğunu UNION ALL ilə yazın və sətir saylarını müqayisə edin.
-- =========================================================

SELECT department_id
FROM hr.employees
UNION ALL
SELECT department_id
FROM hr.job_history;


-- =========================================================
-- Tapşırıq 3
-- Fərqin səbəbini izah edin (neçə təkrar silindi?).
-- =========================================================

-- UNION-da 12 sətir, UNION ALL-da isə 117 sətir alındı.
-- UNION nəticədəki təkrarlanan dəyərləri silir,
-- UNION ALL isə bütün dəyərləri, təkrarları ilə birlikdə saxlayır.
-- 117 - 12 = 105 təkrar


-- =========================================================
-- Tapşırıq 4
-- employee_id-ləri hər iki cədvəldən UNION edib sıralayın.
-- =========================================================

SELECT employee_id AS isci_e
FROM hr.employees
UNION
SELECT employee_id
FROM hr.job_history
ORDER BY isci_e;


-- =========================================================
-- Tapşırıq 5
-- ORDER BY-ı birinci sorğuya yazıb xəta alın, sonra düzəldin.
-- =========================================================

-- Səhv variant:
SELECT department_id
FROM hr.employees
ORDER BY department_id DESC
UNION
SELECT department_id
FROM hr.job_history;


-- Düzgün variant:
SELECT department_id
FROM hr.employees
UNION
SELECT department_id
FROM hr.job_history
ORDER BY department_id DESC;


-- =========================================================
-- Tapşırıq 6
-- İki fərqli maaş aralığını UNION ALL ilə birləşdirin.
-- =========================================================

SELECT salary
FROM hr.employees
WHERE salary > 10000
UNION ALL
SELECT salary
FROM hr.employees
WHERE salary < 5000;


-- =========================================================
-- Tapşırıq 7
-- İşçisi olmayan şöbələri MINUS ilə tapın (16 sətir gözlənilir).
-- =========================================================

SELECT department_id
FROM hr.departments
MINUS
SELECT department_id
FROM hr.employees;


-- =========================================================
-- Tapşırıq 8
-- İşçisi OLAN şöbələri INTERSECT ilə tapın (11 sətir).
-- =========================================================

SELECT department_id
FROM hr.employees
INTERSECT
SELECT department_id
FROM hr.departments;


-- =========================================================
-- Tapşırıq 9
-- Vəzifə dəyişmiş işçiləri tapın (employees INTERSECT job_history).
-- =========================================================

SELECT employee_id
FROM hr.employees
INTERSECT
SELECT employee_id
FROM hr.job_history;


-- Alternativ yanaşma:
SELECT first_name, last_name
FROM hr.employees
INTERSECT
SELECT e.first_name, e.last_name
FROM hr.employees e
JOIN hr.job_history j
    ON e.employee_id = j.employee_id;


-- =========================================================
-- Tapşırıq 10
-- Heç vaxt vəzifə dəyişməyənləri tapın (MINUS).
-- =========================================================

SELECT employee_id
FROM hr.employees
MINUS
SELECT employee_id
FROM hr.job_history;


-- =========================================================
-- Tapşırıq 11
-- MINUS-un ardıcıllığını dəyişib nəticə fərqini müşahidə edin.
-- =========================================================

SELECT employee_id
FROM hr.job_history
MINUS
SELECT employee_id
FROM hr.employees;

-- Məlumat çıxmır.


-- =========================================================
-- Tapşırıq 12
-- 17-ci dərsdəki LEFT JOIN + IS NULL ilə MINUS nəticəsini müqayisə edin.
-- =========================================================

SELECT department_id
FROM hr.departments
MINUS
SELECT department_id
FROM hr.employees;


SELECT d.department_name
FROM hr.departments d
LEFT JOIN hr.employees e
    ON e.department_id = d.department_id
WHERE e.employee_id IS NULL;


-- Nəticə eynidir: 16.
-- MINUS daha qısa və sadədir.
-- LEFT JOIN + IS NULL isə daha uzundur.


-- =========================================================
-- Tapşırıq 13
-- Soyadları BÖYÜK hərflə göstərin (UPPER).
-- =========================================================

SELECT UPPER(last_name) AS soyad
FROM hr.employees;


-- =========================================================
-- Tapşırıq 14
-- Ad və soyadı birləşdirib INITCAP ilə formatlayın.
-- =========================================================

SELECT INITCAP(first_name || ' ' || last_name) AS tam_ad
FROM hr.employees;


-- =========================================================
-- Tapşırıq 15
-- Email-in ilk 3 hərfini çıxarın (SUBSTR).
-- =========================================================

SELECT SUBSTR(email, 1, 3)
FROM hr.employees;


-- =========================================================
-- Tapşırıq 16
-- phone_number-da nöqtəni tire ilə əvəz edin (REPLACE).
-- =========================================================

SELECT REPLACE(phone_number, '.', '-') AS telefon
FROM hr.employees;


-- =========================================================
-- Tapşırıq 17
-- job_id-nin '_' işarəsindən əvvəlki hissəsini alın
-- (INSTR + SUBSTR).
-- =========================================================

SELECT SUBSTR(job_id, 1, INSTR(job_id, '_') - 1)
FROM hr.employees;


-- =========================================================
-- Tapşırıq 18
-- Ən uzun soyadı tapın (LENGTH + MAX).
-- =========================================================

SELECT MAX(LENGTH(last_name)) AS max_soyad
FROM hr.employees;


-- =========================================================
-- QEYD
-- =========================================================
-- Tapşırıq 18-də MAX(LENGTH(last_name))
-- ən uzun soyadın neçə simvoldan ibarət olduğunu göstərir.
