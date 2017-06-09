# Use Conda and Python 2.7
# Use Conda and Python 2.7
FROM jupyter/scipy-notebook

USER root

# Install gdal into python2 environment 
RUN conda install --yes --name python2 gdal

# Packages required for python package installs
# libgdal-dev required for rasterio
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gcc \
        g++ \
        libgdal-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER jovyan
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

# Cleanup
USER root
RUN apt-get remove -y \                                                       
        gcc \                                                             
        g++ \
        libgdal-dev && \
    apt-get clean autoclean && \                                              
    apt-get autoremove -y && \                                                
        rm -rf /var/lib/{apt,dpkg,cache,log}/
