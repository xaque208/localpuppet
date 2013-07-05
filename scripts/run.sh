#! /bin/sh

puppet apply --config /opt/pp/etc/puppet.conf /opt/pp/site/site.pp -v $@
