# Use Conda and Python 2.7
FROM jupyter/scipy-notebook

# Install gdal into python2 environment 
# USER root
RUN conda install --yes --name python2 gdal

# Packages required for python package installs
# libgdal-dev required for rasterio
USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gcc \
        g++ \
        libgdal-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER $NB_USER
RUN pip2 install rasterio
# Use this if rasterio bindings are messed up
# RUN pip2 install --no-use-wheel rasterio

# Geo packages
RUN pip2 install \
        tqdm \
        planet \
        shapely \
        geopandas

# Additional packages
RUN pip2 install urllib3

# First try: installing using pip
# activating conda environment in a dockerfile:
# http://fmgdata.kinja.com/using-docker-with-conda-environments-1790901398
# note: python2 activated only in same RUN cmd
# USER jovyan
# RUN pip2 install ipyleaflet
# RUN ["/bin/bash", "-c", "source activate python2 && jupyter nbextension enable --py --sys-prefix ipyleaflet && jupyter nbextension enable --py --sys-prefix widgetsnbextension"]

# Second try: installing using conda (and uninstalling/reinstalling ipywidgets)

# Enable Jupyter extentions
USER $NB_USER
RUN conda install -c conda-forge --yes --name python2 ipyleaflet

RUN jupyter nbextension enable --py widgetsnbextension --sys-prefix && \
    jupyter nbextension enable --py --sys-prefix ipyleaflet && \
    jupyter nbextensions_configurator enable --user

# RUN ["/bin/bash", "-c", "source activate python2 && jupyter nbextension enable --py --sys-prefix ipyleaflet && jupyter nbextension enable --py --sys-prefix widgetsnbextension"]
# RUN ["/bin/bash", "-c", "source activate python2 && jupyter nbextension enable --py ipyleaflet && jupyter nbextension enable --py widgetsnbextension"]
# RUN ["/bin/bash", "-c", "source activate python2 && jupyter nbextension enable --py widgetsnbextension"]

USER root
RUN apt-get remove -y \                                                       
        gcc \                                                             
        g++ \
        libgdal-dev && \
    apt-get clean autoclean && \                                              
    apt-get autoremove -y && \                                                
        rm -rf /var/lib/{apt,dpkg,cache,log}/
