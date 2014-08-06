Starbound Server Manager
========================

Installation
------------

### From source

First see *[Hacking -> What you need](#what-you-need)*

and *[Hacking -> Getting the source](#getting-the-source)*

then install dependencies, build the gem and install it to your system

    $ bundle install --system
    $ rake build
    $ gem install --local pkg/starbound-srv-mgr-<version>.gem

or just *[use it from source](#using-the-source)*.




Usage
-----

Well... there is currently nothing to use ;)




Versioning
----------

- `<major>.<minor>[.<patch>][[.<a|b|rc><nr>]|.dev]`
- Version `0.x.x` are incomplete and under development
- `1.0.0` is the first stable release
- Before releasing stable versions there are alpha
  versions `<version>.a1` etc, and beta versions `<version>.b1` etc.
- A release candidate is marked as `<version>.rc1` ect.
- `<version>.dev` is a development version. It MUST NOT be tagged
  but the version file should contain the `.dev` suffix unless the
  next commit will be released / tagged. After tagging, the `.dev`
  must be added again to the version string to indicate an unstable
  *dev-state*.
- While there is not any functionality, before the first version
  tagging the version file contains `0.0.0`




Hacking
-------

### What you need

- [git](http://git-scm.com/) *(you don't say)*
- [ruby](https://www.ruby-lang.org/) *(>=1.9)*
- [gem](https://rubygems.org/) *(comes with ruby since v1.9)*
- [bundler](http://bundler.io/) *(`$ gem install bundler`)*



### Getting the source

Clone the repository to your computer and install dependencies

    $ git clone https://github.com/brichter89/starbound-srv-mgr.git
    $ cd starbound-srv-mgr
    $ bundle install --path vendor/bundle



### Using the source

You can now use bundler to execute the binary from source

    $ bundle exec <whatever-binary-there-will-be-in-the-future>

or include to your own project (if you really have a use case)

````ruby
ssm_lib = '/path/to/this/project/lib/'
$LOAD_PATH.unshift(ssm_lib) unless $LOAD_PATH.include?(ssm_lib)
require 'starbound-srv-mgr'
````



### Run tests

    $ bundle exec rspec



### Contributing

Feel free to fork starbound-srv-mgr and add cool new features! See the list of issues for some inspiration.

1. [Fork it](https://github.com/brichter89/starbound-srv-mgr/fork)
2. Create your feature branch
        $ git checkout -b feature/my-new-cool-feature
3. Commit your changes
        $ git add <files>
        $ git commit -m 'Added some cool new feature'
4. Push to the branch
        $ git push origin feature/my-new-cool-feature
5. [Create a new Pull Request](https://github.com/feibeck/fussi/compare/) against the develop branch
