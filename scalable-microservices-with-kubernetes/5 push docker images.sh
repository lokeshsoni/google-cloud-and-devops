# Add tag to image
docker tag monolith:1.0.0 lokeshsonii/monolith:1.0.0

# Login and push the docker image
docker login
docker push lokeshsonii/monolith:1.0.0

# pushing to GCP
docker tag monolith:1.0.0 gcr.io/[project-id]/monolith:1.0.0
# docker tag monolith:1.0.0 gcr.io/computer-vision-research/monolith:1.0.0

gcloud docker -- push gcr.io/[project-id]/monolith:1.0.0
# gcloud docker -- push gcr.io/computer-vision-research/monolith:1.0.0