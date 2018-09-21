FROM ubuntu:16.04

COPY ./ ./kore

# Install Kore dependencies
RUN apt update && \
  apt install -yqq \
  # json-c deps
  autoconf automake git libtool \
  # kore deps
  cmake curl libssl-dev

# Install json-c
WORKDIR /
RUN git clone https://github.com/json-c/json-c.git
WORKDIR /json-c
RUN mkdir -p build
WORKDIR /json-c/build
RUN cmake -DBUILD_SHARED_LIBS=On ../
RUN make
RUN make install

WORKDIR /

# Install core
RUN curl -sL https://kore.io/releases/kore-3.0.0.tar.gz | tar xz
WORKDIR /kore-3.0.0
RUN NOTLS=1 make
RUN make install

WORKDIR /kore

CMD ["kodev", "run"]
