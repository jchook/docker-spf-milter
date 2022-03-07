SPF Milter Docker
=================

Packages [spf-milter](https://gitlab.com/glts/spf-milter) as a Docker image.

- FROM scratch
- Runs as nobody by default
- Super tiny 7.5MB (only 2MB compressed)
- v0.4.0+

Related links:

- [DockerHub image](https://hub.docker.com/r/jchook/spf-milter)
- [GitHub repository](https://github.com/jchook/docker-spf-milter)


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

# Change the port number and log-level
docker run --init --rm -p 7007:3000 -t jchook/spf-milter:latest --log-level debug

# Mount your own config file as a volume
docker run --init --rm -p 4242:4242 -t -v "$(pwd)/spf-milter.conf":/etc/spf-milter.conf:ro jchook/spf-milter:latest
```

Alternatively, you can make your own Dockerfile,

```dockerfile
FROM jchook/spf-milter:latest
COPY ./spf-milter.conf /etc/
```

