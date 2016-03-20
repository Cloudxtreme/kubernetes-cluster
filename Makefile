format:
	find . -name "*.yaml" -exec yamlformat -write -path "{}" \;
installyamlformat:
	go get github.com/bborbe/yamlformat/bin/yamlformat
