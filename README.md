This Terraform script creates an S3 bucket, a CloudFront distribution with the S3 bucket as the origin, sets permissions for CloudFront to access objects in the bucket, and uploads HTML webpage files to the S3 bucket. The webpage can then be accessed using the IP address allocated to it which is found within your AWS console once created.

RUN STEPS
To run the code, open up your AWS CLI command console and run Terraform config
When promt, Enter your AWS credentials to link to your account. Such as access_key and secret_key.
Run terraform init on project file to initialize your terraform and download dependencies
Run terraform plan to ensure everything is correct.
Run terraform apply to create your resources.
Enter the IP address which is found in your AWS console bucket section into your browser to view the hosted webpage.
