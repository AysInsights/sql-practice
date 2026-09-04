-- Dərs 13 | SQL Praktikaları
-- Oracle HR sxemi | hr.employees
-- Praktika 1 və Praktika 2


-- =====================================================
-- Tapşırıq 1
-- hr.employees cədvəlindən bütün sütunları göstərin.
-- İlk 10 sətri göstərin.
-- =====================================================

SELECT *
FROM hr.employees
FETCH FIRST 10 ROWS ONLY;


-- =====================================================
-- Tapşırıq 2
-- Yalnız first_name, last_name və salary sütunlarını gətirin.
-- =====================================================

SELECT first_name,
       last_name,
       salary
FROM hr.employees;


-- =====================================================
-- Tapşırıq 3
-- Maaşı 10000-dən çox olan işçiləri tapın.
-- =====================================================

SELECT first_name,
       last_name,
       salary
FROM hr.employees
WHERE salary > 10000;


-- =====================================================
-- Tapşırıq 4
-- 60-cı şöbədə (IT) işləyənləri göstərin.
-- =====================================================

SELECT first_name,
       last_name
FROM hr.employees
WHERE department_id = 60;


-- =====================================================
-- Tapşırıq 5
-- Adı 'S' hərfi ilə başlayan işçiləri tapın.
-- =====================================================

SELECT first_name
FROM hr.employees
WHERE first_name LIKE 's%';


-- =====================================================
-- Tapşırıq 6
-- Maaşı 5000 ilə 10000 arasında olan işçiləri tapın.
-- =====================================================

SELECT first_name,
       last_name,
       salary
FROM hr.employees
WHERE salary BETWEEN 5000 AND 10000;


-- =====================================================
-- Tapşırıq 7
-- İşçiləri maaşa görə azalan sırada göstərin.
-- =====================================================

SELECT first_name,
       last_name,
       salary
FROM hr.employees
ORDER BY salary DESC;


-- =====================================================
-- Tapşırıq 8
-- Əvvəl maaşa, sonra şöbəyə görə sıralayın.
-- =====================================================

SELECT first_name,
       last_name,
       salary,
       department_id
FROM hr.employees
ORDER BY salary DESC,
         department_id DESC;


-- =====================================================
-- Tapşırıq 9
-- Neçə fərqli department_id olduğunu tapın.
-- =====================================================

SELECT DISTINCT department_id
FROM hr.employees;

-- Alternativ:
-- SELECT COUNT(DISTINCT department_id)
-- FROM hr.employees;


-- =====================================================
-- Tapşırıq 10
-- Ad və soyadı birləşdirib "Tam Ad" adlandırın.
-- =====================================================

SELECT first_name || ' ' || last_name AS "Tam Ad"
FROM hr.employees;


-- =====================================================
-- Tapşırıq 11
-- İllik maaş sütunu yaradın: salary * 12
-- =====================================================

SELECT first_name,
       last_name,
       salary * 12 AS "Illik Gelir"
FROM hr.employees;


-- =====================================================
-- Tapşırıq 12
-- Rəhbəri olmayan işçiləri tapın.
-- =====================================================

SELECT first_name,
       last_name
FROM hr.employees
WHERE manager_id IS NULL;


-- =====================================================
-- Tapşırıq 13
-- commission_pct NULL olanları 0 ilə əvəz edin.
-- =====================================================

SELECT first_name,
       last_name,
       NVL(commission_pct, 0) AS komissiya
FROM hr.employees;


-- =====================================================
-- Tapşırıq 14
-- Ümumi gəlir sütunu yaradın:
-- salary + salary * NVL(commission_pct, 0)
-- =====================================================

SELECT first_name,
       last_name,
       salary + salary * NVL(commission_pct, 0) AS "Umumi Gelir"
FROM hr.employees;


-- =====================================================
-- Tapşırıq 15
-- NVL2 ilə işçini "Komissiyali" / "Komissiyasiz"
-- kimi göstərin.
-- =====================================================

SELECT first_name || ' ' || last_name AS "Ad,Soyad",
       NVL2(commission_pct, 'Komissiyali', 'Komissiyasiz') AS "Komissiya"
FROM hr.employees;


-- =====================================================
-- Tapşırıq 16
-- manager_id NULL olduqda "Rehber yoxdu",
-- NULL olmadıqda "Rehber var" yazdırın.
-- =====================================================

SELECT first_name,
       last_name,
       NVL2(manager_id, 'Rehber var', 'Rehber yoxdu') AS "Manager Status"
FROM hr.employees;


-- =====================================================
-- Tapşırıq 17
-- NVL və COALESCE funksiyalarını müqayisə edin.
-- =====================================================

SELECT first_name,
       last_name,
       commission_pct,
       NVL(commission_pct, 0) AS "NVL",
       COALESCE(commission_pct, 0) AS "COALESCE"
FROM hr.employees;


-- =====================================================
-- Tapşırıq 18
-- Komissiyası olan neçə işçi olduğunu tapın.
-- =====================================================

SELECT COUNT(*)
FROM hr.employees
WHERE commission_pct IS NOT NULL;


-- =====================================================
-- Tapşırıq 19
-- Maaşa görə kateqoriya yaradın:
-- 15000 və yuxarı → Yüksək
-- 8000 və yuxarı → Orta
-- Qalanlar → Aşağı
-- =====================================================

SELECT first_name,
       last_name,
       salary,
       CASE
           WHEN salary >= 15000 THEN 'Yuksek'
           WHEN salary >= 8000 THEN 'Orta'
           ELSE 'Asagi'
       END AS Kateqoriya
FROM hr.employees;


-- =====================================================
-- Tapşırıq 20
-- CASE ilə şöbə adı yaradın:
-- 10 → Admin, 60 → IT, 80 → Satis, digərləri → Basqa
-- =====================================================

SELECT department_id,
       last_name || ' ' || first_name AS Ad_Soyad,
       CASE department_id
           WHEN 10 THEN 'Admin'
           WHEN 60 THEN 'IT'
           WHEN 80 THEN 'Satis'
           ELSE 'Basqa'
       END AS Sobe
FROM hr.employees;


-- =====================================================
-- Tapşırıq 21
-- Tapşırıq 20-dəki eyni nəticəni DECODE ilə yazın.
-- =====================================================

SELECT department_id,
       last_name || ' ' || first_name AS Tam_Ad,
       DECODE(department_id,
              10, 'Admin',
              60, 'IT',
              80, 'Satis',
              'Basqa') AS Kateqoriya
FROM hr.employees;


-- =====================================================
-- Tapşırıq 22
-- hire_date 2005-dən əvvəl olduqda "Kohne isci" yazdırın.
--
-- Qeyd: HR datasında uyğun nəticəni görmək üçün praktikada
-- tarix 2015-01-01 olaraq istifadə edilmişdir.
-- =====================================================

SELECT first_name || ' ' || last_name AS Tam_Ad,
       CASE
           WHEN hire_date < DATE '2015-01-01' THEN 'Kohne isci'
           ELSE ' '
       END AS zemanetli
FROM hr.employees;


-- =====================================================
-- Tapşırıq 23
-- İç-içə CASE istifadə edin:
-- şöbə və maaş səviyyəsinə görə təsnifat yaradın.
-- =====================================================

SELECT first_name || ' ' || last_name AS As_Soyad,
       CASE
           WHEN department_id = 10 THEN
               CASE
                   WHEN salary >= 15000 THEN 'Admin - Yuksek'
                   WHEN salary >= 8000 THEN 'Admin - Orta'
                   ELSE 'Admin - Asagi'
               END
           WHEN department_id = 60 THEN
               CASE
                   WHEN salary >= 15000 THEN 'IT - Yuksek'
                   WHEN salary >= 8000 THEN 'IT - Orta'
                   ELSE 'IT - Asagi'
               END
           WHEN department_id = 80 THEN
               CASE
                   WHEN salary >= 15000 THEN 'Satis - Yuksek'
                   WHEN salary >= 8000 THEN 'Satis - Orta'
                   ELSE 'Satis - Asagi'
               END
           ELSE 'basqa'
       END AS tesnifat
FROM hr.employees;


-- =====================================================
-- Tapşırıq 24
-- NVL və CASE-i birlikdə istifadə edin:
-- NULL commission_pct də nəzərə alınmaqla yekun maaşı
-- hesablayın və yekun maaşa görə kateqoriya yaradın.
-- =====================================================

SELECT first_name,
       last_name,
       salary,
       commission_pct,
       salary + salary * NVL(commission_pct, 0) AS Yekun_Maas,
       CASE
           WHEN salary + salary * NVL(commission_pct, 0) >= 15000 THEN 'yuksek'
           WHEN salary + salary * NVL(commission_pct, 0) >= 8000 THEN 'orta'
           ELSE 'asagi'
       END AS tesnifat
FROM hr.employees
ORDER BY Yekun_Maas DESC;
