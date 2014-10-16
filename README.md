# grounds.io
[ ![Codeship Status for grounds/grounds.io](https://codeship.io/projects/ad989680-2460-0132-1117-12e55c6fdf6c/status)](https://codeship.io/projects/36826)

This project is the web application behind [Grounds](http://beta.42grounds.io).

`Grounds` aims to provide a way to share runnable snippets within various languages from a web browser.

All you need is `docker` and `rake` to run this project inside
`docker`containers with the same environment as in production.

`Grounds` uses a `socket.io` server to execute arbitrary code inside `docker` containers, called `grounds-exec`. `grounds-exec` has its own repository
[here](https://github.com/grounds/grounds-exec).

## Run

`Grounds` uses the latest version of `grounds-exec` and will automatically
pull the official `docker` image.

`Grounds` requires a `redis` instance and will automatically spawn a `docker`
container with a new `redis` instance.

You need to specify a `docker` remote API url to connect with.

e.g. With `boot2docker` on `darwin`:

    DOCKER_URL="http://192.168.59.103:2375" rake run

## Tests

Tests will also run inside `docker` containers with the same environment
as the CI server.

    rake test

## Contributing

Before sending a pull request, please checkout the contributing
[guidelines](https://github.com/grounds/grounds-exec/blob/master/docs/CONTRIBUTING.md).

## Licensing

`grounds.io` is licensed under the MIT License. See `LICENSE` for full license
text.
