# Time-series data 
Storing time-series data in Cloud Bigtable is a natural fit. Cloud Bigtable stores data as unstructured columns in rows; each row has arow key, and row keys are sorted lexicographically.
For time series, you should generally use tall and narrow tables

# This is for two reasons:
1. Storing one event per row makes it easier to run queries against your data.
2. Storing many events per row makes it more likely that the total row size will exceed the recommended maximum.

# When you create a Cloud Bigtable instance, you choose whether its clusters store data on solid-state drives (SSD) or hard disk drives(HDD).HDD storage is suitable for use cases that meet the following criteria

1. You expect to store at least 10 TB of data.
2. You will not use the data to back a user-facing or latency-sensitive application.
3.  Your workload falls into one of the following categories:
		1. Batch workloads with scans and writes, and no more than occasional random reads of a small number of rows.
        2. Data archival, where you write very large amounts of data and rarely read that data.
		

# If you're running a performance test that depends upon Cloud Bigtable, be sure to follow these steps as you plan and execute yourtest:

Use a production instance. A development instance will not give you an accurate sense of how a production instanceperforms under load.

Use at least 300 GB of data. Cloud Bigtable performs best with 1 TB or more of data. However, 300 GB of data is enough toprovide reasonable results in a performance test on a 3-node cluster. On larger clusters, use at least 100 GB of data pernode.

Stay below the recommended storage utilization per node.

Before you test, run a heavy pre-test for several minutes. This step gives Cloud Bigtable a chance to balance data acrossyour nodes based on the access patterns it observes.

Run your test for at least 10 minutes. This step lets Cloud Bigtable further optimize your data, and it helps ensure that you willtest reads from disk as well as cached reads from memory.




