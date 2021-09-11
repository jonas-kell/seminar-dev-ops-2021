# install the npm dependency
npm install
npm install -g license-checker
npm install -g yui-lint

# list the summary of licenses used
license-checker --summary --out "npm_license_summary.txt"
# generate a overview of licenses
license-checker --json --out "npm_license_detailed.json"


fails=0
# Generate Output.xml
echo '<?xml version="1.0" encoding="UTF-8"?><testsuites><testsuite id="NPM-CUSTOM-LICENSE-CHECKER">' > npm_licenses.xml
echo '<testcase name="NPM check allowed Licenses">' >> npm_licenses.xml	

# execute test and capture error stream in variable
ERROR=$(license-checker --onlyAllow "$1" 2>&1 >/dev/null)

if [ $? != 0 ];
then
    let "fails++"
    echo '<failure type="FAILURE">' >> npm_licenses.xml
    echo $ERROR >> npm_licenses.xml
    echo '</failure>' >> npm_licenses.xml
else
    echo '<passed type="PASSED"></passed>' >> npm_licenses.xml
fi

echo '</testcase>' >> npm_licenses.xml
echo '</testsuite></testsuites>' >> npm_licenses.xml

# 0 if all succeeded, larger 0 otherwise
exit $fails