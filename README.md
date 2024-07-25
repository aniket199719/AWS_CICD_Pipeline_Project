# Steps for AWS CICD Pipeline Project 

## On VS-Code/IDE and GitHub

- Open Anaconda CMD Prompt

- Change path to project folder path
    Ex=> cd H:\Projects\ML_Project -> H:

- Enter "code ." to Open the VS code editor in the specified path

- Create a virtual environment using cmd "conda create -p venv python==3.8 -y" 

- Activate the environment using "conda activate venv/" notice the (base) goes off

- Intialize git repo "git init"

- Create "README.md" file
    Add README file to git repo "git add README.md"

- Commit changes "git commit -m "first commit"

- Use "git status" to check the list the files from the repo

- Do branching using "git branch -M main" 

- Add the origin "git remote add origin https://github.com/aniket199719/AWS_CI-CD_Project.git"

- Check the sync using "git remote -v"

- To push data into the git repo "git push -u origin main" 
    NOTE: If doing a push for the first time you will have to set "git global" using the below cmds
        $ git config --global user.name "John Doe"
        $ git config --global user.email johndoe@example.com

- Create ".gitignore" file by choosing Python for the same file

- "__init__.py" is a file which can be used as a package and can be imported

- Create "setup.py" file i.e., is responsible in creating the ML application as a package and deploying it

- Components are the modules which we are going to use in creating the project

- In "exception.py" import sys package (The sys module in Python provides various functions and variables that are used to manipulate different parts of the Python runtime environment. It allows operating on the interpreter as it provides access to the variables and functions that interact strongly with the interpreter.)

- Go through once documentation of logger and exception handling

## GitHub CMD'S Summary:
	git init
	git add README.md
	git commit -m "first commit"
	git branch -M main
	git remote add origin https://github.com/aniket199719/ML-Project.git
	git remote -v
	git push -u origin main
	git add .
	git status
	git commit -m "desired commit name"
	git push -u origin main


## DOCKER 

- Containers are the combination of layers of images w.r.t dependencies, where each layer of the image can be Python, MongoDB, MySQL, anaconda, Linux, etc,.

- When all the layers of images are combined, they are called a docker image (or package).

- When we run the docker image it creates a container with all the dependencies installed referred to as the environment.

- Docker image size is usually smaller than the VM image size.

- Dockers containers start and run much faster as they do not have their own OS kernel, whereas VMs is slower since they have their OS kernel

- Compatibility issues in the VM image do not exist, but they exist for the docker image.

- When "host = 0.0.0.0" means we can access docker_image using localhost ip_address or using local ip_address.

- Format of docker file (should be created in VS code-named "Dockerfile"):
	```
	FROM python:3.8-alpine
	COPY . .
	WORKDIR /app
	ENV FLASK_APP = appy.py
	ENV FLASK_RUN_HOST = 0.0.0.0
	RUN pip install -r requirements.txt
	EXPOSE 5000
	CMD ["flask", "run"]
	```
- Docker CMD's to create, view, push, pull, remove, rename, and run the docker_image:

	- For Login: "docker login" (type username press enter and then type password)

	- View the images in docker: "docker images"

	- Building the docker_image: "docker build -t username/docker_image_name ."

	- Removing the docker image/app: "docker image rm -f docker_image_name:tagname" 

	- Renaming the existing docker image: "docker tag username/docker_image_name username/docker_image_new_name" 

	- Push the docker image from the local system to the docker hub: "docker push username/docker_image_name:tagname" 

	- Pull the docker image from the docker hub to the local system: "docker pull username/docker_image_name:tagname" 

	- Run the docker image on the local system: "docker run -p 5000:5000 username/docker_image_name:tagname" (5000 represents a port number)

	- Run the docker image on the local system in detach mode: "docker run -d -p 5000:5000 username/docker_image_name:tagname" (5000 represents a port number)

- Docker Compose: This is a tool for defining and running multi-container docker applications, in order to make this run and interact with each other we will need two files i.e., "docker-compose.yml" and "dockerfile". 
 
 	- Format for "dockerfile":
		```
  		FROM python:3.8-alpine
		COPY . .
		WORKDIR /app
		ENV FLASK_APP = appy.py
		ENV FLASK_RUN_HOST = 0.0.0.0
		RUN pip install -r requirements.txt
		EXPOSE 5000
		CMD ["flask", "run"]
  		```

	- Format for "docker-compose.yml" containing 2 images (follow the indentation):
		```
		version: "3.0"
		services:
			web:
				image: web-app   #name of image
				build: .
				ports:
					- "5000:5000"
				redis:
					image:redis  #name of image
		```


## Create GitHub Actions workflow configuration that defines a CI/CD pipeline  

- The workflow is triggered by pushes to the main branch.

- The integration job runs linting and unit tests.

- The build-and-push-ecr-image job builds and pushes a Docker image to ECR.

- The Continuous-Deployment job pulls the Docker image from ECR and runs it, serving users on a self-hosted runner, and cleans up old images and containers.



## AWS Deployment 

- AWS Elastic Container Registry (ECR): It is a fully-managed docker container used to store, manage, and deploy private docker images. 

- Create an IAM user and attach two policies "AmazonEC2ContainerRegistryFullAccess" and "AmazonEC2FullAccess"

- Under IAM select the user created above followed by the creation of the Access key for Command Line Interface (CLI) and download the csv file

- Search for ECR service, Create a new repo keeping it private, give the name for the URL, copy the URL, and save it

- Search EC2 Instance service, launch instance, give the name for instance, select ubuntu, and select the tier as per the requirement, allow HTTP and HTTPS traffic now launch the instance (DELETE IT WHEN DONE Charges might be incurred)

- For the above-created instance go to Security -> Select the security group -> Click on edit inbound rules -> Add rule as "Custom TCP" and Port range = the port mentioned in the "app.py" file

- Select the instance ID for the above-created instance and click on connect 

- Execute the following steps in Command Prompt on AWS:
```
    sudo apt-get update -y
    sudo apt-get upgrade -y
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker ubuntu
    newgrp docker
    docker (to check whether docker is running)
```
	

## On GitHub

- Go to settings -> Actions -> Runners -> create self-hosted runner -> Linux -> execute all cmd's under Download and Configure on EC2 instance in AWS -> Give the name for runner as "self-hosted" -> Enter "./run.sh" to run the runner

- Check the status of the runner by, Going to settings -> Actions -> Runners -> Under status there should be a green dot saying idle

- Go to settings -> Security -> Secrets and variable -> Actions -> click on New repository secret -> name it as "AWS_ACCESS_KEY_ID" -> refer the earlier downloaded CSV file from AWS for KEY_ID 
	
- click on New repository secret -> name it as "AWS_SECRET_ACCESS_KEY" -> refer the earlier downloaded CSV file from AWS for SECRET_KEY

- click on New repository secret -> name it as "AWS_REGION" and give the current region from AWS (ex. us-east-1) 

- click on New repository secret -> name it as "AWS_ECR_LOGIN_URI", where the url saved previously Value="211125765812.dkr.ecr.us-east-2.amazonaws.com" (ex: "211125765812.dkr.ecr.us-east-2.amazonaws.com/studentperformance")

- click on New repository secret -> name it as "ECR_REPO_NAME" = "studentperformance" and give the same name found at the end of the previously saved URL (ex: "211125765812.dkr.ecr.us-east-2.amazonaws.com/studentperformance")	
