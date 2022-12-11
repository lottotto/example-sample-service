
# Golang parameter(gofmt: code formatter, go vet/golist: lint tools)
ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
COMMAND_PACKAGES:=$(shell go list ./cmd/...)

TOOLS := \
		github.com/golangci/golangci-lint/cmd/golangci-lint@v1.50.0 \
		github.com/boumenot/gocover-cobertura@v1.2.0 \
		github.com/jstemmer/go-junit-report/v2@v2.0.0 \

.PHONY: test
test:
	go test -v -cover --coverprofile=cover-test.out 2>&1 ./... | _tool/go-junit-report -set-exit-code > report-test.xml
	_tool/gocover-cobertura < cover-test.out > cover-test.xml
	go tool cover -html=cover-test.out -o cover-test.html
	go tool cover -func=cover-test.out | grep 'total:'| sed -r 's/\t/ /g' 

.PHONY: lint
lint:
	_tool/golangci-lint run 

.PHONY:	build
build:	$(COMMAND_PACKAGES)

$(COMMAND_PACKAGES):
	go build -o $(lastword $(notdir $(COMMAND_PACKAGES))) $@

.PHONY: clean
clean:
	rm -f ./$(lastword $(notdir $(COMMAND_PACKAGES)))
	rm -f ./cover-*
	rm -f ./report-*


.PHONY: tools
tools:
	@ mkdir -p _tool
	@ for tool in $(TOOLS) ; do \
		GOBIN=$(ROOT_DIR)/_tool go install $$tool; \
	done
