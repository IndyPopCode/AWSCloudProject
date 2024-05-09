This Terraform script creates an S3 bucket, a CloudFront distribution with the S3 bucket as the origin, sets permissions for CloudFront to access objects in the bucket, and uploads HTML webpage files to the S3 bucket. This webpage can then be accessed using the IP address alocated to it which is found within your AWS console once created.

RUN STEPS
To run the code, open up your CLI command console and run Terraform init.
When promt, Enter your AWS credentials to link to your account. Such as access_key and secret_key.
Run terraform plan to ensure everything is correct.
Run terraform apply to create your resources.
Enter the IP address into your browser to view the hosted webpage.
