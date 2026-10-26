# Информационные системы управления финансами — домашнее задание

![SQLite](https://img.shields.io/badge/SQLite-SQL-003B57?logo=sqlite&logoColor=white)
![UML](https://img.shields.io/badge/UML-draw.io-F08705?logo=diagramsdotnet&logoColor=white)
![ProjectLibre](https://img.shields.io/badge/ProjectLibre-Gantt-2c8a3d)
![BMSTU](https://img.shields.io/badge/МГТУ_им._Баумана-ИУ1-0a4a8f)

Домашнее задание по дисциплине «Информационные системы управления финансами».
8 семестр, группа ИУ1-82Б, кафедра ИУ1, МГТУ им. Н.Э. Баумана (весна 2025), преподаватель Романов Н.О.
Пять независимых упражнений по системному анализу, базам данных и планированию проектов. [Отчёт (PDF, 27 стр.)](report.pdf)

| # | Упражнение | Файлы |
|---|---|---|
| 1–2 | **Диаграммы прецедентов и классов** для кафе быстрого обслуживания: клиент, бариста, кассир, менеджер, поставщик; приготовление и выдача напитка, расчёт и оплата заказа, приёмка товара, работа с некондицией | [`coffee-shop-uml.drawio`](01-use-case-and-classes/coffee-shop-uml.drawio) |
| 3 | **SQL-запросы** к базе продаж шоколада (Kaggle «Chocolate Sales»): `WHERE`, `GROUP BY`, `ORDER BY`, `DISTINCT`, `LIMIT`, `LIKE`, `REGEXP`, `UNION`, `SELF JOIN` | [`queries.sql`](02-sql-queries/queries.sql), [`chocolate_sales.db`](02-sql-queries/chocolate_sales.db), [`chocolate_sales.csv`](02-sql-queries/chocolate_sales.csv) |
| 4 | **Нормализация до 3НФ**: плоская таблица спроса по месяцам (датасет для ABC/XYZ-анализа) разбита на `Items` и `Monthly_Demand` с составным ключом | [`abc_xyz.db`](03-normalization/abc_xyz.db), [`abc_xyz_dataset.csv`](03-normalization/abc_xyz_dataset.csv), [`normalized_data.xlsx`](03-normalization/normalized_data.xlsx) |
| 5 | **План проекта в ProjectLibre**: корпоративный тимбилдинг для 30 сотрудников — задачи, ресурсы, диаграмма Ганта | [`teambuilding.pod`](04-project-planning/teambuilding.pod) |

## Как открыть

- `.db` — любой клиент SQLite, например [DB Browser for SQLite](https://sqlitebrowser.org) или `sqlite3 chocolate_sales.db`. Запросы из `queries.sql` рассчитаны на таблицу `test_bd` в этой базе.
- `.drawio` — [app.diagrams.net](https://app.diagrams.net) или расширение draw.io для VS Code.
- `.pod` — [ProjectLibre](https://www.projectlibre.com).

## Автор

Салженикин Даниил, МГТУ им. Н.Э. Баумана.
