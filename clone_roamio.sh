#!/bin/bash

# Function to print in red
print_red() {
  echo -e "\033[0;31m$1\033[0m"
}

echo "Cloning Roamio brain repository..."
git clone git@github.com:roamio-RMG/roamio_brain.git
echo "Finished cloning roamio_brain."

echo "Cloning Roamio documentation repository..."
git clone git@github.com:roamio-RMG/Docs.git
echo "Finished cloning Docs."

print_red "⚠️  Don't forget to update the sketch_path in your Arduino uploading scripts to point to the correct .ino file."
