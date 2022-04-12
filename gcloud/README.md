# Extending the tools container image to include gcloud

This directory contains code to build a version of the tools container that includes the command-line interface `gcloud` for Google's cloud service.
As of Dec&nbsp;2021, `gcloud` is only supported for Linux systems running on `x86-64` systems but not
`aarch64`.  The `aarch64` chips are used in macOS machines featuring the [M1 chip](https://en.wikipedia.org/wiki/Apple_M1),
informally called "Apple Silicon".

The files in this directory also illustrate how to extend the tools container
by building a new image based upon it.  You can use this approach to add
your own packages to the tools container as you need them.

## Instantiating the templates

Before using this directory, you must have instantiated all
template files by executing the following in the tools container:

~~~bash
/home/k8s# make -f k8s-tpl.mak templates
~~~

You probably have already done this in Assignment&nbsp;1 (though it can't hurt to do it again to be sure).

## Building the image

Build the new image by executing the following **in your host OS:**

~~~bash
.../c756-exer/gcloud $ ./gcloud-build.sh
~~~

## Running the image

Run the new image by executing the following in **your host OS:**

~~~bash
.../c756-exer $ gcloud/shell.sh
~~~
