#!/usr/bin/env bash
DISTRO=${DISTRO:-alpine-3.7}

set -ex
sudo chown -R opam /home/opam/src
cd /home/opam/src
make install-depext
opam pin add -n jbuilder --dev
opam pin add -y dune https://github.com/ocaml/dune.git
make install-base
cd /home/opam/src
make
