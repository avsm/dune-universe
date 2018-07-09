#!/usr/bin/env bash
DISTRO=${DISTRO:-alpine-3.7}

set -ex
make install-depext
sudo chown -R opam /home/opam/src
cd /home/opam/src
opam pin add -n jbuilder --dev
opam pin add -y dune https://github.com/ocaml/dune.git
make install-base
cd /home/opam/src
make
