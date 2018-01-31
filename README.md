# Docker image for Puppet Forge Server
Docker image to run a private Puppet Forge Server (https://github.com/unibet/puppet-forge-server)

See the usage section for more details.

## Usage
Generic configuration can be driven by exporting the following enviroment variables:

| Environment variable  | Description |
| ------------- | ------------- |
| PUPPET_FORGE_SERVER_PORT | Port number to bind to (default: 8080) |
| PUPPET_FORGE_SERVER_CACHE_DIR | Proxy module cache base directory (default: /srv/puppet-forge-server/cache) |
| PUPPET_FORGE_SERVER_LOG_DIR | Log directory (default: /srv/puppet-forge-server/logs) |
| PUPPET_FORGE_SERVER_MODULEDIR | Directory containing packaged modules (recursively searched) |
| PUPPET_FORGE_SERVER_USER | User that will run server process (default: forge)
| PUPPET_FORGE_SERVER_PROXY | Remote forge URL |
| PUPPET_FORGE_SERVER_DEBUG | Log everything into STDERR |

By default container is build to use user `forge` with uid: 576. If you like to use other uid, the image needs to be rebuild for ex.:

```
FROM m4ce/puppet-forge-server
ENV PUPPET_FORGE_SERVER_USER_ID 999
```

## Run
```
docker run -d --restart=always -p 8080:8080 \
  -e PUPPET_FORGE_SERVER_MODULEDIR=/srv/puppet-forge-server/modules \
  -v <path_to_modules>:/srv/puppet-forge-server/modules \
  m4ce/puppet-forge-server
```

## Contact
Centralny Osrodek Informatyki - coi@coi.gov.pl

Original version created by Matteo Cerutti - matteo.cerutti@hotmail.co.uk
