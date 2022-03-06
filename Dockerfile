FROM rust:1-alpine3.14

ARG SPF_MILTER_BRANCH=master

RUN apk add --no-cache \
    gcc \
    git \
    libc-dev \
  && test -d spf-milter \
    || git clone --single-branch --branch "${SPF_MILTER_BRANCH}" https://gitlab.com/glts/spf-milter.git \
  && cd spf-milter \
  && cargo fetch

WORKDIR /spf-milter

# Trying to statically link this but it's not working...
# See https://github.com/rust-lang/rust/issues/39998
# See https://github.com/izderadicka/audioserve/blob/master/Dockerfile.static
# See https://gitlab.com/glts/spf-milter/-/issues/4
# ENV RUSTFLAGS="-C target-feature=-crt-static -C link-self-contained=yes"
# ENV RUSTFLAGS="-C target-feature=+crt-static -C link-self-contained=yes"

RUN PKG_CONFIG_PATH=/pkgconf cargo build --release

# ---

FROM scratch
# FROM alpine:3.14

# Copy base config
COPY ./rootfs/ /

# Copy compiled binary
COPY --from=0 /spf-milter/target/release/spf-milter /usr/local/bin/

# Listens on 3000 by default
EXPOSE 3000

# Ideally this works with FROM scratch... but doesn't b/c
#
# > failed to create shim: OCI runtime create failed: runc create failed: unable
# to start container process: exec: "/bin/sh": stat /bin/sh: no such file or
# directory: unknown
#
# AHHH I see I needed to unset the default CMD
ENTRYPOINT ["/usr/local/bin/spf-milter"]
CMD []
