# Building the services on a CSIL machine

Students with ARM64/v8 ("Apple silicon" aka M1/Pro/Max) machines such as the 2020/2021 Apple Macs 
cannot build the service container images on their
machines. Instead, you must use remote login to build the images on a
Computer Science Instructional Laboratory (CSIL) lab machine, which
have x86_64 processors, and push them to the registry from there.

This document and the scripts in this directory show how to do this.

## Is your machine an ARM machine?

To determine if your machine has an ARM or x86_64processor, execute
the following:

~~~
uname -i
~~~

If the result is:

* `aarch64`: Your machine is ARM. 
* `x86_64`: Your machine is AMD/Intel. **You do not need to use this method.**

## Setting up the environment on your CSIL directory

You perform four steps to set up the course environment in your CSIL
home directory:

1. Sign on to any CSIL machine
2. Clone the course repostory to your CSIL home directory.
3. Copy your access code files to the directory.
4. Instantiate the templates

With this environment, you can then build one or more service images
on any CSIL machine.

Details for the above steps follow.

### Sign on to a CSIL machine

You will create the course environment on your CSIL home directory.
Because this directory is shared across all CSIL machines, it will be
your home directory on any CSIL machine.

Before you can sign on, you must have
[set up SFU multi-factor authentication and VPN](https://www.sfu.ca/computing/about/support/computing-resources-for-graduate-students.html).

Once you have signed in to the VPN, ssh in to any of the CSIL servers:

~~~
$ ssh -p 24 <USER>@csil-cpu<N>.csil.sfu.ca
~~~

where

* `<USER>` is your SFU id
* `<N>` is any integer in the range 1--6.

Note: `ssh` is available in the CMPT 756 tools container if you do not
have it in your regular command line.

**Reminder:** You do not have to sign in to the same machine every
  time. Every CSIL machine will share your home directory.

**Tip:** If you can't recall the name of the machine you're on, run

~~~
$ hostname -f
~~~

to list the full name of your current machine.

### Clone the course repository to your CSIL home directory

Where `USER` is your userid, after signon you will be in your home
directory, `/home/USER`. Clone your instance of the course repository
into that directory:

~~~
/home/USER $ git clone https://github.com/GITHUB_USERNAME/c756-exer.git
~~~

where `GITHUB_USERNAME` is your GitHub username.

Prevent public access to your private files:

~~~
/home/USER $ chmod go-rwx c756-exer/e-k8s/cluster
/home/USER $ chmod go-rwx c756-exer/e-k8s/cluster/*
~~~

If you wish to prevent other users from seeing any part of your work,
also turn off access to the top level directory:

~~~
/home/USER $ chmod go-rwx c756-exer
~~~

### Copy your access files to your CSIL home directory

The final step is copying the files with your AWS and GitHub access
tokens to this new copy of your repository.

**Perform this step on your own machine, not the CSIL machine.**

Run the following script to copy the access tokens. 

~~~
$ cd <PATH>/csil-build
$ ./send-to-csil.sh <USER> <MACHINE>
~~~

where

* `<PATH>` is the path to the `e-k8s` subdirectory in your course repository
* `<USER>` is the SFU id you used to sign in to CSIL
* `<MACHINE>` is the CSIL machine to which you signed in

### Instantiate the templates

The final step is to instantiate the templates in the repository.

**On the CISL machine**, run the following in the `e-k8s` subdirectory:

~~~
/home/USER/c756-exer/e-k8s $ make -f k8s-tpl.mak templates
~~~

Your environment is now ready to build the service images.

## Build a service image

There are three services in the course application: s1, s2, and
db. If you want to update the code running on a cluster created by you
or your team, you must build a new container image and push it to the
GitHub container registry, `ghcr.io`. This requires three steps:

1. *On your machine:* Copy the revised code from your machine to your CSIL home
   directory.
2. *On the CISL machine:* Build and push the image.
3. *On your machine:* Tell Kubernetes to pull and run the new image.

These steps are elaborated in the following sections.

### Copy the revised code to your CSIL home directory

Once you have edited the code on your own machine, copy it to your
home directory. **On your own machine** and from the `e-k8s`
subdirectory, run

~~~
.../e-k8s $ csil-build/send-file-to-csil.sh USER MACHINE PATH
~~~

where

* `USER`: is your SFU id
* `MACHINE`: is the CSIL machine to which you signed in
* `PATH`: is the path to th file, relative to `e-k8s`. Example:
  `s1/app.py`

Some changes to the services will require sending other files as well,
such as s1's `s1/Dockerfile` and `s1/requirements.txt` or
`cluster/s1-tpl.yaml` (and the corresponding files for the other
services).

### Build and push the image

Once you have the revised source file in your CSIL home directory,
**on a CSIL machine** run the build.  The command is slightly different
for each service:

~~~
/home/USER/c756-exer/e-k8s $ make -f k8s.mak logs/s1.repo.log    # for s1
/home/USER/c756-exer/e-k8s $ make -f k8s.mak logs/s2-v1.repo.log # for s2
/home/USER/c756-exer/e-k8s $ make -f k8s.mak logs/db.repo.log    # for db
~~~

### Tell the Kubernetes cluster to pull and run the revised image

To actually run the revised image in a cluster, **on your own
machine** run the following commands that correspond to the images you
want to run:

~~~
.../e-k8s $ # Only do the ones for the images you wish to run
.../e-k8s $ # for s1
.../e-k8s $ touch logs/s1.repo.log
.../e-k8s $ make -f k8s.mak s1
.../e-k8s $ # for s2
.../e-k8s $ touch logs/s2-v1.repo.log
.../e-k8s $ make -f k8s.mak s2
.../e-k8s $ # for db
.../e-k8s $ touch logs/db.repo.log
.../e-k8s $ make -f k8s.mak db
~~~

## Revising the code several times

Once you've set up your home directory, you can use it to revise your
code several times, for example if you are debugging.  Simply repeat
the steps in "Build a service image" every time you update a file.

**We recommend that you always modify the source files on your own
machine** and copy them to the CSIL machine to build them there. That
way, all your updates are in the same place. On the other hand, if you
modify the files directly on the CSIL machine, you save the copying
step but risk forgetting to pull those changes back to your own
machine for final commit to the code base.

## Cleanup your CSIL home directory

When you no longer need to build the service image, remove the
directory from your CSIL directory.  **On the CSIL machine**, in your home
directory, **on the CSIL machine**, run

~~~
/home/USER $ ./cleanup-csil-756.sh
~~~

The script checks as carefully as possible, giving you multiple
chances to cancel the deletion. Take care to only run it when you are
done.

## Simplifying the procedure once you have some experience

The procedure presented here emphasizes reliability over speed. Once you
are familiar with the steps, you can optimize it for your own
workflow. There are many workflows you might prefer, depending upon
your circumstances.

One recommendation: Always modify the source files on your own
machine (preferably in a git repo), then transfer them to the CSIL machine (e.g., git pull). Keep the latest,
best version of the your code in one place.
