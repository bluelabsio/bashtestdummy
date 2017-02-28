# bashtestdummy

This is an integration test framework for shell scripts.

## To use

See the example/ directory for a working use of this to test two
existing shell scripts - 'sayhi' and 'launchthemissiles'.  You can run
the 'test.sh' script to run the tests.

### Dockerfile - adding real dependencies

One of these shell scripts (sayhi) needs a dependency to run--the
'cowsay' utility.  The Dockerfile extends the bashtestdummy image and
adds the dependency that the script needs.

### dummies - mocking dependencies

The other shell script (launchmissiles) also needs a dependency (the
AWS CLI).  In this case, we don't want to actually launch the missiles
while running the test, so we want to mock it out.  See the
'dummies/aws' shell script for the mock.

### Tests

The tests themselves tend to be pretty simple - this framework is
really best at rough integration tests instead of anything fancy (at a
certain level of fancy, you probably want to be using something like
Python, right?).

For example tests, see the `example/tests/individual` directory.  They
ensure that they return with an exit value of 0 if things suceeed, or
0 if they fail.

These tests must end with the '.sh' extension.

### I/O expectations

To create expectations on the output of your script, create '.stdout'
and '.stderr' files with the same name as your test.

### Coverage and ratcheting

This framework will log coverage to the
`metrics/coverage_high_water_mark` file, and will fail the build if
the coverage slips below the number in this file.

### Jenkinsfile

The Jenkinsfile in the `example` directory will tell Jenkins to use
bashtestdummy to test your scripts as part of the CI build.

## Other work

Some related work on the internet:

* [assert.sh](https://github.com/lehmannro/assert.sh)
  Allows asserts on exit codes and stdout, allows mix of failure and
  success, and creates a (non-standard?) report at the end.
* [bashunit](https://github.com/djui/bashunit)
  Ditto.
* [testdummy](https://github.com/nextrevision/testdummy)
  Ditto, plus recognizes test_ functions and runs them (and some
  hierarchical function names that look like BDD style stuff).
* [a different bashunit--this time, with ASCII art!](https://github.com/athena-oss/bashunit)
  Allows you to mock functions (but not executables?).  Allows asserts on
  exit codes and stdout, allows mix of failure and success, and creates a
  (non-standard?) report at the end.  Some crude function-level code coverage.
* [bash_unit, with an underscore](https://github.com/pgrange/bash_unit)
  Is good at showing line number of failure.  Standard assert
  functions.  Allows mix of failure and success.  Supports
  [TAP](http://testanything.org/) formatting, setup, teardown, output and
  return code checking, ...  <- probably the one to build on in the
  future!
* [shunit](http://shunit.sourceforge.net/)
   Doesn't look like it's been updated in ages...
* [Another shunit](https://github.com/akesterson/shunit)
  Seems to be related to support some kind of XML output.
* [shunit2](https://github.com/kward/shunit2)
  Seems a little on the unmaintained side.
