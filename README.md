# SFU CMPT 756 main project directory

This is the course repo for CMPT 756 (Spring 2022)

You will find resources for your assignments and term project here.


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

### 2. Ensure AWS DynamoDB is accessible/running

Regardless of where your cluster will run, it uses AWS DynamoDB
for its backend database. Check that you have the necessary tables
installed by running

~~~
$ aws dynamodb list-tables
~~~

The resulting output should include tables `User` and `Music`.

----


