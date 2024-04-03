# Use Miniconda base image
FROM continuumio/miniconda3

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy requirements.txt into the image
COPY requirements.txt ./

# Install JupyterLab, SoS (Script of Scripts) kernel, and other dependencies
RUN conda install -c conda-forge git nodejs sos-r sos-bash jupyter-sysml-kernel python==3.10 -y \
    && pip install -r requirements.txt \
    && python -m sos_notebook.install

RUN sed -i 's|\"ISYSML_API_BASE_PATH\": \"http://sysml2.intercax.com:9000\"|\"ISYSML_API_BASE_PATH\": \"http://sysmlapiserver:9000\"|g' /opt/conda/share/jupyter/kernels/sysml/kernel.json

# Build JupyterLab to incorporate extensions
RUN jupyter lab build

# Make port 8888 available to the world outside this container
EXPOSE 8888

# Set the notebooks directory as the working directory
WORKDIR /usr/src/app/notebooks

# Run JupyterLab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--NotebookApp.token=''"]