#!/usr/bin/env bash
# https://gist.githubusercontent.com/geerlingguy/73ef1e5ee45d8694570f334be385e181/raw/

timestamp=$(date +%s)
cleanup=${cleanup:-"true"}
playbook=${playbook:-"test.yml"}
container_id=${container_id:-$timestamp}

ansible-playbook tests/$playbook --syntax-check

docker pull gitlab-registry.oit.duke.edu/mclibrary/server-configuration:hyrax

docker run \
  --detach \
  --privileged \
  --name $container_id \
  --publish 2222:22 \
  --publish 3000:3000 \
  --publish 80:80 \
  --publish 8080:8080 \
  --publish 8983:8983 \
  --volume /sys/fs/cgroup:/sys/fs/cgroup:ro \
  gitlab-registry.oit.duke.edu/mclibrary/server-configuration:hyrax

ansible-playbook tests/$playbook
ansible-playbook tests/$playbook

# Remove the Docker container (if configured).
if [ "$cleanup" = true ]; then
  printf "Removing Docker container...\n"
  docker rm -f $container_id
fi