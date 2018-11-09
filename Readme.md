## What does SonarQubeScanner do?
It measures and analyzes the code quality of a project. It shows the amount of bugs, vulnerabilities, redundancies etc present in the code. It receives files as an input and then calculates a set of metrics, stores them in a database and shows them on a dashboard. This recursive implementation helps in analysis of code quality and how code improves over time.



 #### Setting up sonar scanner/runner with docker
 
 ##### Installing docker:
Refer to the following link to install Docker.
~~~
https://docs.docker.com/install/linux/docker-ce/ubuntu/#set-up-the-repository
~~~

##### Commands to create instance of sonar scanner/runner:

 * Before creating the container, make sure that the project must contain a file called sonar-project.properties (inside the project's root directory).
 
 	It should look like as follows:
    ~~~
    #must be unique in a given SonarQube instance
    sonar.projectKey=any_key_for_the_project
    #this is the name and version displayed in the SonarQube UI. Was mandatory prior to SonarQube 6.1.
    sonar.projectName=Name_of_your_project
    sonar.projectVersion=1.0

    #Path is relative to the sonar-project.properties file. Replace "\" by "/" on Windows.
    #This property is optional if sonar.modules is set. 
    sonar.sources=.
    #Language (use only when it is a single language)
	sonar.language=php

    #Encoding of the source code. Default is default system encoding
    #sonar.sourceEncoding=UTF-8
    sonar.exclusions=vendor/**, var/**, web/**
    ~~~
    
 * Pull the docker image from the docker-hub
 	~~~
 	docker pull sobhanthakur/sonarqubescanner
 	~~~
    
 * Now run the following command from the terminal to create container
 	~~~
    docker run -d -v /localhostprojectPath:/var/www/ContainerProjectPath --name MFS_SonarQubeContainer -p 9001:9000 sobhanthakur/sonarqubescanner
 	~~~
    
    * "--name MFS_SonarQubeContainer" : Gives a container name.
    * "sobhanthakur/sonarqubescanner" : Name of the image
    * "-v /localhostprojectPath:/var/www/ContainerProjectPath" :  We set up a volume that links the /ContainerProjectPath directory from inside the container to the /localhostprojectPath directory on the host machine. Docker uses a ":" to split the host's path from the container path, and the host path always comes first.

      The paths can be customized and can be given as per the requirement.
    * "-d" : Allows the container to run in the background.
    * "-p 9001:9000" : Set up port forward

       The default port of SonarQube is 9000. This port is mapped with port 9001 of the host machine.
    
 * Hit the following url from the web browser to open SonarQube dashboard. 
 	~~~
    http://localhost:9001
 	~~~
    
    Login using the following credentials:
    ~~~
    username : admin
    
    Password : admin
    ~~~
    
 * Login into Docker Container from the terminal:
	~~~ 
   docker exec -t -i MFS_SonarQubeContainer /bin/bash
	~~~
    docker exec is the command to login into a running container where MFS_SonarQubeContainer is the container name.
    
 * Go to the project path  inside the container that is given during the creation of the container.
 	~~~
    cd /ContainerProjectPath
    ~~~
 
 * Run "sonar-scanner" from the terminal. This will start analyzing the project.

	As soon as the analyzation is complete, the project will appear in the dashboard.
    
