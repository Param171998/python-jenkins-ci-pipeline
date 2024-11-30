#!/bin/bash
echo "Running security vulnerability scan..."

cat <<EOF
***************************************************
                    Security stage
***************************************************
EOF


# Check for known security vulnerabilities in requirements.txt
safety check --file=python-app/requirements.txt --full-report

# Fail the build if critical vulnerabilities are found
if [ $? -ne 0 ]; then
  echo "Security vulnerabilities detected!"
  exit 1
fi
