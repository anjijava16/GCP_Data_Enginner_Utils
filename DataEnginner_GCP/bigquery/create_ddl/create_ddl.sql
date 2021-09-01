# PARTITION
CREATE TABLE `your-project.sales.orders_partitioned` (
  salesOrderKey STRING,
  orderDate TIMESTAMP,
  customerKey STRING,
  totalSale FLOAT64,
  currencyKey INT64
)
PARTITION BY DATE(orderDate)
AS
SELECT * FROM `your-project.sales.orders`

SELECT
 DATE_TRUNC(DATE(orderDate), MONTH) AS firstOfMonth,
 currencyKey,
 COUNT(*) AS numberOfOrders,
 SUM(totalSale) AS totalSales
FROM `your-project.sales.orders_partitioned`
WHERE DATE_TRUNC(DATE(orderDate), MONTH) = '2015-01-01'
GROUP BY DATE_TRUNC(DATE(orderDate), MONTH), currencyKey

# Clusering 
CREATE TABLE
 `your-project.sales.orders_clustered` (
   salesOrderKey STRING,
   orderDate TIMESTAMP,
   customerKey STRING,
   totalSale FLOAT64,
   currencyKey INT64 )
PARTITION BY DATE(orderDate)
CLUSTER BY customerKey
AS
SELECT * FROM `your-project.sales.orders`

SELECT
  customerKey,
  DATE_TRUNC(DATE(orderDate), MONTH) AS firstOfMonth,
  currencyKey,
  COUNT(*) AS numberOfOrders,
  SUM(totalSale) AS totalSales
FROM `your-project.sales.orders_clustered`
WHERE DATE_TRUNC(DATE(orderDate), MONTH) = '2015-02-01'
  AND customerKey IN (
    '1292803200000-402',
    '1298764800000-414',
    '1267401600000-212',
    '1267488000000-209')
GROUP BY customerKey, DATE_TRUNC(DATE(orderDate), MONTH), currencyKey


CREATE TABLE `your-project.sales.orders_denormalized`
PARTITION BY DATE(orderDate)
CLUSTER BY customerKey
AS
SELECT
  o.salesOrderKey,
  o.orderDate,
  o.currencyKey,
  o.customerKey,
  o.totalSale,
  ARRAY_AGG(
    STRUCT(
      ol.salesOrderLineKey,
      ol.productKey,
      ol.totalSale
  )) AS lineItem
FROM `your-project.sales.orders_clustered` AS o
  JOIN `your-project.sales.order_lines_clustered` AS ol
    ON ol.orderDate = o.orderDate
    AND ol.salesOrderKey = o.salesOrderKey
GROUP BY 1,2,3,4,5
