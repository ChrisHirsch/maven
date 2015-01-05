# Maven build environment
=====

A simple concise Maven build environment that lets you build and package on Linux/OSX etc. 

Currently this project uses Maven 3.1.1. If a later version is needed, simply updated the Dockerfile and rebuild.

# Maven build in Docker

This project is a Docker container for [Maven](http://maven.apache.org/). It's a simple environment that contains a simple script to allow a user to build maven projects on all the common platforms where Docker or Boot2Docker is used.

## Getting/Building the container

	$ git clone https://github.com/zwi/maven.git
	$ cd maven
	$ make
           OR 
        $ docker build -t maven .

## Using the container

The idea is that as a developer, you just want to build your locally checked out project with a well known Mavin environment. This is easily accomplished with the command:

	$ ./maven_build.sh ~/src/myproject "/usr/local/maven/bin/mvn -DskipTests -P buildrpm -U package -f /myproject/UI/pom.xml"

This command will expose your local source ~/src/myproject to the Docker container as /myproject. Then Maven will build the project based on the supplied pom file. Once the build is done, the container will shut down and everything that had to be downloaded to build the container will be erased. The resulting artifacts from the build will be on the container host in ~/src/myproject.

#### Having problems with building and/or want to save bandwidth?

One of the advantages with Maven is that it will download everything it needs (as described in the pom.xml file) to build the project. One of the advantages of Docker is that the running container will go away when the process is complete. This is not good for the person who is trying to get a build to work and it's failing. Each time the build is started, everything must be downloaded again. The solution to this is to just run the container as bash and from within the container, run your maven command. Once you have a working build, exit and then try a clean build again.
	$ ./maven_build.sh ~/src/myproject "/bin/bash" 
        $ /usr/local/maven/bin/mvn -DskipTests -P buildrpm -U package -f /myproject/UI/pom.xml"

## License

APL
