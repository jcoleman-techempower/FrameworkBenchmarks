FROM ubuntu:16.04

COPY ./ ./kore

# Install Kore dependencies
RUN apt update && \
  apt install -yqq \
  # json-c deps
  libjson0-dev \
  # git \
  # kore deps
  cmake curl libssl-dev

# Install core
RUN curl -sL https://kore.io/releases/kore-3.0.0.tar.gz | tar xz
WORKDIR /kore-3.0.0
RUN NOTLS=1 make
RUN make install

WORKDIR /kore

# Install json-c
# RUN rm -rf json-c
# RUN git clone https://github.com/json-c/json-c.git
# RUN sed -i 's|#include "json_config.h"||' json-c/json_inttypes.h

CMD ["kodev", "run"]
