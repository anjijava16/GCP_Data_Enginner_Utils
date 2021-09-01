# Exceptions to query caching

## Query results are not cached:

When a destination table is specified in the job configuration, the Cloud Console, the bq command-line tool, or the API

If any of the referenced tables or logical views have changed since the results were previously cached
When any of the tables referenced by the query have recently received streaming inserts (a streaming buffer is attached to the table) even if no new rows have arrived

If the query uses non-deterministic functions; for example, date and time functions such as CURRENT_TIMESTAMP() and NOW(), and other functions such as SESSION_USER() return different values depending on when a query is executed

If you are querying multiple tables using a wildcard

If the cached results have expired; typical cache lifetime is 24 hours, but the cached results are best-effort and may be invalidated sooner

If the query runs against an external data source other than Cloud Storage. (BigQuery standard SQL queries on Cloud Storage are supported by cached query results.)
How cached results are stored

When you run a query, a temporary, cached results table is created in a special dataset referred to as an "anonymous dataset". Unlike regular datasets which inherit permissions from the IAM resource hierarchy model (project and organization permissions), access to anonymous datasets is restricted to the dataset owner. The owner of an anonymous dataset is the user who ran the query that produced the cached result.

When an anonymous dataset is created, the user that runs the query job is explicitly given bigquery.dataOwner access to the anonymous dataset. bigquery.dataOwner access gives only the user who ran the query job full control over the dataset. This includes full control over the cached results tables in the anonymous dataset. If you intend to share query results, do not use the cached results stored in an anonymous dataset. Instead, write the results to a named destination table.


Though the user that runs the query has full access to the dataset and the cached results table, using them as inputs for dependent jobs is strongly discouraged.


The names of anonymous datasets begin with an underscore. This hides them from the datasets list in the Cloud Console. You can list anonymous datasets and audit anonymous dataset access controls by using the bq command-line tool or the API.

For information on listing datasets (including anonymous datasets), see Listing datasets in a project.

For information on auditing access controls for anonymous datasets, see Getting information about datasets.

## Disabling retrieval of cached results
The Use cached results option reuses results from a previous run of the same query unless the tables being queried have changed. Using cached results is only beneficial for repeated queries. For new queries, the Use cached results option has no effect, though it is enabled by default.



When you repeat a query with the Use cached results option disabled, the existing cached result is overwritten. This requires BigQuery to compute the query result, and you are charged for the query. This is particularly useful in benchmarking scenarios.



If you want to disable retrieving cached results and force live evaluation of a query job, you can set the configuration.query.useQueryCache property of your query job to false.

##  --nouse_cache 



 bq query \
 --nouse_cache \
 --batch \
 'SELECT
    name,
    count
  FROM
    `my-project`.mydataset.names_2013
  WHERE
    gender = "M"
  ORDER BY
    count DESC
  LIMIT
    6'

