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

# RUN sudo opam init --disable-sandboxing
# RUN echo "eval $(opam config env)" >> ~/.profile
# RUN opam switch create . 4.07.1

# RUN opam update && opam upgrade
# RUN opam install -y opium.0.17.0

# # RUN sudo opam init --disable-sandboxing &&\
# #     opam env &&\
# #     opam switch create . 4.07.1 &&\
# #     opam env

# # RUN opam update &&\
# #     opam install -y opium.0.17.0 lwt_log ocamlbuild &&\
# #     ocamlbuild -pkg opium benchmark.native

# RUN ocamlbuild -pkg opium benchmark.native

RUN sudo opam init --disable-sandboxing &&\
    opam env &&\
    opam switch create . 4.07.1 &&\
    opam update && opam upgrade &&\
    opam install -y opium.0.17.0 ocamlbuild &&\
    ocamlbuild -pkg opium benchmark.native

CMD ./benchmark.native
