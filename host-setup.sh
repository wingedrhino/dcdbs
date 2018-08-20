#!/bin/sh

printf "Setting addressable virtual memory to 262144 for ElasticSearch...\n"
sudo sysctl -w vm.max_map_count=262144
printf "...done!\n"

printf "Disable Swap...\n"
sudo swapoff -a
printf "...done!\n"

