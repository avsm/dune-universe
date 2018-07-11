#!/usr/bin/env bash
DISTRO=${DISTRO:-alpine-3.7}

set -ex
cd /home/opam/opam-repository && git pull origin master && opam update -uy
sudo rsync -a /home/opam/src/ /home/opam/build
sudo chown -R opam /home/opam/build
cd /home/opam/build
make install-depext
make install-base
make
