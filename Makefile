all: quality

# to run a single item, you can do: make QUALITY_TOOL=bigfiles quality
quality:
	@quality_gem_version=$$(python -c 'import yaml; print(yaml.safe_load(open(".circleci/config.yml","r"))["quality_gem_version"])'); \
	docker run  \
	       -v "$$(pwd):/usr/app"  \
	       -v "$$(pwd)/Rakefile.quality:/usr/quality/Rakefile"  \
	       "apiology/quality:$${quality_gem_version}" ${QUALITY_TOOL}
