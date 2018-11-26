# Add tag to image
docker tag monolith:1.0.0 lokeshsonii/monolith:1.0.0

# Login and push the docker image
docker login
docker push lokeshsonii/monolith:1.0.0
