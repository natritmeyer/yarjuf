# yarjuf

_Yet Another RSpec JUnit Formatter_

## Intro

I've never found a gem that can be relied on to generate JUnit
output from [RSpec](https://www.relishapp.com/rspec/rspec-core/docs). Previously, I'd cobbled together a [formatter](http://www.natontesting.com/2012/05/25/rspec-junit-formatter-for-jenkins/) that worked for me for a couple of years and seems to have proved
useful to others. But it was a hack and thought I'd rewrite it
and make it distributable as a gem. Thus: [yet-another-rspec-junit-formatter](https://github.com/natritmeyer/yarjuf)

## Installation

Using rubygems:

`gem install yarjuf`

Using bundler:

Add the following line to your `Gemfile`:

`gem 'yarjuf'`
 
## Usage

There are a few ways to use custom formatters in RSpec; what follows is
the 'best' way...

### Loading yarjuf

Before you can use yarjuf, RSpec needs to know about it. The best way to
do that is to use the functionality that RSpec provides to load
libraries. 

#### `.rspec` file

When RSpec executes, it looks for a file in the current working
directory (project root) called `.rspec` that contains rspec
configuration. It is a good idea to add the following to it:

`--require spec_helper`

Doing so will make sure that the `spec/spec_helper.rb` file will get
required when RSpec starts.

#### `spec/spec_helper.rb` file

Add the following to your `spec/spec_helper.rb`:

```ruby
require 'yarjuf'
```

That will make sure that yarjuf is loaded when RSpec starts and can be
used as a formatter

### Generating JUnit output using yarjuf

RSpec tests can be executed in a number of ways. Here's how to get JUnit
output for each of those different ways.

#### Running rspec tests from the command line

#### Running rspec tests using Rake

#### Running rspec tests using Jenkins/Hudson

