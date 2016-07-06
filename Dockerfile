FROM evarga/jenkins-slave

RUN sudo apt-get update && sudo apt-get install -y unzip wget curl git \
    build-essential python-dev make libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
    libncurses5-dev libncursesw5-dev xz-utils libffi-dev

USER jenkins
WORKDIR /home/jenkins

ENV NVM_DIR /home/jenkins/.nvm
ENV NODE_VERSION 0.12.7

# Install Packer
RUN wget https://releases.hashicorp.com/packer/0.9.0/packer_0.9.0_linux_386.zip && \
    unzip packer_0.9.0_linux_386.zip && \
    echo 'PATH=$PATH:/home/jenkins/packer' >> ~/.profile

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash
RUN . ~/.profile && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default \
    && nvm install v6.2.2 && nvm install 0.10.45 \
    && nvm install v4.4.7 && nvm install v5.3.0 \
    && npm use default && npm install -g grunt-cli

# Install Python w/ pyenv
RUN curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash \
    && echo 'export PATH="/home/jenkins/.pyenv/bin:$PATH"' >> ~/.profile \
    && echo 'eval "$(pyenv init -)"' >> ~/.profile \
    && echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.profile \
    && . ~/.profile \
    && pyenv install 2.7.10 \
    && pyenv global 2.7.10 \
    && pip install pip==1.5.4 \
    && pip install devpi

USER root