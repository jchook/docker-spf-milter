SPF Milter Docker
=================

Packages [spf-milter](https://gitlab.com/glts/spf-milter) as a Docker image.

- FROM scratch
- Super tiny 7.5MB (only 2MB compressed)
- v0.4.0+

Quick Start
-----------

```sh
docker run --init --rm -p 3000:3000 -t jchook/spf-milter:latest
```

Configuration
-------------

You can easily configure spf-milter using the command line arguments.

```sh
# Show help
docker run --init --rm -t jchook/spf-milter:latest --help

# Pass in config
# Change the port number and log-level
docker run --init --rm -p 7007:3000 -t jchook/spf-milter:latest --log-level debug
```

Alternatively you can make your own Dockerfile.

```dockerfile
FROM jchook/spf-milter:latest
COPY ./spf-milter.conf /etc/
```

License
-------

MIT.
