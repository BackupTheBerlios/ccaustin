#!/bin/bash

#
# Creates a new usecase from a template and saves it into the docs/usecase directory
#
# TODO: Make this script friendlier, with help if no args are present
# NOTE: Must quote the usecase name or else its interpreted as another arg
#
echo ant usecase-create -Dusecase.id=$1 -Dusecase.name="$2"
ant usecase-create -Dusecase.id=$1 -Dusecase.name="$2"