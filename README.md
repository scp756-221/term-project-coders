# SFU CMPT 756 main project directory

This is project repo for making an additional micro-service on the Distributed System's course repo.

Follow the steps to appropriately use the project code.

Things to know:

- the project is for deploying 3 microservices on the cloud, the course kindly provided Makefile scripts to streamline that manual works. That Makefile is k8s.mak. However, k8s.mak has to be obtained by run `$ ./tools/process-templates.sh` or `$ make -f k8s-tpl.mak templates` on k8s-tpl.mak (details below).

- The project use Github Container Registry (ghcr.io) for saving the three microservice images, so you need to provide credentials to access your GitHub. You need to figure out how to connect to your GitHub Container Registry before deploying. 

- Beside Github Container Registry, you need to connect to your cloud with crendentials. The project defaultly use AWS, so we fill AWS credentials in `~/.kube/config`

---
# Steps

### 1. Instantiate the template files

#### Fill in the required values in the template variable file

Copy the file `cluster/tpl-vars-blank.txt` to `cluster/tpl-vars.txt`
and fill in all the required values in `tpl-vars.txt`.  These include
things like your AWS keys, your GitHub signon, and other identifying
information.  See the comments in that file for details. Note that you
will need to have installed Gatling
(https://gatling.io/open-source/start-testing/) first, because you
will be entering its path in `tpl-vars.txt`.

#### Instantiate the templates

Once you have filled in all the details, run

~~~
$ make -f k8s-tpl.mak templates
~~~

This will check that all the programs you will need have been
installed and are in the search path.  If any program is missing,
install it before proceeding.

The script will then generate makefiles personalized to the data that
you entered in `clusters/tpl-vars.txt`.

**Note:** This is the *only* time you will call `k8s-tpl.mak`
directly. This creates all the non-templated files, such as
`k8s.mak`.  You will use the non-templated makefiles in all the
remaining steps.

### 2. To build and push images of the three microservices

~~~
$make -f k8s.mak cri
~~~
### 3. To deploy onto the cloud
```
$make -f eks.mak start
$make -f k8s.mak provision
$make -f k8s.mak deploy
$make -f k8s.mak loader #make sure all template are initialized with your crendentials
```
The loader will load initial data to the database, so we have entries for querying.
### 4. Use Gatling to simulate Networking load of light to heavy load on different microservice
```
$./gatling-user.sh 10 #meaning number of user =10 (light wight nework load)
$./gatling-book.sh 100 #heavy network load
```
Namely, ./gatling-(user | music | book).sh for each of user/music/book microservice.
### 5. Inspect the loading effect with Grafana and network flow with Kiali
```
$make -f k8s.mak grafana-url 
$make -f k8s.mak kiali-url
```
The generated url is the user interface on brower of the applications of Grafana and Kiali.

---

###  Ensure AWS DynamoDB is accessible/running

Regardless of where your cluster will run, it uses AWS DynamoDB
for its backend database. Check that you have the necessary tables
installed by running

~~~
$ aws dynamodb list-tables
~~~

The resulting output should include tables `User` and `Music`.

----

###  Final Demo Video

The Final Demo video is available below:

[Click Here to Video Demo Video on Youtube](https://youtu.be/jPatCKwj_nc)
