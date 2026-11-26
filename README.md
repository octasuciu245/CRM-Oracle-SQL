# CRM Relational Database (Oracle SQL)

A relational database design and SQL implementation for a **CRM (Customer Relationship Management)** platform, built for the *Databases* course at the University of Bucharest (Faculty of Mathematics and Computer Science)[cite: 16].

## Domain Model & Rules

The schema models core sales and customer management workflows[cite: 16]:
- **Departments & Sales Agents:** `DEPARTAMENT` groups `AGENT_VANZARI` members, each managing a dedicated portfolio of `CLIENT` accounts[cite: 16].
- **Tasks & Client Notes:** Each client can have planned `SARCINA` items (`In asteptare`, `Finalizata`) and a `JURNAL_CLIENT` note linked via `ON DELETE CASCADE` when a client is deleted[cite: 16].
- **Opportunities, Catalog & Contracts:** Active deals (`OPORTUNITATE` — `Deschisa`, `Castigata`, `Pierduta`) link to catalog items (`ARTICOL`) through the associative table `OPORTUNITATE_ARTICOL`[cite: 16]. The catalog uses an **ISA specialization** into physical `PRODUS` items (with stock) and `SERVICIU` items (with hourly rate), while signed `CONTRACT` records reference existing opportunities[cite: 16].

## Database Design & Highlights

- **Normalization:** Designed and verified up to **3NF (Third Normal Form)** (eliminating repeating groups, partial dependencies on composite keys, and transitive dependencies)[cite: 16].
- **Keys, Constraints & Sequence:** Primary/foreign keys, `CHECK` and `UNIQUE` constraints, cascade rules, and `SECVENTA_CRM` for ID generation[cite: 16].
- **SQL Queries & DML:** Includes correlated/uncorrelated subqueries, `GROUP BY` / `HAVING`, `CASE`, `NVL`, `DECODE`, string and date functions, CTE (`WITH`), a 4-table `LEFT JOIN`, relational division, `FETCH FIRST 3 ROWS ONLY` (Top-N), subquery-based `UPDATE` / `DELETE` statements, and a join view (`V_Oportunitati_Clienti`)[cite: 16].

## Tech Stack

- **DBMS:** Oracle Database (SQL)
- **Tooling:** Oracle SQL Developer[cite: 16]

## Repository Contents

- `schema_and_queries.sql` — Sequence, DDL table definitions, sample data inserts, analytical queries, DML statements with subqueries, and view definition[cite: 16].

## Author

**Octavian-Constantin Suciu**
