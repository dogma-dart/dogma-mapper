#!/bin/sh
set -ex

# Clone dependencies
git clone https://github.com/dogma-dart/dogma-connection.git ../dogma-connection
git clone https://github.com/dogma-dart/dogma-convert.git ../dogma-convert

# Get version
dart --version

# Install dependencies
pub install

# Run the linter
pub global activate linter
pub global run linter .
