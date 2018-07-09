PACKAGES=opam-devel dune-release utop bun odoc merlin ocp-indent craml mirage mirage-types-lwt async core_extended patdiff
PINS=ocp-indent odoc tyxml ocamlformat merlin ppx_tools_versioned
INSTALLS=vendor/ocp-indent/ocp-indent.install vendor/opam-core/opam-client.install vendor/merlin/merlin.install vendor/odoc/odoc.install vendor/dune-release/dune-release.install vendor/utop/utop.install vendor/bun/bun.install vendor/opam-ci/opam-ci.install vendor/mirage/mirage.install

build:
	cd vendor/lwt && ocaml src/util/configure.ml -use-libev false
	cd vendor/markup && ocaml src/configure.ml
	dune build --profile=release @install

vendor:
	$(MAKE) v-lock
	$(MAKE) v-pull
	$(MAKE) v-merge

doc:
	dune build --profile=release @doc

clean:
	dune clean

v-lock:
	duniverse vendor-lock $(PINS:%=--pin %) $(PACKAGES) -v

v-pull:
	duniverse vendor-pull -v

v-merge:
	duniverse vendor-merge -v
	rm -rf vendor/sexplib/num
	rm -rf vendor/alcotest/async
	rm -rf vendor/csv/tests
	rm -rf vendor/cstruct/async
	git commit -m 'trim vendor' vendor/ || true

.PHONY: vendor build
