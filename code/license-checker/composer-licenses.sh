# install the composer dependency
composer require dominikb/composer-license-checker

# list the summary of licenses used
./vendor/bin/composer-license-checker report > "composer_license_summary.txt"

# generate a overview of licenses
# as there's no real option for this, run a check that lists everything and remove the Error-messages
./vendor/bin/composer-license-checker check --allowlist NAMEOFNOLICENSE >  "composer_license_detailed.txt"
sed -i '/\[ERROR\]/d' composer_license_detailed.txt

# format the first operand correctly to be used in the command
OPTIONS=""
IFS=';' read -ra ADDR <<< "$1"
for i in "${ADDR[@]}"; do
  OPTIONS="$OPTIONS --allowlist $i"
done


fails=0
# Generate Output.xml
echo '<?xml version="1.0" encoding="UTF-8"?><testsuites><testsuite id="COMPOSER-CUSTOM-LICENSE-CHECKER">' > composer_licenses.xml
echo '<testcase name="Composer check allowed Licenses">' >> composer_licenses.xml	

# execute test and capture output stream in variable
OUTPUT=$(./vendor/bin/composer-license-checker check $OPTIONS)

if [ $? != 0 ];
then
    let "fails++"
    echo '<failure type="FAILURE">' >> composer_licenses.xml
    echo $OUTPUT >> composer_licenses.xml
    echo '</failure>' >> composer_licenses.xml
else
    echo '<passed type="PASSED"></passed>' >> composer_licenses.xml
fi

echo '</testcase>' >> composer_licenses.xml
echo '</testsuite></testsuites>' >> composer_licenses.xml

# 0 if all succeeded, larger 0 otherwise
exit $fails