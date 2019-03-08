#!/bin/sh

cd /opt

VERSION=$(curl -s -L http://mirrors.ocf.berkeley.edu/apache/maven/maven-3 | grep 3.[0-9].[0-9] | sed  s/'.*\(3.[0-9].[0-9]\).*'/\\1/g | sort --version-sort | tail -n 1)

sudo wget "http://mirrors.ocf.berkeley.edu/apache/maven/maven-3/${VERSION}/binaries/apache-maven-${VERSION}-bin.tar.gz"
sudo tar xzvf "apache-maven-${VERSION}-bin.tar.gz"  --transform "s/apache-maven-${VERSION}/apache-maven/"
sudo rm "apache-maven-${VERSION}-bin.tar.gz"
sudo ln -s /opt/apache-maven/bin/mvn /usr/local/bin
