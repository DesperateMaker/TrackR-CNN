FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04
#FROM ubuntu:18.04

#autor of docker file only
LABEL autor="thedesperatemaker@gmail.com"
ENV USER="USER"

#
# Essentials: developer tools, build tools
#
RUN apt-get update && apt-get install -y --no-install-recommends \
    git curl vim unzip openssh-client wget \
    build-essential cmake checkinstall gcc \
    tmux gnupg htop

#
# Python 3
#
# For convenience, alias (but don't sym-link) python & pip to python3 & pip3 as recommended in:
# http://askubuntu.com/questions/351318/changing-symlink-python-to-python3-causes-problems
RUN apt-get install -y --no-install-recommends python python3-pip python-dev python3-dev && \
    pip3 install --no-cache-dir --upgrade pip setuptools && \
    echo "alias python='python3'" >> /root/.bash_aliases && \
    echo "alias pip='pip3'" >> /root/.bash_aliases

#
# Pillow and it's dependencies
#
RUN apt-get install -y --no-install-recommends libjpeg-dev zlib1g-dev && \
    pip3 --no-cache-dir install Pillow

#
# Science libraries and other common packages
#
RUN pip3 --no-cache-dir install \
    numpy scipy==1.1.0 sklearn scikit-image pandas matplotlib Cython requests

#
# Tensorflow 1.13.0rc0 - CPU
#
RUN pip3 install --no-cache-dir tensorflow==1.13.0rc0 tensorflow-estimator==1.13.0 tensorflow-gpu==1.13.1

#
# OpenCV
#
RUN pip3 install --no-cache-dir opencv-python

#
# PyCocoTools
#
RUN pip3 install --no-cache-dir pycocotools

#
# TrackR-CNN depences
#
RUN pip3 install munkres imbalanced-learn vtk && \
    apt-get install -y libsm6 libxext6 libglib2.0-0 \
    libgl1-mesa-glx libegl1-mesa libxrandr2 libxss1 libxcursor1 \
    libxcomposite1 libasound2 libxi6 libxtst6


    
#set a directory for the app
WORKDIR /usr/src/TrackR-CNN

#copy all the files to the container
COPY . .

RUN mkdir forwarded models summaries logs data
#run the command
#CMD ["python","./main.py"]

#RUN apt-get install -y nvidia-cuda-toolkit
#RUN pip3 install --no-cache-dir tensorflow-gpu==1.13.1

#RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-repo-ubuntu1804_10.0.130-1_amd64.deb
#RUN dpkg -i cuda-repo-ubuntu1804_10.0.130-1_amd64.deb &&  apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub 

#RUN apt-get update
# && apt-get install -y cuda
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
