# Packer templates for Fedora
[![Build Status](https://box-cutter.ci.cloudbees.com/buildStatus/icon?job=fedora-vm)](https://box-cutter.ci.cloudbees.com/job/fedora-vm/)

### Overview

This repository contains templates for Fedora that can create Vagrant boxes
using Packer.

## Current Boxes

64-bit boxes:

* [box-cutter/fedora21](https://vagrantcloud.com/box-cutter/fedora21) - Fedora 21 [Beta] (64-bit), VirtualBox 397MB
* [box-cutter/fedora20](https://vagrantcloud.com/box-cutter/fedora20) - Fedora 20 (64-bit), VMware 429MB/VirtualBox 363MB/Parallels 416MB
* [box-cutter/fedora19](https://vagrantcloud.com/box-cutter/fedora19) - Fedora 19 (64-bit), VMware 398MB/VirtualBox 342MB/Parallels 383MB
* [box-cutter/fedora18](https://vagrantcloud.com/box-cutter/fedora18) - Fedora 18 (64-bit), VMware 366MB/VirtualBox 302MB/Parallels 346MB

32-bit boxes:

* [box-cutter/fedora21-i386](https://vagrantcloud.com/box-cutter/fedora21-i386) - Fedora 21 (32-bit), VirtualBox 394MB
* [box-cutter/fedora20-i386](https://vagrantcloud.com/box-cutter/fedora20-i386) - Fedora 20 (32-bit), VMware 420MB/VirtualBox 357MB/Parallels 413MB
* [box-cutter/fedora19-i386](https://vagrantcloud.com/box-cutter/fedora19-i386) - Fedora 19 (32-bit), VMware 405MB/VirtualBox 336MB/Parallels 378MB
* [box-cutter/fedora18-i386](https://vagrantcloud.com/box-cutter/fedora18-i386) - Fedora 18 (32-bit), VMware 375MB/VirtualBox 301MB/Parallels 346MB


## Building the Vagrant boxes

To build all the boxes, you will need Packer and both VirtualBox, VMware
Fusion, and Parallels Desktop for Mac installed.

Parallels requires that the
[Parallels Virtualization SDK for Mac](http://ww.parallels.com/downloads/desktop)
be installed as an additional preqrequisite.

A GNU Make `Makefile` drives the process via the following targets:

    make        # Build all the box types (VirtualBox, VMware & Parallels)
    make test   # Run tests against all the boxes
    make list   # Print out individual targets
    make clean  # Clean up build detritus

### Proxy Settings

The templates respect the following network proxy environment variables
and forward them on to the virtual machine environment during the box creation
process, should you be using a proxy:

* http_proxy
* https_proxy
* ftp_proxy
* rsync_proxy
* no_proxy
 
### Tests

The tests are written in [Serverspec](http://serverspec.org) and require the
`vagrant-serverspec` plugin to be installed with:

    vagrant plugin install vagrant-serverspec

The `Makefile` has individual targets for each box type with the prefix
`test-*` should you wish to run tests individually for each box.

Similarly there are targets with the prefix `ssh-*` for registering a
newly-built box with vagrant and for logging in using just one command to
do exploratory testing.  For example, to do exploratory testing
on the VirtualBox training environmnet, run the following command:

    make ssh-box/virtualbox/fedora20-nocm.box

Upon logout `make ssh-*` will automatically de-register the box as well.

### Makefile.local override

You can create a `Makefile.local` file alongside the `Makefile` to override
some of the default settings.  The variables can that can be currently
used are:

* CM
* CM_VERSION
* HEADLESS
* \<iso_path\>
* UPDATE

`Makefile.local` is most commonly used to override the default configuration
management tool, for example with Chef:

    # Makefile.local
    CM := chef

Changing the value of the `CM` variable changes the target suffixes for
the output of `make list` accordingly.

Possible values for the CM variable are:

* `nocm` - No configuration management tool
* `chef` - Install Chef
* `puppet` - Install Puppet
* `salt`  - Install Salt

You can also specify a variable `CM_VERSION`, if supported by the
configuration management tool, to override the default of `latest`.
The value of `CM_VERSION` should have the form `x.y` or `x.y.z`,
such as `CM_VERSION := 11.12.4`

The variable `UPDATE` can be used to perform OS patch management.  The
default is to not apply OS updates by default.  When `UPDATE := true`,
the latest OS updates will be applied.

The variable `HEADLESS` can be set to run Packer in headless mode.
Set `HEADLESS := true`, the default is false.

Another use for `Makefile.local` is to override the default locations
for the Fedora install ISO files.

For Fedora, the ISO path variables are:

* FEDORA21_X86_64
* FEDORA20_X86_64
* FEDORA19_X86_64
* FEDORA18_X86_64
* FEDORA21_I386
* FEDORA20_I386
* FEDORA19_I386
* FEDORA18_I386

This override is commonly used to speed up Packer builds by
pointing at pre-downloaded ISOs instead of using the default
download Internet URLs:
`FEDORA20_X86_64 := file:///Volumes/Fedora-20-x86_64-DVD.iso`

### Acknowledgments

[CloudBees](http://www.cloudbees.com) is providing a hosted [Jenkins master](http://box-cutter.ci.cloudbees.com/) through their CloudBees FOSS program. Their [On-Premise Executor](https://developer.cloudbees.com/bin/view/DEV/On-Premise+Executors) feature is used to connect physical machines as build slaves running VirtualBox, VMware Fusion, VMware Workstation, VMware ESXi/vSphere and Hyper-V.

![Powered By CloudBees](http://www.cloudbees.com/sites/default/files/Button-Powered-by-CB.png "Powered By CloudBees")![Built On DEV@Cloud](http://www.cloudbees.com/sites/default/files/Button-Built-on-CB-1.png "Built On DEV@Cloud")
