# Use the official Ubuntu 20.04 base image
FROM ubuntu:20.04

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create a non-root user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m --shell /bin/bash  $USERNAME

# Install sudo and add the user to the sudoers
RUN apt-get update && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Set the working directory to /usr/src
WORKDIR /usr/src

# Install necessary packages for building with recommends
RUN apt-get update && \
    apt-get install -y \
    g++ \
    gcc \
    gdb-multiarch \
    gcc-arm-none-eabi \
    binutils-arm-linux-gnueabi \
    gcc-arm-linux-gnueabi

# Install necessary packages for building no recommends
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    wget \
    ca-certificates \
    git \
    autoconf \
    gperf \
    qemu-system-arm \
    qemu-user \
    bison \
    flex \
    python3 \
    python3.8-venv \
    default-jdk \
    default-jre

# Clone Icarus Verilog repository
RUN git clone https://github.com/steveicarus/iverilog.git

# Build and install Icarus Verilog
WORKDIR /usr/src/iverilog
RUN git checkout --track -b v11-branch origin/v11-branch && \
    sh autoconf.sh && \
    ./configure && \
    make && \
    make install

# Cleanup to reduce image size
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /usr/src/iverilog

# Switch to the non-root user
USER $USERNAME

# Set the working directory
WORKDIR /workspaces