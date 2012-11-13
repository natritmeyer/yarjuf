# yarjuf

_Yet Another RSpec JUnit Formatter_

## TL;DR

1. `gem install yarjuf`
1. Add the following to your `spec/spec_helper.rb`:
```ruby
require 'yarjuf'
```
1. Execute your tests:
`rspec -f JUnit -o results.xml`

## Intro

I've never found a gem I can rely on that I can use to generate JUnit
output from [RSpec](https://www.relishapp.com/rspec/rspec-core/docs).
Previously, I'd cobbled together a [formatter](http://www.natontesting.com/2012/05/25/rspec-junit-formatter-for-jenkins/) that worked for me for a couple of years and seems to have proved useful
to others. But it was a hack and thought I'd rewrite it and make it
distributable as a gem. Thus: [yet-another-rspec-junit-formatter](https://github.com/natritmeyer/yarjuf)

## Installation

Using rubygems:

`gem install yarjuf`

Using bundler:

Add the following line to your `Gemfile`:

`gem 'yarjuf'`
 
## Usage

There are a few ways to use custom formatters in RSpec; what follows is
the 'best' way...

