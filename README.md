# git-server bosh release

The BOSH release sets up a Git server, allowing you to privately host your git repositories.

## Usage

You can find a sample deployment manifest in `manifests/example.yml` which sets up a remote for an example repository (`some-repo`).

```
$ bosh -d git-server deploy manifests/example.yml -v repos=[some-repo]
```

Once you have deployed the Git server, you can use it as a remote (e.g. `origin`) for your repo (e.g. `some-repo`) as follows:

```
$ cd some-repo
$ git remote add origin git://`bosh -d git-server is --column ips|cut -f1`/some-repo
$ git push --set-upstream origin master
```

## TODO

- Authentication
