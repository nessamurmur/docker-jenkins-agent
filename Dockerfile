FROM evarga/jenkins-slave

RUN sudo apt-get update && sudo apt-get install -y unzip wget curl git && \
    wget https://releases.hashicorp.com/packer/0.9.0/packer_0.9.0_linux_386.zip && \
    unzip packer_0.9.0_linux_386.zip

USER jenkins
WORKDIR /home/jenkins

ENV NVM_DIR /home/jenkins/.nvm
ENV NODE_VERSION 0.12.7
ENV PATH=$PATH:~/packer/

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash
RUN . ~/.profile && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default \
    && nvm install v6.2.2 && nvm install 0.10.45 && nvm install v4.4.7 \
    && npm install -g grunt-cli
