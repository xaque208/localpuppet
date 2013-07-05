#! /bin/sh

NAME=$(uname)

case $NAME in
  FreeBSD)
    chmod 0700 /opt/pp
    chown 0:0 /opt/pp
    pkg install -y git puppet rubygem-bundler
    cd /opt/pp
    bundle
    ;;
  Darwin)
    echo "No."
    ;;
esac
