# Add your own tag
sudo docker tag monolith:1.0.0 <your username>/monolith:1.0.0
For example (you can rename too!)

sudo docker tag monolith:1.0.0 udacity/example-monolith:1.0.0
Create account on Dockerhub
To be able to push images to Dockerhub you need to create an account there - https://hub.docker.com/register/

Login and use the docker push command
sudo docker login
sudo docker push udacity/example-monolith:1.0.0
