FROM rust:1-alpine3.14
RUN apk add --no-cache gcc git libc-dev
WORKDIR /spf-milter
ARG SPF_MILTER_BRANCH=master
RUN test -d src || git clone --single-branch --branch "${SPF_MILTER_BRANCH}" \
    https://gitlab.com/glts/spf-milter.git . \
  && cargo fetch
RUN cargo build --release

# ---

FROM scratch
COPY ./rootfs/ /
COPY --from=0 /spf-milter/target/release/spf-milter /sbin/
EXPOSE 3000
ENTRYPOINT ["/sbin/spf-milter"]
CMD []

