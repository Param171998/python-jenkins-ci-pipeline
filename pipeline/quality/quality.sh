#!/bin/bash
echo "Running code quality checks with Pylint..."

cat <<EOF
***************************************************
                    Quality stage
***************************************************
EOF


# Run Pylint on the Python source code
pylint python-app/src --max-line-length=120 --disable=C0114,C0115,C0116 > pylint_report.txt

# Display Pylint report
cat pylint_report.txt

# Fail the build if there are Pylint errors or warnings (threshold can be adjusted)
if grep -q "rated at 10.00/10" pylint_report.txt; then
  echo "Pylint quality gate passed."
else
  echo "Pylint quality gate failed!"
  exit 1
fi
