FROM ubuntu:22.04

# Set non-interactive frontend
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    wget \
    software-properties-common \
    build-essential \
    sudo \
    libssl-dev \
    libreadline-dev \
    zlib1g-dev \
    bash-completion \
    ca-certificates \
    gnupg \
    lsb-release

# Create non-root user (optional)
RUN useradd -ms /bin/bash devuser && echo "devuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER devuser
WORKDIR /home/devuser

# Setup environment paths
ENV HOME=/home/devuser
ENV PATH="$HOME/.tfenv/bin:$HOME/.asdf/bin:$HOME/.asdf/shims:$PATH"

# Install tfenv and latest Terraform
RUN git clone https://github.com/tfutils/tfenv.git ~/.tfenv && \
    echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bashrc && \
    tfenv install latest && \
    tfenv use latest

# Install asdf
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0 && \
    echo '. "$HOME/.asdf/asdf.sh"' >> ~/.bashrc && \
    echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.bashrc

# Load asdf
SHELL ["/bin/bash", "-c"]
RUN . "$HOME/.asdf/asdf.sh" && \
    asdf plugin-add kubectl https://github.com/asdf-community/asdf-kubectl.git && \
    asdf install kubectl latest && \
    asdf global kubectl latest && \
    \
    asdf plugin-add helm https://github.com/Antiarchitect/asdf-helm.git && \
    asdf install helm latest && \
    asdf global helm latest && \
    \
    asdf plugin-add awscli https://github.com/MetricMike/asdf-awscli.git && \
    asdf install awscli latest && \
    asdf global awscli latest

# Install aws-iam-authenticator
RUN curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/latest/bin/linux/amd64/aws-iam-authenticator && \
    chmod +x aws-iam-authenticator && \
    sudo mv aws-iam-authenticator /usr/local/bin/

# Default shell on container startup
CMD ["/bin/bash"]
