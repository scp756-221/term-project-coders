# Defining aliases for bash and Git

This directory contains files that define aliases for bash and Git. 
We have provided some initial aliases to get you started. You are
invited to modify them and add your own.

The aliases are defined in the following files:

* `bash_aliases`: A list of alias commands for bash.  Example:

   ~~~bash
   alias cpi="\cp -i"
   ~~~

* `gitconfig`: Configuration for Git. If you want to do commits from inside
  the tools container, you will need to add your name and email to the
  commented-out lines at the start of this file. Note that
  some Git configuration parameters that you might have set in your host OS (Windows or macOS) may need to be
  set differently or not included at all in this file if they do not make sense in a
  Linux container.  For example, any `credential` entry should probably not be included in
  this file.  You will probably also want to use a different `core.editor` entry.

* `aws-a`: A list of bash aliases for frequent AWS command-line operations.  These are often much faster
  to use than using the AWS Console.  You will need to do some one-time set up before
  runing these commands.  See `README-aws.md` in this directory for how to do this set up.

To define these aliases in your current shell, source the script `tools/profiles.sh`:

~~~bash
/home/k8s# . tools/profiles.sh
~~~

The '`.`' in the above statement is the shell `source` command.

You will have to source the script every time you start a container.