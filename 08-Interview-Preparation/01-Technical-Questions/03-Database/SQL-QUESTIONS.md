# SQL Interview Questions

**175 Questions organized by difficulty level for top tech company interviews**

---

## 📚 Basics (50 Questions)

1. What is SQL and what does it stand for?
2. Explain the difference between SQL and NoSQL databases.
3. What is a relational database management system (RDBMS)?
4. Explain database, table, row, and column concepts.
5. What is a primary key and why is it important?
6. Explain the difference between primary key and unique key.
7. What is a foreign key and referential integrity?
8. Explain the relationship between primary key and foreign key.
9. What is SQL data types: INTEGER, VARCHAR, TEXT, DATE, TIMESTAMP?
10. Explain when to use each data type.
11. What is NULL in SQL and how does it work?
12. Explain NULL vs empty string.
13. What is the CREATE TABLE statement?
14. Explain table creation syntax and constraints.
15. What is ALTER TABLE and modifying table structure?
16. Explain adding, modifying, and dropping columns.
17. What is DROP TABLE and deleting tables?
18. Explain TRUNCATE TABLE vs DELETE vs DROP.
19. What is the INSERT statement?
20. Explain INSERT with VALUES and SELECT.
21. What is the SELECT statement?
22. Explain SELECT with WHERE clause.
23. What is ORDER BY and sorting results?
24. Explain ascending (ASC) vs descending (DESC).
25. What is LIMIT and OFFSET for pagination?
26. Explain TOP and FETCH FIRST clauses.
27. What is the WHERE clause and filtering?
28. Explain comparison operators: =, !=, <, >, <=, >=.
29. What is logical operators: AND, OR, NOT?
30. Explain operator precedence in WHERE clause.
31. What is the LIKE operator and pattern matching?
32. Explain wildcards: %, _ in LIKE.
33. What is IN operator and multiple values?
34. Explain NOT IN and NULL handling.
35. What is BETWEEN operator for ranges?
36. Explain IS NULL and IS NOT NULL.
37. What is the UPDATE statement?
38. Explain updating multiple columns.
39. What is the DELETE statement?
40. Explain DELETE with WHERE clause.
41. What is SQL aggregate functions?
42. Explain COUNT, SUM, AVG, MAX, MIN.
43. What is GROUP BY clause?
44. Explain grouping data by columns.
45. What is HAVING clause?
46. Explain HAVING vs WHERE difference.
47. What is DISTINCT and removing duplicates?
48. Explain DISTINCT with multiple columns.
49. What is SQL aliases: AS keyword?
50. Explain table aliases and column aliases.

---

## 🎯 Intermediate (50 Questions)

51. What is SQL JOIN and why is it used?
52. Explain INNER JOIN and matching rows.
53. What is LEFT JOIN (LEFT OUTER JOIN)?
54. Explain when to use LEFT JOIN.
55. What is RIGHT JOIN (RIGHT OUTER JOIN)?
56. Explain when to use RIGHT JOIN.
57. What is FULL OUTER JOIN?
58. Explain FULL OUTER JOIN use cases.
59. What is CROSS JOIN (Cartesian product)?
60. Explain when CROSS JOIN is useful.
61. What is self-join and when to use it?
62. Explain self-join with examples.
63. What is multiple table joins?
64. Explain joining three or more tables.
65. What is SQL subqueries?
66. Explain correlated vs non-correlated subqueries.
67. What is subquery in WHERE clause?
68. Explain subquery in SELECT clause.
69. What is subquery in FROM clause (derived table)?
70. Explain EXISTS and NOT EXISTS operators.
71. What is the difference between EXISTS and IN?
72. Explain performance implications of EXISTS vs IN.
73. What is UNION and UNION ALL?
74. Explain the difference between UNION and UNION ALL.
75. What is INTERSECT and EXCEPT operators?
76. Explain set operations in SQL.
77. What is SQL views and why use them?
78. Explain CREATE VIEW statement.
79. What is materialized views?
80. Explain views vs materialized views.
81. What is SQL indexes and their purpose?
82. Explain CREATE INDEX statement.
83. What is unique indexes?
84. Explain composite indexes.
85. What is covering indexes?
86. Explain index optimization strategies.
87. What is partial indexes?
88. Explain filtered indexes.
89. What is database normalization?
90. Explain First Normal Form (1NF).
91. What is Second Normal Form (2NF)?
92. Explain functional dependencies.
93. What is Third Normal Form (3NF)?
94. Explain transitive dependencies.
95. What is Boyce-Codd Normal Form (BCNF)?
96. Explain BCNF vs 3NF.
97. What is denormalization?
98. Explain when to denormalize.
99. What is SQL transactions?
100. Explain ACID properties.

---

## 🚀 Advanced (75 Questions)

101. What is transaction isolation levels?
102. Explain READ UNCOMMITTED isolation level.
103. What is READ COMMITTED isolation level?
104. Explain dirty reads prevention.
105. What is REPEATABLE READ isolation level?
106. Explain non-repeatable reads prevention.
107. What is SERIALIZABLE isolation level?
108. Explain phantom reads prevention.
109. What is MVCC (Multi-Version Concurrency Control)?
110. Explain how MVCC works.
111. What is database locking?
112. Explain shared locks vs exclusive locks.
113. What is deadlock and how to prevent it?
114. Explain deadlock detection and resolution.
115. What is optimistic locking vs pessimistic locking?
116. Explain version-based optimistic locking.
117. What is SQL stored procedures?
118. Explain CREATE PROCEDURE syntax.
119. What is stored procedure parameters?
120. Explain IN, OUT, INOUT parameters.
121. What is SQL functions?
122. Explain scalar functions vs table-valued functions.
123. What is triggers in SQL?
124. Explain BEFORE vs AFTER triggers.
125. What is INSTEAD OF triggers?
126. Explain trigger use cases.
127. What is SQL cursors?
128. Explain when to use cursors.
129. What is recursive CTEs (Common Table Expressions)?
130. Explain recursive queries with CTEs.
131. What is window functions?
132. Explain ROW_NUMBER(), RANK(), DENSE_RANK().
133. What is LAG() and LEAD() functions?
134. Explain window frame specification.
135. What is PARTITION BY in window functions?
136. Explain ORDER BY in window functions.
137. What is aggregate window functions?
138. Explain SUM(), AVG() OVER().
139. What is SQL performance optimization?
140. Explain query execution plans.
141. What is EXPLAIN and EXPLAIN ANALYZE?
142. Explain query plan analysis.
143. What is index hints and query hints?
144. Explain when to use hints.
145. What is query optimization techniques?
146. Explain join order optimization.
147. What is predicate pushdown?
148. Explain query rewriting.
149. What is SQL injection prevention?
150. Explain parameterized queries.
151. What is prepared statements?
152. Explain bind parameters.
153. What is SQL security best practices?
154. Explain user permissions and roles.
155. What is row-level security?
156. Explain policy-based access control.
157. What is database encryption?
158. Explain encryption at rest vs in transit.
159. What is SQL backup strategies?
160. Explain full, incremental, differential backups.
161. What is point-in-time recovery?
162. Explain transaction log backups.
163. What is database replication?
164. Explain master-slave replication.
165. What is master-master replication?
166. Explain replication strategies.
167. What is database sharding?
168. Explain horizontal sharding.
169. What is vertical sharding?
170. Explain shard key selection.
171. What is database partitioning?
172. Explain range, hash, list partitioning.
173. What is database clustering?
174. Explain cluster configuration.
175. What is SQL advanced features: JSON support, full-text search, spatial data?

---

**Total: 175 Questions**

*Questions organized by difficulty level to help you prepare systematically for technical interviews at top tech companies.*

