As a part of prerequisites, I have downloaded curl,docker,docker-compose and git on my ubuntu machine inside VMWare workstation by performing below commands : 

1.To Download curl : -

$sudo apt update ;

$sudo apt install curl

>> To check the downloaded version of curl : $curl --version 

===========

2.To Download docker : -

$sudo apt update;

$sudo apt install docker.io

>> To check the downloaded version of docker : $docker --version

===========

3.To Download docker-compose : -

$sudo apt update;

$sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose;

$sudo chmod +x /usr/local/bin/docker-compose

>> To check the downloaded version of docker-compose : docker-compose --version

===========

4.To Download git : - 

$sudo apt update;

$sudo apt install git

>> To check the downloaded version of git : $git --version


=======================================================


Performed/Executed below set of commands as part of Section 1 (Part 1) of the assignment :

Pull down the below images from images registry-

$docker pull infracloudio/csvserver:latest
$docker pull prom/prometheus:v2.22.0


Cloned the public github repo- 
$git clone https://github.com/infracloudio/csvserver.git


Moved inside the mentioned directory- 
$cd csvserver/solution


Checked the avaiable images on the system -
$docker images 


Started the container using one of the above image in detach mode- 
$docker run -d infracloudio/csvserver


However, at this point, container did not get started, while further checking on it, found below error from the logs- 

$docker logs <container_ID>
2023/11/12 12:31:28 error while reading the file "/csvserver/inputdata": open /csvserver/inputdata: no such file or directory


Then as per the next part of the assignment where the requirement was to create a shell script, have created a shell script as below which will take two user inputs as first entry and last entry and then this script will
create one file calles inputFile same will be used by the container later part - 

$cat gencsv.sh 
#!/bin/bash

read -p "Please insert the first number as first entry: " entry1
read -p "Please insert the second number as last entry: " entry2

entry1=$((entry1))
entry2=$((entry2))

while [ $entry1 -le $entry2 ]
do
	rand=$((RANDOM%1000))
	echo "$entry1, $rand" >> inputFile
	entry1=$(($entry1+1))
done

=======================================================

Given the executed permission to the script - 

$chmod +x gencsv.sh

=======================================================

Executed the script-

$./gencsv.sh
Please insert the first number as first entry: 2
Please insert the second number as last entry: 8

=======================================================

It created a file called inputFile in the same location , checked the same - 
$ls
gencsv.sh  inputFile

=======================================================

Checked the contents of the file inputFile- 
$cat inputFile
2, 368
3, 234
4, 707
5, 277
6, 25
7, 91
8, 97

=======================================================

Then executed Docker run command by creating a volume which will help to manage persistent data by linking directories or files from the host machine to the container - 

$docker run -d -v /home/rana/Desktop/csvserver/solution/inputFile:/csvserver/inputdata infracloudio/csvserver

=======================================================

Checked the port on which the application is listening by running belo docker ps command- 

$docker ps

Found that conatiner is using port 9300

However, as per the assignment, I had to the port binding between 9393 and 9300 where 9393 is the host port and 9300 is the container port where actually the application is running. 
To do that, executed below command- 

$docker run -dp 127.0.0.1:9393:9300 -v /home/rana/Desktop/csvserver/solution/inputFile:/csvserver/inputdata infracloudio/csvserver


=======================================================

Validated the application by using this URL : http://localhost:9393/ from the browser of the Host machine and got the expeted CSV output (Actually the contents of the inputFile)

=======================================================

As a last part of the Part 1 assignment, set the environment variable by using -e flag in the docker run command as below - 

$docker run -dp 127.0.0.1:9393:9300 -v /home/rana/Desktop/csvserver/solution/inputFile:/csvserver/inputdata -e CSVSERVER_BORDER=Orange infracloudio/csvserver

=======================================================

In this section, I used "docker stop <container_ID>" to stop the running container ; "docker start <container_ID>" to start the stopped container; "docker rm <container_ID>" to remove the stopped container.


#Created this README.md file which has all the commands that I used in Part 1 section. 


#Created a file called part-1-cmd which has the final docker run command with all the arguments that I have used in Part-1

#Executed below command to create another file called part-1-output:
curl -o ./part-1-output http://localhost:9393/raw


#Executed below commands to create another file called part-1-logs which basically has the logs files of the container-
$docker logs [container_id] >& part-1-logs



================================================================================================END of Section for Part1 Assignment=================================================================================================


