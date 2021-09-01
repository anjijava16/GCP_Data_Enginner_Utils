bq --location=location extract \
--destination_format format \
--compression compression_type \
--field_delimiter delimiter \
--print_header=boolean \
project_id:dataset.table \
gs://bucket/filename.ext


bq extract \
--compression GZIP \
'mydataset.mytable' \
gs://example-bucket/myfile.csv


bq extract \
--destination_format NEWLINE_DELIMITED_JSON \
'mydataset.mytable' \
gs://example-bucket/myfile.json

bq extract \
--destination_format AVRO \
--compression SNAPPY \
'mydataset.mytable' \
gs://example-bucket/myfile.avro

