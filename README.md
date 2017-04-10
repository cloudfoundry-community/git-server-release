# BOSH Release for git server

The `git-server` BOSH release sets up a remote git server, allowing you to privately host
your git repositories.

## Usage

You can find a sample deployment manifest in `manifests/deployment.yml` which sets up a remote for an example repository (`some-repo`).

Once you have deployed the git server, you can use it as a remote (e.g. `origin`) for your repo (e.g. `some-repo`) as follows:

```
cd some-repo
git remote add origin git://<git-server-ip>/some-repo
git push --set-upstream origin master
```
