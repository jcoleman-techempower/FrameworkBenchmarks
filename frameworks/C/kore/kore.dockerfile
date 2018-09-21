FROM ubuntu:16.04

# Install Kore dependencies
RUN apt update && \
  apt install -yqq \
  # json-c deps
  libjson0-dev \
  # kore deps
  cmake curl libssl-dev

# Install core
RUN curl -sL https://kore.io/releases/kore-3.0.0.tar.gz | tar xz
WORKDIR /kore-3.0.0
RUN NOTLS=1 make
RUN make install

COPY ./ /kore
WORKDIR /kore

CMD ["kodev", "run"]
