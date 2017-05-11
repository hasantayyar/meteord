#!/bin/bash
set -e
echo '>> INSTALL BASE'
apt-get update -y
echo '> Installing system requirements'
apt-get install -y libcairo2-dev libjpeg-dev libgif-dev curl bzip2 build-essential g++ python git
