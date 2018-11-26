## What does SonarQubeScanner do?
It measures and analyzes the code quality of a project. It shows the amount of bugs, vulnerabilities, redundancies etc present in the code. It receives files as an input and then calculates a set of metrics, stores them in a database and shows them on a dashboard. This recursive implementation helps in analysis of code quality and how code improves over time.



 #### Setting up sonar scanner/runner with docker
 
 ##### Installing docker:
Refer to the following link to install Docker. (This step can be skipped if docker is already setup in the machine.)
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
    
    #Encoding of the source code. Default is default system encoding
    #sonar.sourceEncoding=UTF-8
    sonar.exclusions=vendor/**, var/**, web/**
    ~~~
    
 * Pull the docker image from the docker-hub
    ~~~
    docker pull sobhanthakur/sonarqubescanner
    ~~~
    
 * Now run the following command from the terminal to create the container
    ~~~
    docker run -d -v /var/www/path_to_your_project_directory:/var/www/path_inside_Container -v /opt/sonarqube/data:/opt/sonarqube/data -v /opt/sonarqube/extensions:/opt/sonarqube/extensions -v /opt/sonarqube/logs:/opt/sonarqube/logs --name MFS_SonarQubeContainer -p 9005:9000 sobhanthakur/sonarqubescanner
    ~~~
    
    * "--name MFS_SonarQubeContainer" : Gives a container name.
    * "sobhanthakur/sonarqubescanner" : Name of the image
    * "-v  /var/www/path_to_your_project_directory:/var/www/path_inside_Container" :  We set up a volume that links the /var/www/path_inside_Container directory from inside the container to the /var/www/html/path_to_your_project_directory directory on the host machine. 
    
        e.g: Suppose the root directory of the project is /var/www/Project and it is mapped with the path /var/www/SonarTest which will be created inside the container, then a link is created between both the paths. So that any changes made within the project directory of the local machine will be reflected directly inside the container.
    
        Docker uses a ":" to split the host's path from the container path, and the host path always comes first.

      The paths can be customized and can be given as per the requirement.
      
     * "-v /opt/sonarqube/data:/opt/sonarqube/data" : Creates a volume for sonarqube data which contains the analysis details. This volume helps to store these details in the host machine for persistency.
     * "-v /opt/sonarqube/extensions:/opt/sonarqube/extensions" : Creates a volume for sonarqube extensions that contains downloads and plugins and store these plugins persistently in the host machine.
     * "-v /opt/sonarqube/logs:/opt/sonarqube/logs" : Creates a volume that contains logs for app, web, ComputeEngineServer and SearchServer, and stores in the host machine.
    * "-d" : Allows the container to run in the background.
    * "-p 9005:9000" : Set up port forward

       The default http port of SonarQube is 9000. This port is mapped with port 9005 of the host machine.
    
 * Hit the following url from the web browser to open SonarQube dashboard. (It may take a couple of minutes to load due to some background processes)
    ~~~
    http://localhost:9005
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
    cd /var/www/sonartest_Container
    ~~~
 
 * Run "sonar-scanner" from the terminal. This will start analyzing the project.

    As soon as the analyzation is complete, the project will appear in the dashboard.
    
 * To come out of the container, there are two commands:
    * Type "ctrl+p" then "ctrl+q".
    * Type "exit".
 
   But it is recommended to use the first command.
    