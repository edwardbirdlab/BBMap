FROM ubuntu:20.04

# Set environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV DEBIAN_FRONTEND=noninteractive

# Set the time zone to UTC (or any other time zone you prefer)
RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime && \
    apt-get update && \
    apt-get install -y tzdata && \
    dpkg-reconfigure --frontend noninteractive tzdata



# Install dependencies
RUN apt-get update && \
    apt-get install -y -f \
        openjdk-8-jdk \
        ant \
        wget \
        git \
        openmpi-bin \
        libopenmpi-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/BioInfoTools/BBMap.git /bbmap

WORKDIR /bbmap/jni

RUN make -f makefile.linux

# Set the working directory back to the root of the BBMap folder
WORKDIR /bbmap/sh

# Default command (can be overridden by the user)
CMD ["./bbduk.sh", "--help"]