# Use the official Ubuntu 22.04 base image
FROM ubuntu:22.04

# Set the environment variable for non-interactive apt installation
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    tgt \
    init \
    vim && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the default command for the container (optional)
CMD ["/sbin/init"]
