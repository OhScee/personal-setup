FROM ubuntu:latest
# LABEL Vincent S.C.

# Base inspiration:
# https://github.com/thornycrackers/docker-neovim/blob/master/Dockerfile
########################################
# System Stuff
########################################

# Better terminal support
ENV TERM xterm
ENV DEBIAN_FRONTEND noninteractive

ADD requirements_py3.txt /opt/requirements_py3.txt
ADD requirements_py2.txt /opt/requirements_py2.txt

# Update and install
RUN apt-get update && apt-get install -y \
  htop \
  zsh \
  curl \
  wget \
  git \
  software-properties-common \
  python-dev \
  python2 \
  python3-dev \
  python3-pip \
  ctags \
  shellcheck \
  netcat \
  ack-grep \
  sqlite3 \
  unzip \
  build-essential \
  swig \
  # For python crypto libraries
  libavahi-compat-libdnssd-dev \
  libfreetype6 \
  libfreetype6-dev \
  libssl-dev \
  libffi-dev \
  locales \
  # For Youcompleteme (although I don't use this pacakge, personally. Still good to have for compiling c based software)
  cmake \
  neovim

# Install OhMyZsh
# && wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

# Generally a good idea to have these, extensions sometimes need them
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Install pip for python2
RUN curl https://bootstrap.pypa.io/get-pip.py --output /opt/get-pip.py \
&& python2 /opt/get-pip.py \

# Install NVM (Node) WIP
&& curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | zsh \

#######################################
# Adding all those python requirements
#######################################
&& pip install freetype-py \
&& cd /opt && pip install -r requirements_py2.txt \
&& cd /opt && pip3 install -r requirements_py3.txt

WORKDIR ~

# start zsh
CMD ["zsh"]
