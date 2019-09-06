From ubuntu:18.04
MAINTAINER "htanaka0828" <htanaka0828@gmail.com>

# tzdata で止まっちゃう対策
ENV DEBIAN_FRONTEND=noninteractive

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
  libxvidcore-dev libx264-dev libgtk-3-dev \
  libatlas-base-dev gfortran python3.6-dev
RUN apt -y install aptitude

RUN ["cd /root; \
  wget -O opencv.zip https://github.com/opencv/opencv/archive/4.1.1.zip; \
  unzip opencv.zip; \
  mv opencv-4.1.1 opencv; \
  wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.1.1.zip; \
  unzip opencv_contrib.zip; \
  mv opencv_contrib-4.1.1 opencv_contrib; \
  cd opencv; mkdir build; cd build; \
  cmake ../ -DCMAKE_INSTALL_PREFIX=/usr/local,\
-DOPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules,\
-DCMAKE_BUILD_TYPE=Release,\
-DBUILD_EXAMPLES=OFF,\
-DBUILD_DOCS=OFF,\
-DBUILD_TESTS=OFF,\
-DBUILD_PERF_TESTS=OFF,\
-DBUILD_JAVA=OFF,\
-DCUDA_NVCC_FLAGS=--expt-relaxed-constexpr,\
-DBUILD_opencv_apps=OFF,\
-DBUILD_opencv_aruco=OFF,\
-DBUILD_opencv_bgsegm=OFF,\
-DBUILD_opencv_bioinspired=OFF,\
-DBUILD_opencv_ccalib=OFF,\
-DBUILD_opencv_datasets=OFF,\
-DBUILD_opencv_dnn_objdetect=OFF,\
-DBUILD_opencv_dpm=OFF,\
-DBUILD_opencv_fuzzy=OFF,\
-DBUILD_opencv_hfs=OFF,\
-DBUILD_opencv_java_bindings_generator=OFF,\
-DBUILD_opencv_js=OFF,\
-DBUILD_opencv_img_hash=OFF,\
-DBUILD_opencv_line_descriptor=OFF,\
-DBUILD_opencv_optflow=OFF,\
-DBUILD_opencv_phase_unwrapping=OFF,\
-DBUILD_opencv_python=OFF,\
-DBUILD_opencv_python3=OFF,\
-DBUILD_opencv_python_bindings_generator=OFF,\
-DBUILD_opencv_reg=OFF,\
-DBUILD_opencv_rgbd=OFF,\
-DBUILD_opencv_saliency=OFF,\
-DBUILD_opencv_shape=OFF,\
-DBUILD_opencv_stereo=OFF,\
-DBUILD_opencv_stitching=OFF,\
-DBUILD_opencv_structured_light=OFF,\
-DBUILD_opencv_superres=OFF,\
-DBUILD_opencv_surface_matching=OFF,\
-DBUILD_opencv_ts=OFF,\
-DBUILD_opencv_xobjdetect=OFF,\
-DBUILD_opencv_xphoto=OFF,\
-DWITH_VTK=OFF,\
-DOPENCV_ENABLE_NONFREE=ON; \
make -j8; \
make install"]

CMD ["tail", "-f", "/dev/null"]
