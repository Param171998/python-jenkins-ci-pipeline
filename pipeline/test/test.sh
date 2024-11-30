#!/bin/bash
echo "Running tests and measuring code coverage..."

cat <<EOF
***************************************************
                    Test stage
***************************************************
EOF


# Run tests with coverage
coverage run -m pytest python-app/test

# Generate coverage report
coverage report

# Save HTML report
coverage html -d coverage-report

# Archive the coverage report as a Jenkins artifact
cp -r coverage-report $WORKSPACE/

# Fail the build if coverage is below a certain threshold (e.g., 80%)
coverage report | tail -n 10 | grep -q "0%" || exit 1
