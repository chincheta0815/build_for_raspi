# Cross compilation environment for raspi

FROM debian:bullseye

RUN apt-get update

RUN apt-get install -y build-essential libyaml-dev \
 swig python-dev pkg-config \
 qtbase5-dev \
 curl unzip git yasm cmake clang

COPY docker/docker-build-tools.sh ./
RUN mkdir ./essentia
COPY essentia ./essentia

ENV PREFIX /usr/local
ENV PKG_CONFIG_PATH=${PREFIX}/lib/pkgconfig
ENV ESSENTIA_3RDPARTY_VERSION v2.1_beta5-810-gafec9ed7
ENV PATH /usr/local/bin:$PATH

RUN /docker-build-tools.sh && rm /docker-build-tools.sh

CMD ["/bin/bash"]
