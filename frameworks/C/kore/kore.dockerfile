FROM ubuntu:16.04

# Install Kore dependencies
RUN apt update && apt install -yqq libjson0-dev cmake curl libssl-dev

# Install core
RUN curl -sL https://kore.io/releases/kore-3.0.0.tar.gz | tar xz
WORKDIR /kore-3.0.0
RUN NOTLS=1 make
RUN make install

COPY ./ /kore
WORKDIR /kore

CMD ["kodev", "run"]
