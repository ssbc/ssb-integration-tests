#! /bin/bash

list () {
  npm show scuttlebot-release --json | node parse.js versions | grep -v -e '^9\.'
}

install () {
  version=$1
  echo install $version
  mkdir -p versions/$version/node_modules
  pushd versions/$version
  npm install scuttlebot-release@$version > /dev/null 2> /dev/null
  rm bin -f
  ln -s ./node_modules/scuttlebot-release/node_modules/scuttlebot/bin.js bin
  popd
}

install_all () {
  for version in `cat versions.txt`; do
    install $version
  done
}

"$@"

