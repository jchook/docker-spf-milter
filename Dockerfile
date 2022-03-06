FROM rust:1-alpine3.14

RUN apk add --no-cache \
    gcc \
    git \
    gettext \
    libc-dev \
    libmilter-dev \
    openssl-dev \
    pkgconf \
  && test -d spf-milter \
    || git clone https://gitlab.com/glts/spf-milter.git \
  && cd spf-milter \
  && cargo fetch

WORKDIR /spf-milter

COPY milter.pc /pkgconf/

# Trying to statically link this but it's not working...
# See https://github.com/rust-lang/rust/issues/39998
# See https://github.com/izderadicka/audioserve/blob/master/Dockerfile.static
# See https://gitlab.com/glts/spf-milter/-/issues/4
# ENV RUSTFLAGS="-C target-feature=-crt-static -C link-self-contained=yes"
# ENV RUSTFLAGS="-C target-feature=+crt-static -C link-self-contained=yes"

RUN PKG_CONFIG_PATH=/pkgconf cargo build --release

# ---

# FROM scratch
FROM alpine:3.14
# RUN apk add --no-cache \
#   gettext \
#   gcc \
#   openssl-dev \
#   libmilter-dev \
#   libc-dev

# COPY entrypoint.sh /
# COPY templates /templates/

# Copy config
# May wish to make this dynamic later to be able to quickly whitelist domains.
# COPY spf-milter.conf /etc/

RUN printf '%s\n' "socket = inet:0.0.0.0:3000" "log_destination = stderr" > /etc/spf-milter.conf

# Copy the compiled binary
COPY --from=0 /spf-milter/target/release/spf-milter /usr/local/bin/

# Copy the shared libraries needed
# May be able to prune some of glibc.
#
# Libs are provided by deps in this order:
#  - libssl-dev (2)
#  - libmilter-dev (1)
#  - libc6-dev (45)
#
# ENTRYPOINT ["./entrypoint.sh"]
ENTRYPOINT ["/usr/local/bin/spf-milter"]
