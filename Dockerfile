FROM balenalib/raspberrypi3-64:latest-build

RUN install_packages \
  git \
  autoconf \
  automake \
  build-essential \
  libtool \
  dh-make \
  fakeroot \
  yasm \
  pkg-config \
#  libraspberrypi0 \
#  libraspberrypi-dev \
  libx264-dev

#RUN git clone https://code.videolan.org/videolan/x264.git \
#  && cd x264 \
#  && ./configure --host=arm-unknown-linux-gnueabi --enable-static --disable-opencl \
#  && make -j4 \
#  && make install \
#  && cd .. && rm -rf x264

RUN git clone --depth 1 https://github.com/mstorsjo/fdk-aac.git \
  && cd fdk-aac \
  && autoreconf -fiv \
  && ./configure --prefix=/usr \
  && make -j4 \
  && make install \
  && ldconfig \
  && cd .. && rm -rf fdk-aac

#RUN curl -O https://ffmpeg.org/releases/ffmpeg-3.4.8.tar.bz2 \
#  && tar jxf ffmpeg-3.4.8.tar.bz2 \
#  && cd ffmpeg-3.4.8 \
#  && ./configure --enable-gpl --enable-libx264 --enable-nonfree --enable-mmal --enable-omx --enable-omx-rpi --enable-libfdk-aac --prefix=/usr

#COPY ffmpeg-3.4.8.patch0 ffmpeg-3.4.8.patch0

#RUN cd ffmpeg-3.4.8 && patch -p1 < ../ffmpeg-3.4.8.patch0

#RUN cd ffmpeg-3.4.8 \
#  && make -j4 \
#  && make install \
#  && cd .. && rm -rf ffmpeg-3.4.8

RUN curl -O http://ffmpeg.org/releases/ffmpeg-4.3.tar.xz \
  && tar Jxf ffmpeg-4.3.tar.xz \
  && cd ffmpeg-4.3 \
  && ./configure --enable-gpl --enable-libx264 --enable-nonfree --enable-libfdk-aac --prefix=/usr \
  && make -j4 \
  && make install

