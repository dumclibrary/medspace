#!/bin/bash

solr_wrapper --config config/solr_wrapper_test.yml > tmp/solr_wrapper_test.log 2>&1 &
fcrepo_wrapper --config config/fcrepo_wrapper_test.yml > tmp/fcrepo_wrapper_test.log 2>&1 &