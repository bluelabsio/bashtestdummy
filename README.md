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
