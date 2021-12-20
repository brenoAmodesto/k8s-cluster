FROM ubuntu:latest
RUN apt-get update && \
    apt-get install ansible wget unzip python3-pip -y && \
    pip3 install boto && \
    wget https://releases.hashicorp.com/terraform/1.1.2/terraform_1.1.2_linux_amd64.zip -O /tmp/terraform_1.1.2_linux_amd64.zip && \
    unzip /tmp/terraform_1.1.2_linux_amd64.zip -d /usr/bin 

RUN wget https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.0.30.zip -O /tmp/awscliv2.zip \
    unzip /tmp/awscliv2.zip \
    cd /tmp && sudo ./aws/install

