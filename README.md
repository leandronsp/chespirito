# chespirito

![rubygems](https://badgen.net/rubygems/n/chespirito)
![rubygems](https://badgen.net/rubygems/v/chespirito/latest)
![rubygems](https://badgen.net/rubygems/dt/chespirito)

![Build](https://github.com/leandronsp/chespirito/actions/workflows/build.yml/badge.svg)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-community-brightgreen.svg)](https://rubystyle.guide)
```
       ( )                         _        _ ( )_
   ___ | |__     __    ___  _ _   (_) _ __ (_)| ,_)   _
 /'___)|  _ `\ /'__`\/',__)( '_`\ | |( '__)| || |   /'_`\
( (___ | | | |(  ___/\__, \| (_) )| || |   | || |_ ( (_) )
`\____)(_) (_)`\____)(____/| ,__/'(_)(_)   (_)`\__)`\___/'
                           | |
                           (_)
```

[chespirito](https://rubygems.org/gems/chespirito) is a dead simple, yet Rack-compatible, web framework written in Ruby.

## Requirements

Ruby

## Installation
```bash
$ gem install chespirito
```

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

## Boostrapping an application using Chespirito and Adelnor

1. Install the gems:

```bash
$ gem install chespirito adelnor
```

2. Register the Chespirito app and routes:

```ruby
class MyApp
  def self.application
    Chespirito::App.configure do |app|
      app.register_route('GET',  '/', [HelloController, :index])
      app.register_route('POST', '/', [HelloController, :create])
    end
  end
end
```

3. Create the Controller and action:

```ruby
class HelloController < Chespirito::Controller
  def index
    response.status = 200

    response.headers['Content-Type'] = 'text/html'

    response.body = '<h1>Hello, world!</h1>'
  end

  def create
    response.status = 204
  end
end
```

4. Run the app using Adelnor (or you can choose another web server like Puma, Unicorn, etc):

```ruby
Adelnor::Server.run MyApp.application, 3000
```

5. Open `localhost:3000` and cheers!

----

[ASCII art generator](http://www.network-science.de/ascii/)
