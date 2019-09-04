From ubuntu:18.04
MAINTAINER "たなかひかる" <htanaka0828@gmail.com>

# tzdata で止まっちゃう対策
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update

# dev tools and package install
RUN apt-get -y install vim git curl mysql-client build-essential checkinstall cmake unzip pkg-config yasm gfortran python libgtk2.0-dev

# nodejs install
RUN git clone https://github.com/creationix/nvm.git ~/.nvm
RUN echo "source /root/.nvm/nvm.sh" >> /root/.bashrc
RUN ["source /root/.nvm/nvm.sh; nvm install 9.11.2; npm i -g opencv4node"]

CMD ["tail -f /dev/null"]
