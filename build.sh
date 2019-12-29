#!/bin/sh

set -eu

PROTOC_VERSION=3.10.1

install_protoc() {
    if [ -d protoc ]
    then
	    return 0
    fi

    mkdir protoc

    curl -Lo /tmp/protoc.zip "https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VERSION}/protoc-${PROTOC_VERSION}-linux-x86_64.zip"
    unzip /tmp/protoc.zip -d protoc
}

build_java() {
    mkdir -p src/main/proto
    cp -f schema/*.proto src/main/proto
    mvn compile
}

install_protoc

PATH="$PWD/protoc/bin:$PATH"
export PATH
build_java
