# The Book Micro-service

This is the 3rd micro-service that is additional to the original two micro-services. It is a book service that manage books by their name, book-id.

The usage of this microservice is first being containerized with Docker and then deployed with Kubernetes on your choice of cloud. We use AWS, EC2, EKS as the default.

Follow the steps showed README in root directory to deploy the micro-services together.

To deploy sololy this one, execute this ` make -f k8s.mak s3` in terminal. (before you do that, make sure the kubenetes cluster is setup correctly)

