# Use Analytic Window Functions for Advanced Analysis
● Standard aggregations

○ SUM, AVG, MIN, MAX, COUNT, etc.

● Navigation functions

○ LEAD() — Returns the value of a row n rows ahead of the current row
○ LAG() — Returns the value of a row n rows behind the current row
○ NTH_VALUE() — Returns the value of the nth value in the window

● Ranking and numbering functions

○ CUME_DIST() — Returns the cumulative distribution of a value in a group
○ DENSE_RANK() — Returns the integer rank of a value in a group
○ ROW_NUMBER() — Returns the current row number of the query result
○ RANK() — Returns the integer rank of a value in a group of values
○ PERCENT_RANK() — Returns the rank of the current row, relative to the other rows in the partition
