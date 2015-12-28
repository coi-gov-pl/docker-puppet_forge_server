#!/bin/bash
#
# run.sh
#
# Author: Matteo Cerutti <matteo.cerutti@hotmail.co.uk>
#

PUPPET_FORGE_SERVER_PORT=${PUPPET_FORGE_SERVER_PORT:-8080}
PUPPET_FORGE_SERVER_USER=${PUPPET_FORGE_SERVER_USER:-$(whoami)}
homedir=$( getent passwd "${PUPPET_FORGE_SERVER_USER}" | cut -d: -f6 )
PUPPET_FORGE_SERVER_CACHE_DIR=${PUPPET_FORGE_SERVER_CACHE_DIR:-${homedir}/cache}
PUPPET_FORGE_SERVER_LOG_DIR=${PUPPET_FORGE_SERVER_LOG_DIR:-${homedir}/logs}

PUPPET_FORGE_SERVER_OPTS=
if [ -n "$PUPPET_FORGE_SERVER_MODULEDIR" ]; then
  for moduledir in $PUPPET_FORGE_SERVER_MODULEDIR; do
    PUPPET_FORGE_SERVER_OPTS="$PUPPET_FORGE_SERVER_OPTS --module-dir $moduledir"
    mkdir -p $moduledir
  done
fi

if [ -n "$PUPPET_FORGE_SERVER_PROXY" ]; then
  for proxy in $PUPPET_FORGE_SERVER_PROXY; do
    PUPPET_FORGE_SERVER_OPTS="$PUPPET_FORGE_SERVER_OPTS --proxy $proxy"
  done
fi

PUPPET_FORGE_SERVER_DEBUG=${PUPPET_FORGE_SERVER_DEBUG:-0}
[ $PUPPET_FORGE_SERVER_DEBUG -eq 1 ] && PUPPET_FORGE_SERVER_OPTS="$PUPPET_FORGE_SERVER_OPTS --debug"

# prepare directories
mkdir -p $PUPPET_FORGE_SERVER_CACHE_DIR
mkdir -p $PUPPET_FORGE_SERVER_LOG_DIR

echo "Starting puppet-forge-server"
exec bundle exec puppet-forge-server \
  --port $PUPPET_FORGE_SERVER_PORT \
  --cache-basedir $PUPPET_FORGE_SERVER_CACHE_DIR \
  --ram-cache-ttl 1800 \
  --ram-cache-size 1000 \
  --log-dir $PUPPET_FORGE_SERVER_LOG_DIR \
  $PUPPET_FORGE_SERVER_OPTS
