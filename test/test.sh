#!/bin/bash
# This shell script will only work if you have the main application running.
# Go run the main application and execute this in bash with ./test.sh
pushd "$( dirname "${BASH_SOURCE[0]}" )"
curl -s -X POST -d @sample.html -o sample.pdf -H "Expect:" -H "Content-Type: text/html" http://localhost:3000/pdf?filename=referral_sample.pdf
popd

