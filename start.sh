#!/bin/bash
NOTEBOOK_DIR="$HOME/notebooks"

# Create the notebooks directory if it does not exist
if [ ! -d "$NOTEBOOK_DIR" ]; then
    mkdir -p "$NOTEBOOK_DIR"
fi

# Build the Docker image
docker build -t jupyterlab-conda-image .

# Run the Docker container
docker run -d -p 8889:8888 -v "$NOTEBOOK_DIR":/usr/src/app/notebooks jupyterlab-conda-image