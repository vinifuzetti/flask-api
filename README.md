# flask-api
API para projeto CI/CD
Store Application

Ao conectar maquina Jenkins: ec2-************-199.compute-1.amazonaws.com

start docker (systemctl start docker)
docker run -d -p 80:8080 -v /home/ec2-user:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock jenkins-bomba

Admin Jenkins:
tratore
admin123
Build docker image (Jenkins com docker client)
***************************************************************
*
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
*
***************************************************************

Na nova instancia de EC2, vamos fazer o deploy para o Docker Swarm
> docker swarm init
> docker stack deploy -c compose-api.yaml serv
> docker service ls 

Com o serviço no ar, teremos um arquivo de compose template (compose-api.yaml) para fazer update da imagem via Jenkins, através de um comando ssh:

> sudo docker service update --image vrfuzetti/flask-api:VERSION serv_flask-api