FROM evarga/jenkins-slave

RUN sudo apt-get update && sudo apt-get install -y unzip wget curl git python-setuptools python-dev

RUN easy_install pip==1.5.4 && pip install devpi

USER jenkins
WORKDIR /home/jenkins

ENV NVM_DIR /home/jenkins/.nvm
ENV NODE_VERSION 0.12.7
ENV PATH=$PATH:~/packer/

# Install Packer
RUN wget https://releases.hashicorp.com/packer/0.9.0/packer_0.9.0_linux_386.zip && \
    unzip packer_0.9.0_linux_386.zip

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash
RUN . ~/.profile && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default \
    && nvm install v6.2.2 && nvm install 0.10.45 \
    && nvm install v4.4.7 && nvm install v5.3.0 \
    && npm install -g grunt-cli

USER root