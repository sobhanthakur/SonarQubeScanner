## What does SonarQubeScanner do?
SonarQubeScanner uses SonarQube image with sonar-scanner embedded into it. It measures and analyzes the code quality of a project. It shows the amount of bugs, vulnerabilities, redundancies etc present in the code. 

#### Sharing Data Between the Host and the Docker Container:

~~~
docker run -d -v ~/projectPath:/var/Project --name sonarqubescanner-container -p 9000:9000 -p 9092:9092 sobhanthakur/sonarqubescanner
~~~


* "--name sonarqubescanner-container" : Gives a container name.
* "sobhanthakur/sonarqubescanner" : Names of the image
* "-v ~/projectPath:/var/Project" :  We set up a volume that links the /var/Project directory from inside the container to the ~/projectPath directory on the host machine. Docker uses a : to split the host's path from the container path, and the host path always comes first.
* "-d" : Detaches the process and runs in the background.
* "-p 9000:9000 -p 9092:9092" : Set up port forward
	