.PHONY:
generate: generate-stl generate-png

generate-stl:
	@./scripts/generate-stl.bash

generate-png:
	@./scripts/generate-png.bash
