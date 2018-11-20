docker build -t node-app:0.1 .

docker images

docker run -p 4000:80 --name my-app node-app:0.1

docker stop my-app && docker rm my-app

docker run -p 4000:80 --name my-app -d node-app:0.1

docker ps

docker logs -f [container_id]

docker build -t node-app:0.2 .

docker run -p 8080:80 --name my-app-2 -d node-app:0.2

docker exec -it [container_id] bash

docker inspect [container_id]

# Get an instance’s IP address
docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $INSTANCE_ID

# Get an instance’s MAC address
docker inspect --format='{{range .NetworkSettings.Networks}}{{.MacAddress}}{{end}}' $INSTANCE_ID

# Get an instance’s log path
docker inspect --format='{{.LogPath}}' $INSTANCE_ID

# Get an instance’s image name
docker inspect --format='{{.Config.Image}}' $INSTANCE_ID

# List all port bindings
docker inspect --format='{{range $p, $conf := .NetworkSettings.Ports}} {{$p}} -> {{(index $conf 0).HostPort}} {{end}}' $INSTANCE_ID

# Pushing to GCR
docker tag node-app:0.2 gcr.io/[project-id]/node-app:0.2

gcloud docker -- push gcr.io/[project-id]/node-app:0.2

# stop and remove all the containers
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)

docker rmi $(docker images -aq)

docker rmi node-app:0.2 gcr.io/[project-id]/node-app node-app:0.1
docker rmi node:6
docker rmi $(docker images -aq)
docker images

# remove all images with force
docker rmi -f $(docker images -q)

PROJECT_ID=deep-learning-research-1611

# Pull from GCR and run it
gcloud docker -- pull gcr.io/$PROJECT_ID/node-app:0.2
docker run -p 4000:80 -d gcr.io/$PROJECT_ID/node-app:0.2
curl http://localhost:4000

#######################################################################

# for flask-uwsgi-nginx
docker build -t flask-app:1.0 .
docker run -d -p 80:80 flask-app:1.0
docker logs -f f2d52fcfc9f3

# authenticate gcloud sdk
gcloud auth login
gcloud config list project 
gcloud auth configure-docker

PROJECT_ID=deep-learning-research-1611

docker tag flask-app:1.0 gcr.io/$PROJECT_ID/flask-app:1.0
gcloud docker -- push gcr.io/$PROJECT_ID/flask-app:1.0
docker pull gcr.io/$PROJECT_ID/flask-app:1.0

docker run -d -p 80:80 gcr.io/$PROJECT_ID/flask-app:1.0
curl http://localhost:80/home

ENV NGINX_MAX_UPLOAD 1m
ENV LISTEN_PORT 8080
EXPOSE 8080

ENV UWSGI_INI /application/uwsgi.ini

COPY ./application /application
WORKDIR /application

ENV STATIC_PATH /app/custom_static
ENV STATIC_URL /content

ENV NGINX_WORKER_CONNECTIONS 2048
ENV NGINX_WORKER_OPEN_FILES 2048

