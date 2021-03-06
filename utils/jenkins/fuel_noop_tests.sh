#!/bin/bash

if ! [ -d "$WORKSPACE" ] ; then
  echo "ERROR: WORKSPACE not found"
  exit 1
fi

if [ -z "$PUPPET_GEM_VERSION" ] ; then
  export PUPPET_GEM_VERSION='~> 3.4.0'
fi

# Check for bundle and exit if failed
bundle --version || exit 1

export GEM_HOME=$WORKSPACE/.bundled_gems

fail=0
pushd ./tests/noop &>/dev/null
  bundle update
  bundle exec rake spec SPEC_OPTS='--format documentation --tty --color' || fail=1
popd &>/dev/null
exit $fail
