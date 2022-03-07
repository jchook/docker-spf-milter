tag := "jchook/spf-milter:latest"
name := "spf-milter"

build:
  docker build -t {{tag}} .

docs:
  grip

push:
  docker push {{tag}}

run:
  docker run --init --rm --name {{name}} -it -v cargo:/usr/local/cargo:rw {{tag}}

sh:
  docker exec -it {{name}} sh

