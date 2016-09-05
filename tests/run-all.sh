#!/bin/bash
set -o errexit -o pipefail -o nounset -o xtrace

DIR=$(dirname "$0")

for f in $(find $DIR -type f -name '*.yml'); do
  ansible-playbook -i localhost, --syntax-check "$f"
  ansible-lint "$f"
  ansible-playbook -i test, -e distro=$IMAGE "$f"
done
