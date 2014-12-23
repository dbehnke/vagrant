#!/bin/bash

packer build -only=virtualbox-iso arch-x2go-client.json
