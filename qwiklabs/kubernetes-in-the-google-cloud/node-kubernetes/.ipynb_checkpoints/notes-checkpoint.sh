docker build -t gcr.io/$PROJECT_ID/hello-node:v1 .

docker run -d -p 8080:8080 gcr.io/$PROJECT_ID/hello-node:v1

docker stop [CONTAINER ID]

docker push gcr.io/$PROJECT_ID/hello-node:v1

# update
docker build -t gcr.io/$PROJECT_ID/hello-node:v2 .
docker push gcr.io/$PROJECT_ID/hello-node:v2