# Install Docker
sudo apt-get install docker.io

# Check Docker images
sudo docker images

# Pull nginx image
sudo docker pull nginx:1.10.0
sudo docker images

# Run the first instance
sudo docker run -d nginx:1.10.0