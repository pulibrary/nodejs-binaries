# nodejs-binaries
Alternative compiled node-js binaries.

### Ansible Instructions

Insert into `group_vars/{playbook}/{stage}.yml`:
```
nodejs_release_url_alt: "https://github.com/pulibrary/nodejs-binaries/releases/download/"
desired_nodejs_version: "v18.18.0"
```
