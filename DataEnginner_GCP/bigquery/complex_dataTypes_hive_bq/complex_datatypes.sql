create database iwinner_db;
 
use iwinner_db;
CREATE external TABLE sales_info (location string, month string,
number_of_orders int, total_sales double)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
STORED AS textfile
LOCATION 'gs://dev-iwinner-data-july04/hive_data/text/';

vi sample.text :
Prague,Jan,101,4875.33
Rome,Mar,87,1557.39
Bangalore,May,317,8936.99
Beijing,Jul,411,11600.67
San Francisco,Sept,156,6846.34
Paris,Nov,159,7134.56
San Francisco,Jan,113,5397.89
Prague,Dec,333,9894.77
Bangalore,Jul,271,8320.55
Beijing,Dec,100,4248.41

hive> DESCRIBE EXTENDED sales_info;
OK
location                string                                      
month                   string                                      
number_of_orders        int                                         
total_sales             double                                      
                 
Detailed Table Information      Table(tableName:sales_info, dbName:iwinner_db, owner:mamathamams39, createTime:1628127473, lastAccessTime:0, retention:0, sd:StorageDescriptor(cols:[FieldSchema(name:location, type:string, comment:null), FieldSchema(name:month, type:string, comment:null), FieldSchema(name:number_of_orders, type:int, comment:null), FieldSchema(name:total_sales, type:double, comment:null)], location:gs://dev-iwinner-data-july04/hive_data/text, inputFormat:org.apache.hadoop.mapred.TextInputFormat, outputFormat:org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat, compressed:false, numBuckets:-1, serdeInfo:SerDeInfo(name:null, serializationLib:org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe, parameters:{serialization.format=,, field.delim=,}), bucketCols:[], sortCols:[], parameters:{}, skewedInfo:SkewedInfo(skewedColNames:[], skewedColValues:[], skewedColValueLocationMaps:{}), storedAsSubDirectories:false), partitionKeys:[], parameters:{transient_lastDdlTime=1628127473, bucketing_version=2, totalSize=250, EXTERNAL=TRUE, numFiles=1}, viewOriginalText:null, viewExpandedText:null, tableType:EXTERNAL_TABLE, rewriteEnabled:false, catName:hive, ownerType:USER)
Time taken: 0.152 seconds, Fetched: 6 row(s)
hive> 


-- Hive DDL'S 
CREATE external TABLE sales_info_ORC (location string, month string,
        number_of_orders int, total_sales double)
      STORED AS ORC LOCATION 'gs://dev-iwinner-data-july04/hive_data/orc/';
INSERT INTO TABLE sales_info_ORC SELECT * FROM sales_info;	  

CREATE external TABLE sales_info_PARQUET (location string, month string,
        number_of_orders int, total_sales double)
      STORED AS PARQUET  LOCATION 'gs://dev-iwinner-data-july04/hive_data/parquet/';
INSERT INTO TABLE sales_info_PARQUET SELECT * FROM sales_info;


CREATE external TABLE sales_info_avro (location string, month string,
        number_of_orders int, total_sales double)
      STORED AS AVRO LOCATION 'gs://dev-iwinner-data-july04/hive_data/avro/';
INSERT INTO TABLE sales_info_avro SELECT * FROM sales_info;	  

CREATE external TABLE sales_info_sequencefile (location string, month string,
        number_of_orders int, total_sales double)
      STORED AS sequencefile LOCATION 'gs://dev-iwinner-data-july04/hive_data/sequence/';
INSERT INTO TABLE sales_info_sequencefile SELECT * FROM sales_info;	  	 


CREATE external TABLE sales_info_rcfile (location string, month string,
        number_of_orders int, total_sales double)
      STORED AS rcfile LOCATION 'gs://dev-iwinner-data-july04/hive_data/rcfile/';
INSERT INTO TABLE sales_info_rcfile SELECT * FROM sales_info;	  	 

 
CREATE external TABLE table_complextypes( index int, name string, intarray ARRAY<int>, propmap MAP<string, string>)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '%'
MAP KEYS TERMINATED BY ':'
STORED AS TEXTFILE
LOCATION 'gs://dev-iwinner-data-july04/hive_data/complex/text';




vi complex.txt :
3,Prague,1%2%3,zone:euro%status:up
89,Rome,4%5%6,zone:euro
400,Bangalore,7%8%9,zone:apac%status:pending
183,Beijing,0%1%2,zone:apac
94,Sacramento,3%4%5,zone:noam%status:down
101,Paris,6%7%8,zone:euro%status:up
56,Frankfurt,9%0%1,zone:euro
202,Jakarta,2%3%4,zone:apac%status:up
313,Sydney,5%6%7,zone:apac%status:pending
76,Atlanta,8%9%0,zone:noam%status:down




CREATE external TABLE table_complextypes_orc( index int, name string, intarray ARRAY<int>, propmap MAP<string, string>)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '%'
MAP KEYS TERMINATED BY ':'
STORED AS ORC
LOCATION 'gs://dev-iwinner-data-july04/hive_data/complex/orc';
		 
INSERT INTO TABLE table_complextypes_orc SELECT * FROM table_complextypes;

CREATE external TABLE table_complextypes_parquet( index int, name string, intarray ARRAY<int>, propmap MAP<string, string>)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '%'
MAP KEYS TERMINATED BY ':'
STORED AS PARQUET
LOCATION 'gs://dev-iwinner-data-july04/hive_data/complex/parquet';
INSERT INTO TABLE table_complextypes_parquet SELECT * FROM table_complextypes;


--BQ DDL 
CREATE  TABLE welcome.table_complextypes(
   index INT64, name string, intarray ARRAY<INT64>, propmap ARRAY<STRUCT<zone STRING, status STRING>>
) 

-- BQ LOAD 
bq load --replace --source_format=ORC welcome.table_complextypes gs://dev-iwinner-data-july04/hive_data/complex/orc/000000_0


--******************Struct Example
CREATE external TABLE Struct_test(
         id int,       
         weather_reading struct<temp:int, humidity:int, comment:string> 
) COMMENT 'This is a table stored as textfile'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '$'
STORED AS TEXTFILE
LOCATION 'gs://dev-iwinner-data-july04/hive_data/complex/struct/text';




vi struct.txt 
1,32$65$moderate
2,37$78$humid
3,43$55$hot
4,23$45$cold

CREATE external TABLE Struct_test_orc(
         id int,       
         weather_reading struct<temp:int, humidity:int, comment:string> 
) COMMENT 'This is a table stored as textfile'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '$'
STORED AS ORC
LOCATION 'gs://dev-iwinner-data-july04/hive_data/complex/struct/orc';
INSERT INTO TABLE Struct_test_orc SELECT * FROM Struct_test;

CREATE external TABLE Struct_test_parquet(
         id int,       
         weather_reading struct<temp:int, humidity:int, comment:string> 
) COMMENT 'This is a table stored as textfile'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '$'
STORED AS PARQUET
LOCATION 'gs://dev-iwinner-data-july04/hive_data/complex/struct/parquet';
INSERT INTO TABLE Struct_test_parquet SELECT * FROM Struct_test;

#BQ Load 
CREATE  TABLE welcome.Struct_test_orc(
         id int,       
         weather_reading struct<temp int, humidity int, comment string> 
) 

bq load --replace --source_format=ORC welcome.Struct_test_orc gs://dev-iwinner-data-july04/hive_data/complex/struct/orc/000000_0

SELECT
   table_name, ddl
 FROM
  welcome.INFORMATION_SCHEMA.TABLES
 WHERE
   table_name="cloud_pricing_export"
   
   
   
SELECT
   table_name, ddl
 FROM
  bigquery-public-data.github_repos.INFORMATION_SCHEMA.TABLES
 WHERE
   table_name="commits"

-- Map and Array Data types    
CREATE TABLE `iwinner-data-318822.welcome.table_complextypes`
(
  index INT64,
  name STRING,
  intarray ARRAY<INT64>,
  propmap ARRAY<STRUCT<key STRING, value STRING>>
);

-- Struct Data types 

CREATE TABLE `iwinner-data-318822.welcome.Struct_test_orc`
(
  id INT64,
  weather_reading STRUCT<temp INT64, humidity INT64, comment STRING>
);
   
hive > set hive.ddl.output.format=json   
hive> desc extended table_complextypes_orc;
OK
{"columns":[{"name":"index","type":"int"},{"name":"name","type":"string"},{"name":"intarray","type":"array<int>"},{"name":"propmap","type":"map<string,string>"}],"tableInfo":{"tableName":"table_complextypes_orc","dbName":"iwinner_db","owner":"mamathamams39","createTime":1628129879,"lastAccessTime":0,"retention":0,"sd":{"cols":[{"name":"index","type":"int","comment":null,"setName":true,"setType":true,"setComment":false},{"name":"name","type":"string","comment":null,"setName":true,"setType":true,"setComment":false},{"name":"intarray","type":"array<int>","comment":null,"setName":true,"setType":true,"setComment":false},{"name":"propmap","type":"map<string,string>","comment":null,"setName":true,"setType":true,"setComment":false}],"location":"gs://dev-iwinner-data-july04/hive_data/complex/orc","inputFormat":"org.apache.hadoop.hive.ql.io.orc.OrcInputFormat","outputFormat":"org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat","compressed":false,"numBuckets":-1,"serdeInfo":{"name":null,"serializationLib":"org.apache.hadoop.hive.ql.io.orc.OrcSerde","parameters":{"mapkey.delim":":","collection.delim":"%","serialization.format":",","field.delim":","},"description":null,"serializerClass":null,"deserializerClass":null,"serdeType":null,"setName":false,"parametersSize":4,"setDescription":false,"setParameters":true,"setSerializationLib":true,"setSerializerClass":false,"setDeserializerClass":false,"setSerdeType":false},"bucketCols":[],"sortCols":[],"parameters":{},"skewedInfo":{"skewedColNames":[],"skewedColValues":[],"skewedColValueLocationMaps":{},"setSkewedColNames":true,"setSkewedColValues":true,"setSkewedColValueLocationMaps":true,"skewedColNamesSize":0,"skewedColNamesIterator":[],"skewedColValuesSize":0,"skewedColValuesIterator":[],"skewedColValueLocationMapsSize":0},"storedAsSubDirectories":false,"parametersSize":0,"setParameters":true,"colsIterator":[{"name":"index","type":"int","comment":null,"setName":true,"setType":true,"setComment":false},{"name":"name","type":"string","comment":null,"setName":true,"setType":true,"setComment":false},{"name":"intarray","type":"array<int>","comment":null,"setName":true,"setType":true,"setComment":false},{"name":"propmap","type":"map<string,string>","comment":null,"setName":true,"setType":true,"setComment":false}],"setCols":true,"setLocation":true,"setInputFormat":true,"setSerdeInfo":true,"setOutputFormat":true,"setBucketCols":true,"setSortCols":true,"setSkewedInfo":true,"setCompressed":true,"setNumBuckets":true,"bucketColsSize":0,"bucketColsIterator":[],"sortColsIterator":[],"sortColsSize":0,"setStoredAsSubDirectories":true,"colsSize":4},"partitionKeys":[],"parameters":{"totalSize":"893","EXTERNAL":"TRUE","COLUMN_STATS_ACCURATE":"{}","numFiles":"1","transient_lastDdlTime":"1628129901","bucketing_version":"2"},"viewOriginalText":null,"viewExpandedText":null,"tableType":"EXTERNAL_TABLE","privileges":null,"temporary":false,"rewriteEnabled":false,"creationMetadata":null,"catName":"hive","ownerType":"USER","partitionKeysSize":0,"setCatName":true,"setSd":true,"setPrivileges":false,"setCreateTime":true,"setLastAccessTime":true,"parametersSize":6,"setOwner":true,"setParameters":true,"setTableName":true,"setDbName":true,"setPartitionKeys":true,"partitionKeysIterator":[],"setViewOriginalText":false,"setViewExpandedText":false,"setTableType":true,"setCreationMetadata":false,"setOwnerType":true,"setRetention":true,"setTemporary":false,"setRewriteEnabled":true}}    
