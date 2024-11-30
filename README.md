# Python-jenkins-ci-cd-pipeline
# Jenkins Pipeline: Branch-Specific Build and Deploy

This project contains a Jenkins pipeline configuration that automates the CI/CD process. The pipeline is configured to dynamically pull code from either the `develop` or `main` branch based on where the latest commit occurs.

---

## **Pipeline Overview**

- Automatically triggers on new commits to `develop` or `main` branches.
- Pulls the latest code from the respective branch.
- Builds and tests the application.
- Pushes a Docker image to the container registry.
- Deploys the application

---

## **Pipeline Flow**

1. **Trigger**
   - Configured to trigger automatically using a GitHub webhook.
   - Listens for commits on `develop` and `main` branches.
   
2. **Setup Virtual Environment**
   - Virtual environment creation.
   - Install required packages in the virtual environment using requirements.txt.
   
3. **Code Quality**
   - Executes the shell script of code quality using quality.sh .
   - Used pylint to check code quality.
   - Reports code quality results as pylint_report.txt to jenkins workspace.
   
4. **Security Check**
   - Executes the shell script of security check using security.sh .
   - Used safety check to check security.
   - Reports security check results to jenkins.
   
5. **Testing**
   - Executes the shell script of testing using testing.sh .
   - Used coverage for testing.
   - Reports testing results as coverage-report to jenkins workspace.
   - Fails the build if coverage is below a certain threshold and a mail will be send to stakeholder.

6. **Build**
   - Builds the application using Dockerfile using build.sh .
   - Creates a Docker image and tags it accordingly with the build version and environment.

8. **Push to Registry**
   - Pushes the Docker image to a private container registry using push.sh .

9. **Deploy**
   - Deploys the application using deploy.sh .
   
9. **Post-build**
   - Notifications via email.

---

## **Jenkinsfile**

The pipeline is defined in the `Jenkinsfile` and follows a declarative syntax. Key features include:
- Configured to trigger automatically using a GitHub webhook.
- Source code download,Setup Virtual Environment,Code Quality,Security Check,Testing,Build,Push to Registry,Deploy
- Post-build notifications via email or Slack.

---

## **Documentation path**

This path has all the results generated by the pipeline when it runs and also the different screenshots of respective parts.

documentation/
├── pipeline-artifacts
│   └── coverage-report
└── pipeline-screenshots

3 directories

---

## **Repo Directory structure**

```
python-jenkins-ci-pipeline/
├── Jenkinsfile
├── README.md
├── documentation
│   ├── pipeline-artifacts
│   │   ├── console-output.txt
│   │   ├── coverage-report
│   │   │   ├── class_index.html
│   │   │   ├── coverage_html_cb_6fb7b396.js
│   │   │   ├── favicon_32_cb_58284776.png
│   │   │   ├── function_index.html
│   │   │   ├── index.html
│   │   │   ├── keybd_closed_cb_ce680311.png
│   │   │   ├── status.json
│   │   │   ├── style_cb_8e611ae1.css
│   │   │   ├── z_6dbb0dfab453e899_test_app_py.html
│   │   │   ├── z_bdc796e4083bf542___init___py.html
│   │   │   └── z_bdc796e4083bf542_app_py.html
│   │   └── pylint_report.txt
│   └── pipeline-screenshots
│       ├── build-status.PNG
│       ├── build-timings.PNG
│       ├── build.PNG
│       ├── code-quality.PNG
│       ├── deploy.PNG
│       ├── git-build-data.PNG
│       ├── jenkins-dashboard.PNG
│       ├── pipeline-console.PNG
│       ├── push-registry.PNG
│       ├── python-container-running.PNG
│       ├── security-check.PNG
│       ├── stages.PNG
│       ├── success-email.jpg
│       ├── testing.PNG
│       ├── virtual-env.PNG
│       └── webhook-trigger-successful.PNG
├── pipeline
│   ├── build
│   │   ├── Dockerfile
│   │   └── build.sh
│   ├── deploy
│   │   └── deploy.sh
│   ├── push
│   │   └── push.sh
│   ├── quality
│   │   └── quality.sh
│   ├── security
│   │   └── security.sh
│   └── test
│       └── test.sh
└── python-app
    ├── requirements.txt
    ├── src
    │   ├── __init__.py
    │   └── app.py
    └── test
        └── test_app.py

14 directories, 42 files

```

---

## **OS used**

VERSION="22.04.5 LTS (Jammy Jellyfish)"

---

## **Jenkins Installation**

$ sudo apt install openjdk-11-jre-headless
$ java --version
$ curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \ /usr/share/keyrings/jenkins-keyring.asc > /dev/null
$ echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null
$ sudo apt update
$ sudo apt install jenkins -y
$ sudo systemctl status jenkins

Jenkins UI 
http://<host-ip>:8080
Configure jenkins to install all pre-suggested plugins.	
Workspace -/var/lib/jenkins/workspace/python-jenkins-ci-cd-pipeline-master 

---

## **Docker Installation**

$ sudo install -m 0755 -d /etc/apt/keyrings
$ sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor --yes -o /etc/apt/keyrings/docker.gpg
$ sudo chmod a+r /etc/apt/keyrings/docker.gpg
$ echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list
$ sudo apt-get update -y
$ sudo apt-get install -y docker-ce=5:24.0.9-1~ubuntu.22.04~jammy docker-ce-cli=5:24.0.9-1~ubuntu.22.04~jammy containerd.io=1.6.28-2

$ sudo systemctl enable docker
$ sudo usermod -a -G docker ubuntu
$ sudo systemctl restart docker
$ sudo systemctl status docker
$ docker --version

---

## **Docker registry Installation**

$ docker run -d --restart=always -v /opt/python-app/docker-registry:/var/lib/registry -p 5000:5000 --privileged --name docker-registry registry:2

$ vi /etc/hosts 
<host-ip>  docker-registry

$ sudo vi /etc/docker/daemon.json
{ 
  "insecure-registries" : [
    "docker-registry:5000",
	"<host-ip>:5000"
  ]
}

$ sudo systemctl restart docker

---

## **Pipeline building from UI**

Name the pipeline accordingly as master or develop branch - python-jenkins-ci-cd-pipeline-master

Since its a public Github project, no credentials are required - https://github.com/Param171998/python-jenkins-ci-pipeline.git/

Tick mark the build trigger block GitHub hook trigger for GITScm polling.

In the pipeline definition, select pipeline script from SCM with repo url as https://github.com/Param171998/python-jenkins-ci-pipeline.git and script path as Jenkinsfile.
