#!/bin/bash

set -eux

version="$1"

if [[ "$version" == "" ]]; then
	version=`git describe --tags`
fi

if [[ "$version" == "" ]]; then
	echo "Error: Cannot determine version"
	exit 1
fi

export GOPATH="/tmp/.gobuild"
SRCDIR="${GOPATH}/src/github.com/liamg/furious"

[ -d ${GOPATH} ] && rm -rf ${GOPATH}
mkdir -p ${GOPATH}/{src,pkg,bin}
mkdir -p ${SRCDIR}
cp -r . ${SRCDIR}
(
    echo ${GOPATH}
    cd ${SRCDIR}
    go build -ldflags "-X github.com/liamg/furious/version.Version=$version"
)
cp ${SRCDIR}/furious ./furious
rm -rf /tmp/.gobuild