-- ============================================================
-- PRAKTİKA 16 – RIGHT / FULL OUTER JOIN, ANTI-JOIN, SELF JOIN
-- Oracle HR Schema / FreeSQL
-- ============================================================
-- Müəllimin tapşırıqları və həllər
-- ============================================================


-- ============================================================
-- Tapşırıq 1
-- RIGHT JOIN ilə bütün şöbələri işçi adları ilə göstərin.
-- ============================================================

SELECT first_name || ' ' || last_name AS Tam_ad,
       d.department_name AS Sobe
FROM hr.employees e
RIGHT JOIN hr.departments d
    ON e.department_id = d.department_id;


-- ============================================================
-- Tapşırıq 2
-- Eyni nəticəni cədvəllərin yerini dəyişib LEFT JOIN ilə alın.
-- ============================================================

SELECT first_name || ' ' || last_name AS Tam_ad,
       d.department_name AS Sobe
FROM hr.departments d
LEFT JOIN hr.employees e
    ON e.department_id = d.department_id;


-- ============================================================
-- Tapşırıq 3
-- 4 JOIN növünü COUNT(*) ilə yazıb nəticələri müqayisə edin
-- (106 / 107 / 122 / 123).
-- ============================================================

-- INNER JOIN
SELECT COUNT(*) AS Isci_sayi
FROM hr.employees e
JOIN hr.departments d
    ON e.department_id = d.department_id;

-- LEFT JOIN
SELECT COUNT(*) AS Isci_sayi
FROM hr.employees e
LEFT JOIN hr.departments d
    ON e.department_id = d.department_id;

-- RIGHT JOIN
SELECT COUNT(*) AS Isci_sayi
FROM hr.employees e
RIGHT JOIN hr.departments d
    ON e.department_id = d.department_id;

-- FULL OUTER JOIN
SELECT COUNT(*) AS Isci_sayi
FROM hr.employees e
FULL JOIN hr.departments d
    ON e.department_id = d.department_id;


-- ============================================================
-- Tapşırıq 4
-- FULL OUTER JOIN ilə hər iki tərəfin uyğunsuzlarını göstərin.
-- ============================================================

SELECT e.first_name || ' ' || e.last_name AS Tam_ad,
       d.department_name AS Sobe
FROM hr.employees e
FULL JOIN hr.departments d
    ON e.department_id = d.department_id
WHERE e.department_id IS NULL
   OR d.department_id IS NULL;


-- ============================================================
-- Tapşırıq 5
-- NVL ilə NULL-ları 'Yoxdur' kimi əvəz edin.
-- ============================================================

SELECT first_name || ' ' || e.last_name AS Tam_ad,
       NVL(department_name, 'Yoxdur') AS Sobe
FROM hr.employees e
LEFT JOIN hr.departments d
    ON e.department_id = d.department_id;


-- ============================================================
-- Tapşırıq 6
-- FULL OUTER nəticəsini şöbə adına görə sıralayın.
-- ============================================================

SELECT department_name AS Sobe,
       e.first_name || ' ' || e.last_name AS Tam_ad
FROM hr.employees e
FULL JOIN hr.departments d
    ON e.department_id = d.department_id
ORDER BY department_name;


-- ============================================================
-- Tapşırıq 7
-- Şöbəsi olmayan işçini tapın (LEFT + IS NULL).
-- ============================================================

SELECT first_name AS Ad,
       last_name AS Soyad,
       department_id
FROM hr.employees
WHERE department_id IS NULL;


-- ============================================================
-- Tapşırıq 8
-- İşçisi olmayan şöbələri sadalayın və sayın.
-- ============================================================

SELECT COUNT(e.employee_id) AS Isci_sayi,
       department_name AS Sobe
FROM hr.employees e
RIGHT JOIN hr.departments d
    ON e.department_id = d.department_id
GROUP BY department_name
HAVING COUNT(employee_id) = 0;


-- ============================================================
-- Tapşırıq 9
-- SELF JOIN ilə hər işçinin rəhbərinin adını göstərin.
-- ============================================================

SELECT e.first_name || ' ' || e.last_name AS Isci,
       m.first_name || ' ' || m.last_name AS Rehber
FROM hr.employees e
JOIN hr.employees m
    ON e.manager_id = m.employee_id;


-- ============================================================
-- Tapşırıq 10
-- Rəhbəri olmayan işçini tapın (LEFT JOIN + IS NULL).
-- ============================================================

SELECT first_name || ' ' || last_name AS Rehbersiz_isci
FROM hr.employees
WHERE manager_id IS NULL;


-- ============================================================
-- Tapşırıq 11
-- Hər rəhbərin neçə tabeliyində işçi var?
-- (SELF JOIN + GROUP BY)
-- ============================================================

SELECT m.first_name || ' ' || m.last_name AS Rehberin_adi,
       COUNT(e.employee_id) AS Isci_sayi
FROM hr.employees e
JOIN hr.employees m
    ON e.manager_id = m.employee_id
GROUP BY m.manager_id,
         m.first_name || ' ' || m.last_name
ORDER BY Isci_sayi DESC;


-- ============================================================
-- Tapşırıq 12
-- Rəhbəri ilə eyni şöbədə işləməyən işçiləri tapın.
-- ============================================================

SELECT e.first_name || ' ' || e.last_name AS Isci
FROM hr.employees e
JOIN hr.employees m
    ON e.manager_id = m.employee_id
WHERE e.department_id <> m.department_id
ORDER BY Isci;


-- ============================================================
-- Əlavə Analitik Tapşırıq 1
-- Hər şöbə üçün: şöbə adı, işçi sayı, ümumi maaş.
-- Boş şöbələr də görünsün.
-- ============================================================

SELECT department_name AS Sobe,
       COUNT(e.employee_id) AS Isci_sayi,
       SUM(salary) AS Umumi_maas
FROM hr.employees e
RIGHT JOIN hr.departments d
    ON e.department_id = d.department_id
GROUP BY department_name
ORDER BY department_name;


-- ============================================================
-- Əlavə Analitik Tapşırıq 2
-- İşçi sayı 0 olan şöbələrdə COUNT nə qaytarır?
-- Səbəbini izah edin.
--
-- Cavab:
-- İşçi sayı 0 olan şöbələrdə COUNT 0 qaytarır, çünki işçi yoxdur.
-- SUM, AVG və digər aggregate funksiyalar isə məlumat olmadıqda
-- NULL qaytara bilər.
-- ============================================================


-- ============================================================
-- Əlavə Analitik Tapşırıq 3
-- Hər işçi: adı, şöbəsi, rəhbəri, vəzifəsi
-- (4 cədvəl + SELF JOIN).
-- ============================================================

SELECT e.first_name || ' ' || e.last_name AS Iscinin_adi,
       d.department_name AS Sobe,
       m.manager_id AS Rehber,
       j.job_title AS Vezife
FROM hr.employees e
LEFT JOIN hr.employees m
    ON e.manager_id = m.employee_id
LEFT JOIN hr.departments d
    ON e.department_id = d.department_id
LEFT JOIN hr.jobs j
    ON e.job_id = j.job_id;

