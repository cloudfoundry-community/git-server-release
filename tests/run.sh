#!/bin/bash

set -e -x

cd $PWD/..

echo "-----> `date`: Deleting old deployment"
bosh -n -d git-server delete-deployment

echo "-----> `date`: Deploying git server"
bosh -n -d git-server deploy manifests/example.yml -o manifests/dev.yml -v repos=[some-repo,another-repo]

echo "-----> `date`: Push some-repo"
cd $(mktemp -dt git)
git init
echo foo > foo
git add -A
git commit -m "foo"
git remote add origin git://`bosh -d git-server is --column ips|cut -f1`/some-repo
git push --set-upstream origin master

echo "-----> `date`: Push another-repo"
cd $(mktemp -dt git)
git init
echo another > another
git add -A
git commit -m "another"
git remote add origin git://`bosh -d git-server is --column ips|cut -f1`/another-repo
git push --set-upstream origin master

echo "-----> `date`: Cloning into different directory"
cd $(mktemp -dt git)
git clone git://`bosh -d git-server is --column ips|cut -f1`/some-repo .
[ "t$(cat foo)" == "tfoo" ] || (echo "Foo file was not there"; exit 1)

echo "-----> `date`: Recreating deployment"
bosh -n -d git-server recreate

echo "-----> `date`: Rechecking persistent data"
cd $(mktemp -dt git)
git clone git://`bosh -d git-server is --column ips|cut -f1`/some-repo .
[ "t$(cat foo)" == "tfoo" ] || (echo "Foo file was not there"; exit 1)

echo "-----> `date`: Deleting deployment"
bosh -n -d git-server delete-deployment
