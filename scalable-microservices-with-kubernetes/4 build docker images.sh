# Build a static binary of the monolith app
cd $GOPATH/src/github.com/udacity
cd ud615/app/monolith
go get -u
go build --tags netgo --ldflags '-extldflags "-lm -lstdc++ -static"'

# Build the app container
docker build -t monolith:1.0.0 .

# Run the container and test it
docker run -d monolith:1.0.0
docker inspect <container name or cid>

CID=$(docker run -d monolith:1.0.0)
CIP=$(sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${CID})

curl $CIP
