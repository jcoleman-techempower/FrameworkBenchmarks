FROM ubuntu:16.04

RUN apt update
RUN apt install -yqq m4 ocaml ocaml-native-compilers camlp4-extra opam


WORKDIR /home
COPY . .

RUN opam init --auto-setup
RUN opam switch "4.05.0"
RUN eval $(opam config env)
RUN opam pin add opium -y --dev-repo
RUN ocamlbuild -pkg opium benchmark.native

CMD ./benchmark.native
