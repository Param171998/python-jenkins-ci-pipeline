# python-jenkins-ci-pipeline
Python Jenkins CI-CD

#Currently working on Develop branch
Installed jenkins, private registry

# Directory structure
python-jenkins-ci-pipeline/
├── Dockerfile
├── Jenkinsfile
├── README.md
├── pipeline
│   ├── build
│   │   └── build.sh
│   ├── deploy
│   │   └── deploy.sh
│   ├── push
│   │   └── push.sh
│   ├── quality
│   │   ├── pylint_report.txt
│   │   └── quality.sh
│   ├── security
│   │   └── security.sh
│   └── test
│       ├── coverage-report
│       │   ├── class_index.html
│       │   ├── coverage_html_cb_6fb7b396.js
│       │   ├── favicon_32_cb_58284776.png
│       │   ├── function_index.html
│       │   ├── index.html
│       │   ├── keybd_closed_cb_ce680311.png
│       │   ├── status.json
│       │   ├── style_cb_8e611ae1.css
│       │   └── z_c71bb9e81320e8dd_test_app_py.html
│       └── test.sh
└── python-app
    ├── requirements.txt
    ├── src
    │   └── app.py
    └── test
        ├── __pycache__
        │   └── test_app.cpython-310-pytest-8.3.3.pyc
        └── test_app.py

# Currently work is in process in develop branch 
# When all testing will be done then will be merged with main branch
