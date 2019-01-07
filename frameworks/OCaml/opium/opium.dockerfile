FROM ubuntu:18.04

RUN apt update && apt install -y software-properties-common
RUN add-apt-repository -y ppa:avsm/ppa
RUN apt update
RUN apt install -y opam\
                   m4\
                   build-essential\
                   ocaml\
                   ocaml-native-compilers\
                   sudo

WORKDIR /home
COPY . .

RUN sudo opam init --disable-sandboxing &&\
    opam env &&\
    opam switch create . 4.07.1 &&\
    opam update && opam upgrade &&\
    opam install -y opium.0.17.0 &&\
    opam exec config -- ocamlbuild -pkg opium benchmark.native

CMD ./benchmark.native
