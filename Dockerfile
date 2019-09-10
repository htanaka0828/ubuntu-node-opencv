From ubuntu:18.04
MAINTAINER "htanaka0828" <htanaka0828@gmail.com>

# tzdata で止まっちゃう対策
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /usr/local/src

RUN apt-get -y update

# package install
RUN apt-get -y install git curl wget build-essential checkinstall cmake unzip pkg-config yasm gfortran python libgtk2.0-dev software-properties-common libjpeg-dev libpng-dev libtiff-dev

# nodejs install
RUN git clone https://github.com/creationix/nvm.git ~/.nvm
RUN echo "source /root/.nvm/nvm.sh" >> /root/.bashrc
RUN ["/bin/bash", "-c", " \
  source /root/.nvm/nvm.sh; \
  nvm install 10.16.0"]

RUN add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"
RUN apt update
RUN apt -y install libjasper1 libjasper-dev
RUN apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
  python-dev python-numpy \
  libxvidcore-dev libx264-dev libgtk-3-dev \
  libatlas-base-dev gfortran python3.6-dev
RUN apt-get -y install  libjpeg8-dev libpng12-dev libdc1394-22-dev libxine2-dev libtbb-dev
RUN apt -y install aptitude

RUN wget -O opencv.zip https://github.com/opencv/opencv/archive/3.4.3.zip && \
  unzip opencv.zip && \
  mv opencv-3.4.3 opencv && \
  wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/3.4.3.zip && \
  unzip opencv_contrib.zip && \
  mv opencv_contrib-3.4.3 opencv_contrib

RUN cd opencv && mkdir build && cd build && \
  cmake -D CMAKE_BUILD_TYPE=Release \
  -D CMAKE_INSTALL_PREFIX=/usr/local \
  -D WITH_TBB=ON \
  -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules .. && \
make -j7 && make install
RUN echo /usr/local/lib > /etc/ld.so.conf.d/opencv.conf
RUN ldconfig -v
