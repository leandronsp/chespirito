# chespirito

![rubygems](https://badgen.net/rubygems/n/chespirito)
![rubygems](https://badgen.net/rubygems/v/chespirito/latest)
![rubygems](https://badgen.net/rubygems/dt/chespirito)

![Build](https://github.com/leandronsp/chespirito/actions/workflows/build.yml/badge.svg)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-community-brightgreen.svg)](https://rubystyle.guide)
```
  ______  __    __   _______     _______..______    __  .______       __  .___________.  ______
 /      ||  |  |  | |   ____|   /       ||   _  \  |  | |   _  \     |  | |           | /  __  \
|  ,----'|  |__|  | |  |__     |   (----`|  |_)  | |  | |  |_)  |    |  | `---|  |----`|  |  |  |
|  |     |   __   | |   __|     \   \    |   ___/  |  | |      /     |  |     |  |     |  |  |  |
|  `----.|  |  |  | |  |____.----)   |   |  |      |  | |  |\  \----.|  |     |  |     |  `--'  |
 \______||__|  |__| |_______|_______/    | _|      |__| | _| `._____||__|     |__|      \______/
```

[chespirito](https://rubygems.org/gems/chespirito) is a dead simple, yet Rack-compatible, web framework written in Ruby.

## Requirements

Ruby

## Development tooling

Make and Docker

## Using make

```bash
$ make help
```
Output:
```
Usage: make <target>
  help                       Prints available commands
  bundle.install             Installs the Ruby gems
  bash                       Creates a container Bash
  run.tests                  Runs Unit tests
  rubocop                    Runs code linter
  ci                         Runs code linter and unit tests in CI
  sample.hello-app           Runs a sample Hello World app
  sample.login-app           Runs a sample app with Login feature
  gem.publish                Publishes the gem to https://rubygems.org (auth required)
  gem.yank                   Removes a specific version from the Rubygems
```

----

[ASCII art generator](http://patorjk.com/software/taag/#p=display&f=Graffiti&t=Type%20Something%20)
