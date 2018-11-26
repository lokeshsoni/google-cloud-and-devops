# Install Docker
sudo apt-get install docker.io

# Check Docker images
docker images

# Pull nginx image
docker pull nginx:1.10.0
docker images

# Run the first instance
docker run -d nginx:1.10.0

# Check if it's up
docker ps

# Run a different version of nginx
docker run -d nginx:1.9.3

# List all running container processes
docker ps
docker ps -aq

# Inspect the container
docker inspect <CONTAINER ID/NAMES>

# Connect to the nginx using the internal IP
CID="<CONTAINER ID/NAMES>"
CIP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $CID)
curl  http://$CIP

sudo docker inspect -f '{{.Name}} - {{.NetworkSettings.IPAddress }}' $(sudo docker ps -aq)