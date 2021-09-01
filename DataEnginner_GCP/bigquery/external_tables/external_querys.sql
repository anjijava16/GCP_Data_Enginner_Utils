CREATE EXTERNAL TABLE welcome.my_job(
DATE date options(description='Date order was placed')
)
OPTIONS(
format='NEWLINE_DELIMITED_JSON',
uris=['gs://orders-bucket/*.json ']
)
