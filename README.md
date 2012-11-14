# yarjuf

_Yet Another RSpec JUnit Formatter_

## Intro

I've never found a gem that can be relied on to generate JUnit
output from [RSpec](https://www.relishapp.com/rspec/rspec-core/docs). Previously, I'd cobbled together a [formatter](http://www.natontesting.com/2012/05/25/rspec-junit-formatter-for-jenkins/) that worked for me for a couple of years and seems to have proved
useful to others. But it was a hack and thought I'd rewrite it, make it
conform to the JUnit format spec a bit better, and make it
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

### Loading yarjuf

Before you can use yarjuf, RSpec needs to know about it. The best way to
do that is to use the functionality that RSpec provides to load
libraries. 

#### Modifying the `.rspec` file

When RSpec executes, it looks for a file in the current working
directory (project root) called `.rspec` that contains rspec
configuration. It is a good idea to add the following to it:

`--require spec_helper`

Doing so will make sure that the `spec/spec_helper.rb` file will get
required when RSpec starts.

#### Modifying the `spec/spec_helper.rb` file

Add the following to your `spec/spec_helper.rb`:

```ruby
require 'yarjuf'
```

That will make sure that yarjuf is loaded when RSpec starts and can be
used as a formatter.

### Generating JUnit output using yarjuf

RSpec tests can be executed in a number of ways. Here's how to get JUnit
output for each of those different ways - assuming you've loaded yarjuf
as specified above).

#### Running rspec tests from the command line

In this scenario, you just want to run `rspec` from the command line and
get JUnit output. To do that you'll need to use the `-f JUnit` option
to generate JUnit output and to write it to a file you can use the
`-o results.xml` option. So to run all your tests and get JUnit output
written to a file, execute the following:

`rspec -f JUnit -o results.xml`

#### Running rspec tests using Rake

In this scenario, you want to run your rspec tests using rake. To do
that you'll need to add an option to your rake task:

```ruby
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = %w[-f JUnit -o results.xml]
end
```

That will write out JUnit formatted results to a file called
`results.xml`. 

#### Jenkins integration

To use yarjuf with Jenkins(/Hudson), simply tick the 'Publish JUnit test
result report' option in the Jenkins task configuration page and in the
'Test report XMLs' field specify the file name that you expect the JUnit
formatted results to be written to, ie: the file path and name specified
in the `-o` option above.

## Acknowledgements

* Thanks to [@adeoke](https://github.com/adeoke) for suggesting a slightly less sucky gem name than the
one I originally came up with
* Thanks to [@dchamb84](https://github.com/dchamb84) for helping me debug the original hack
* Thanks to [@nathanbain](https://github.com/nathanbain) for spurring me on to write the original hack

