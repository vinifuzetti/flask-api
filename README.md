# flask-api
API para projeto CI/CD
Store Application and pipeline

Steps

1. start docker (systemctl start docker)
2. run Jenkins (docker run -d -p 80:8080 -v /home/ec2-user:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock jenkins-bomba)

Admin Jenkins:
tratore/admin123

Application Instance EC2 - Deploy to Docker Swarm
1. start swarm (docker swarm init)
2. start service (docker stack deploy -c compose-api.yaml serv)
3. list services (docker service ls)

4. Update image from Jenkins, through ssh (sudo docker service update --image vrfuzetti/flask-api:VERSION serv_flask-api)

---------------------------------------------------------------------------------------------------------------

Build Jenkins image - custom
***************************************************************
from jenkinsci/jenkins:lts
 
USER root
RUN apt-get update -qq \
    && apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common 
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
RUN apt-get update  -qq \
    && apt-get install docker-ce=17.12.1~ce-0~debian -y
RUN usermod -aG docker jenkins
***************************************************************