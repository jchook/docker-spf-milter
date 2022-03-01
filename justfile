build:
  docker build -t spf-milter .

run:
  docker run --init --rm --name spf-milter -it -v cargo:/usr/local/cargo:rw spf-milter

sh:
  docker exec -it spf-milter sh
