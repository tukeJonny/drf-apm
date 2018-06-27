#!/usr/bin/env bash

set -euo pipefail

# For elasticsearch
sudo sysctl -w vm.max_map_count=262144
