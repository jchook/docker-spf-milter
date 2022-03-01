#!/bin/sh

[ -z "$TEMPLATE_DIR" ] && TEMPLATE_DIR=/templates

if [ -f "$TEMPLATE_DIR/spf-milter.conf" ]; then
  envsubst \
    < $TEMPLATE_DIR/spf-milter.conf \
    > /etc/spf-milter.conf
fi

exec spf-milter

