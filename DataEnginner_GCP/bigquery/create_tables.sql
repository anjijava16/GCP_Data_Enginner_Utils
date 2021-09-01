
CREATE OR REPLACE TABLE staging.wiki_page_views_spark_write_one_filter
(
wiki_project STRING,
wiki_page STRING,
wiki_page_views INT64,
date DATE
)
PARTITION BY date
cluster by wiki_page
OPTIONS (
partition_expiration_days=999999,
require_partition_filter=true
)



CREATE OR REPLACE TABLE staging.wiki_page_views_spark_write
(
wiki_project STRING,
wiki_page STRING,
wiki_page_views INT64,
date DATE
)
PARTITION BY date
OPTIONS (
partition_expiration_days=999999
)

CREATE OR REPLACE TABLE staging.wiki_page_views_spark_write_one
(
wiki_project STRING,
wiki_page STRING,
wiki_page_views INT64,
date DATE
)
PARTITION BY date
cluster by wiki_page
OPTIONS (
partition_expiration_days=999999
)
