#!/bin/bash

bundle update --bundler
echo "===================================================================================="
lsb_release -a
echo "===================================================================================="
echo "Using $(ruby --version)"
echo "Using $(bundle --version)"
echo "Using Node.js $(node -v)"
echo "Using NPM v$(npm -v)"
echo "===================================================================================="

exec "$@"
