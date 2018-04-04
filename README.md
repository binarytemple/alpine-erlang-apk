# alpine-erlang-apk
Builder for Alpine erlang apk 

Work in progress, successfully builds an ESL style Erlang 20.2.3

Uses quay.io/vektorcloud/apk-cache to cache apk dependencies between runs

## Usage

#### `make run` 

Build everything and run a shell on the generated docker image - use this target when developing/debugging builds

#### `make extract` 

Build everything and extract the resulting packages to the './packages' directory

