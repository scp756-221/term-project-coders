# CMPT 756 User service

This is the 1st micro-service. The user service maintains a list of users and passwords.  In a more complete version of the application, users would have to first log in to this service, authenticate with a password, be assigned a session, then present that session token to the music service for any requests.

The usage of this microservice is first being containerized with Docker and then deployed with Kubernetes on your choice of cloud. We use AWS, EC2, EKS as the default.

Follow the steps showed README in root directory to deploy the micro-services together.

To deploy sololy this one, execute this ` make -f k8s.mak s3` in terminal. (before you do that, make sure the kubenetes cluster is setup correctly)