vagrant
=======

Templates I use with Vagrant and Packer and Virtualbox

## Pull in the submodules (for building boxes)

    git submodule update --init --recursive


## Building

    make

If you want to only build certain distributions, simply edit the Makefile and change the BOXES variable.

## Starting a VM

e.g. OL511-32

    vagrant up ol511-32
    vagrant ssh ol511-32
 
