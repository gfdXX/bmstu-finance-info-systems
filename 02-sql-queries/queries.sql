--------------------------------------------------------------------------------
-- 1. Базовые выборки и фильтрация (WHERE с операторами)
--------------------------------------------------------------------------------

-- Выбрать все записи из таблицы.
SELECT *
FROM test_bd;

-- Выбрать записи, где страна (column2) - 'USA'.
SELECT *
FROM test_bd
WHERE column2 = 'USA';

-- Выбрать записи, где сумма (column5) больше 5000.
SELECT *
FROM test_bd
WHERE CAST(REPLACE(REPLACE(column5, '$', ''), ',', '') AS REAL) > 5000;

-- Выбрать записи, где количество коробок (column6) меньше 100.
SELECT *
FROM test_bd
WHERE column6 < 100;

-- Выбрать записи, где страна (column2) - 'USA' И сумма (column5) больше 5000.
SELECT *
FROM test_bd
WHERE column2 = 'USA' AND CAST(REPLACE(REPLACE(column5, '$', ''), ',', '') AS REAL) > 5000;

-- Выбрать записи, где продукт (column3) - 'Mint Chip Choco' ИЛИ страна (column2) равна UK.
SELECT *
FROM test_bd
WHERE column3 = 'Mint Chip Choco' OR column2 = 'UK';

-- Выбрать записи, где страна НЕ 'USA' (<> или !=).
SELECT *
FROM test_bd
WHERE column2 <> 'USA';
-- или
SELECT *
FROM test_bd
WHERE column2 != 'USA';

-- Выбрать продажи с количеством коробок больше или равно 200 (>=).
SELECT *
FROM test_bd
WHERE column6 >= 200;

-- Выбрать продажи с суммой меньше или равно 2000 (<=).
SELECT *
FROM test_bd
WHERE CAST(REPLACE(REPLACE(column5, '$', ''), ',', '') AS REAL) <= 2000;

-- Выбрать продажи с суммой от 3000 до 5000 (включительно) (BETWEEN).
SELECT *
FROM test_bd
WHERE CAST(REPLACE(REPLACE(column5, '$', ''), ',', '') AS REAL) BETWEEN 3000 AND 5000;

-- Выбрать продажи за период с 10 января 2022 по 15 февраля 2022 (BETWEEN по дате).
-- Убедитесь, что формат даты в базе соответствует 'MM-DD-YY'
SELECT *
FROM test_bd
WHERE column4 BETWEEN '01-10-22' AND '02-15-22';


--------------------------------------------------------------------------------
-- 2. Агрегация и группировка (GROUP BY)
--------------------------------------------------------------------------------

-- Подсчитать общую сумму продаж и общее количество отгруженных коробок для каждого продавца (column1).
SELECT
    column1,
    SUM(CAST(REPLACE(REPLACE(column5, '$', ''), ',', '') AS REAL)) AS TotalAmount,
    SUM(column6) AS TotalBoxes
FROM
    test_bd
GROUP BY
    column1;

-- Подсчитать количество транзакций для каждой страны (column2).
SELECT column2, COUNT(*) AS NumberOfTransactions
FROM test_bd
GROUP BY column2;

-- Найти среднюю сумму продаж по продукту (column3).
SELECT
    column3,
    AVG(CAST(REPLACE(REPLACE(column5, '$', ''), ',', '') AS REAL)) AS AverageAmount
FROM
    test_bd
GROUP BY
    column3;


--------------------------------------------------------------------------------
-- 3. Сортировка результатов (ORDER BY)
--------------------------------------------------------------------------------

-- Выбрать все записи и отсортировать их по сумме продаж (column5) по убыванию.
SELECT *
FROM test_bd
ORDER BY CAST(REPLACE(REPLACE(column5, '$', ''), ',', '') AS REAL) DESC;

-- Выбрать все записи и отсортировать их сначала по стране (column2) по возрастанию, затем по дате (column4) по возрастанию.
SELECT *
FROM test_bd
ORDER BY column2 ASC, column4 ASC;


--------------------------------------------------------------------------------
-- 4. Уникальные значения (DISTINCT)
--------------------------------------------------------------------------------

-- Получить список всех уникальных стран (column2).
SELECT DISTINCT column2
FROM test_bd;

-- Получить список всех уникальных комбинаций продавца (column1) и продукта (column3).
SELECT DISTINCT column1, column3
FROM test_bd;


--------------------------------------------------------------------------------
-- 5. Ограничение результатов (LIMIT для SQLite)
-- (Вместо TOP/ROWNUM в других СУБД)
--------------------------------------------------------------------------------

-- Выбрать первые 10 записей.
SELECT *
FROM test_bd
LIMIT 10;

-- Выбрать 5 записей с наибольшей суммой продаж.
SELECT *
FROM test_bd
ORDER BY CAST(REPLACE(REPLACE(column5, '$', ''), ',', '') AS REAL) DESC
LIMIT 5;

-- Выбрать записи со 2-й по 6-ю (5 записей, начиная со смещения 1).
SELECT *
FROM test_bd
LIMIT 5 OFFSET 1;


--------------------------------------------------------------------------------
-- 6. Поиск по шаблону (LIKE, NOT LIKE)
--------------------------------------------------------------------------------

-- Выбрать записи, где имя продавца (column1) начинается на 'J'.
SELECT *
FROM test_bd
WHERE column1 LIKE 'J%';

-- Выбрать записи, где название продукта (column3) содержит слово 'Dark'.
SELECT *
FROM test_bd
WHERE column3 LIKE '%Dark%';

-- Выбрать продукты, название которых НЕ начинается на 'P' (NOT LIKE).
SELECT *
FROM test_bd
WHERE column3 NOT LIKE 'P%';


--------------------------------------------------------------------------------
-- 7. Поиск по регулярным выражениям (REGEXP)
-- (Если поддерживается в вашей версии SQLite)
--------------------------------------------------------------------------------

-- Выбрать записи, где продукт (column3) соответствует паттерну "число% Слово(а)".
SELECT *
FROM test_bd
WHERE column3 REGEXP '^[0-9]+% [A-Za-z ]+$';

-- Выбрать записи, где продукт (column3) содержит либо 'Chip' либо 'Bar'.
SELECT *
FROM test_bd
WHERE column3 REGEXP 'Chip|Bar';


--------------------------------------------------------------------------------
-- 8. Объединение результатов запросов (UNION / UNION ALL)
--------------------------------------------------------------------------------

-- Объединить список продавцов из США и список продавцов из UK (удаляет дубликаты имен продавцов+стран).
SELECT column1 AS SalesPerson, column2 AS Country
FROM test_bd
WHERE column2 = 'USA'
UNION
SELECT column1, column2
FROM test_bd
WHERE column2 = 'UK';

-- Объединить список продавцов из США и список продавцов из UK (включает дубликаты).
SELECT column1 AS SalesPerson, column2 AS Country
FROM test_bd
WHERE column2 = 'USA'
UNION ALL
SELECT column1, column2
FROM test_bd
WHERE column2 = 'UK';


--------------------------------------------------------------------------------
-- 9. Самообъединение таблицы (SELF JOIN)
--------------------------------------------------------------------------------

-- Пример SELF JOIN: Найти пары записей о продажах от одного и того же продавца
-- в одной и той же стране, но для РАЗНЫХ продуктов.
-- Используем псевдонимы t1 и t2 для двух "экземпляров" одной таблицы.
-- Условие t1.rowid < t2.rowid используется для того, чтобы каждая пара
-- была показана только один раз (например, запись A + запись B, но не B + A)
-- и чтобы запись не объединялась сама с собой.

SELECT
    t1.column1 AS SalesPerson,       -- Продавец (из первой копии таблицы)
    t1.column2 AS Country,          -- Страна (из первой копии)
    t1.column3 AS Product1,         -- Продукт из первой продажи
    CAST(REPLACE(REPLACE(t1.column5, '$', ''), ',', '') AS REAL) AS Amount1, -- Сумма первой продажи
    t1.column4 AS Date1,            -- Дата первой продажи
    t2.column3 AS Product2,         -- Продукт из второй продажи
    CAST(REPLACE(REPLACE(t2.column5, '$', ''), ',', '') AS REAL) AS Amount2, -- Сумма второй продажи
    t2.column4 AS Date2             -- Дата второй продажи
FROM
    test_bd t1
INNER JOIN
    test_bd t2 ON t1.column1 = t2.column1 -- Соединяем по имени продавца
               AND t1.column2 = t2.column2 -- Соединяем по стране
               AND t1.column3 <> t2.column3 -- Продукты должны быть разными
               AND t1.rowid < t2.rowid;    -- Избегаем дублирующихся пар и самообъединения