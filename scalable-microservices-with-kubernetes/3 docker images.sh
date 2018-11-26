# Install Docker
sudo apt-get install docker.io

# Check Docker images
sudo docker images

# Pull nginx image
sudo docker pull nginx:1.10.0
sudo docker images

# Run the first instance
sudo docker run -d nginx:1.10.0

# Check if it's up
sudo docker ps

# Run a different version of nginx
sudo docker run -d nginx:1.9.3

# Run another version of nginx
sudo docker run -d nginx:1.10.0

# Check how many instances are running
sudo docker ps
sudo ps aux | grep nginx