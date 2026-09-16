#!/usr/bin/env bash

echo "Starting installation..."

# update the package lists so we get the latest versions
sudo apt update

# install git so we can use version control
sudo apt install -y git

echo "Installation complete!"
