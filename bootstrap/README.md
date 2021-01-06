#Remote S3 State Bootstrap 

## Overview 

This module is used to create the inital S3 Remote bucket and DynamoDB lock table. 

A role and policy will be created for that can be used to asign to users who need to access the state to run the terraform. 

### Bucket 

The bucket has **versioning enabled**, and currently only uses bucket **AES256 encryption** (it currently does not support KMS). The following default lifecycle policy - the _non current version_ moves to *STANDARD_IA* after **30** days and then *GLACIER* after **90**. It is is never deleted. 


### DynamoDB 

A table is created with the LockId key field to be used to lock the states files stored in the S3 state bucket. Currently only the **PAY_PER_REQUEST** is used for the billing method. 


### Not Current Supported
-[] KMS for buckets 
-[] Bucket replication 
-[] Detailed lifcycle policies 
-[] 



