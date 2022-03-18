# Summary

This repo tries to replicate the data generation and benchmark in the following blog posts:

- https://altinity.com/blog/loading-100b-rows-in-minutes-in-altinity-cloud
- https://www.singlestore.com/blog/how-to-load-100-billion-rows-of-data-ultrafast/

# Setup

First create a file called `credentials.sql` and add a S3 link to it:

```sql
CREATE LINK aws_s3 AS S3
    CREDENTIALS '{ "aws_access_key_id": "XXX", "aws_secret_access_key": "XXX" }'
    CONFIG '{ "region":"us-east-1" }'
```

This link needs to have read/write access to at least one bucket which we will use during data generation. Set the region accordingly as well.

# Data generation

Source `datagen.sql` first. Then modify `generate_all.sql` to point at the bucket you want to use. Then source `generate_all.sql` and go grab a coffee.

# Data loading

Modify `schema.sql` to refer to your bucket and source it. Then when you are ready, start the pipeline called "trips" and go grab a coffee.
