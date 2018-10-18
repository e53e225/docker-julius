FROM ubuntu:18.04 AS build

# install build dependencies
RUN apt-get update && \
    apt-get install --yes \
        curl \
        gcc \
        libasound2-dev \
        make \
        && \
    apt-get clean

ARG VERSION

# download source code
RUN curl -fsSL https://github.com/julius-speech/julius/archive/v${VERSION}.tar.gz | tar -zx && \
    mv /julius-${VERSION} /julius

# build
WORKDIR /julius
RUN ./configure --prefix=/usr/local/lib/julius --with-mictype=alsa && \
    make && \
    make install

FROM ubuntu:18.04

# install runtime dependencies
RUN apt-get update && \
    apt-get install --yes \
        libasound2 \
        && \
    apt-get clean

# install julius
COPY --from=build /usr/local/lib/julius /usr/local
