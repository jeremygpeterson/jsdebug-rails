# Javascript Debug Rails

Extends the Assets Pipeline for Javascript logging in the development environment, but excludes them when in the production environment. This was created to allow logging for debugging and keep the production version cleaner.

Intended for Rails 3.1 Release Candidate for now.
## Example

**foobar.js**

    var c = { foo: 1, bar: 2, baz: 'three' };
    debug.log(c);

**Results in Firebug Console**

    [foobar::2] Object { foo=1, bar=2, baz="three"}

The log statement has the file name and line number for each command:

* debug.debug
* debug.log
* debug.info
* debug.warn
* debug.error

## Installing
In your GemFile:

     gem 'jsdebug-rails'

Run the Generator script to Install the Files:

     rails generate jsdebug:install

## Usage
Add debug statements in your javascript files, then turn on Firebug console to see your logs.

## Roadmap

* Get Feedback
* Provide validation tests for Production.  (Sanity check)

## Warnings

This is an alpha release of this gem and was tested on Rails 3.1.rc4, whereas the primary functionality changes Rails Javascript in the Production environment. Code written in development, may not work correctly in Production. You've been warned! That much said, keeping debug.log statements on one line will not have any problems.

## Testing Production
To test, change development.rb

     config.log_level = :info

## History
* 0.1.0 Initial Release
* 0.2.0 Updating for Rails 3.1
* 0.3.0 Updating for Rails 3.2