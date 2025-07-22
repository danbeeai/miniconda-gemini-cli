FROM continuumio/miniconda3:latest AS base

RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

LABEL Name="miniconda-gemini-cli Version=0.0.1"
LABEL maintainer="Donny Seo <jams7777@gmail.com>"

RUN apt update \
    && apt install -y curl sudo vim ssh git wget unzip lsb-release ca-certificates gnupg

RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt install -y nodejs

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list  \
    && apt update  \
    && apt install yarn

ENV NPM_CONFIG_LOGLEVEL=warn
ENV NODE_VERSION=22.17.1

RUN mkdir /opt/app

# Create app directory 
WORKDIR /opt/app

# Install gemini-cli global dependencies as root
RUN npm install -g @google/gemini-cli

# ENV GEMINI_API_KEY=apikey

# Volume setting
VOLUME ["/opt/app"]

# Port setting
EXPOSE 8888 3000 5000 

# entrypoint
CMD ["/bin/bash"]
