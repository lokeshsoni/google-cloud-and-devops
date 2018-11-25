# Build and Interact with Monolith
cd $GOPATH/src/github.com/udacity/ud615/app
mkdir bin
go build -o ./bin/monolith ./monolith

# run the monolith server
sudo ./bin/monolith -http :10080

# test the app
curl http://127.0.0.1:10080
curl http://127.0.0.1:10080/secure

# authenticate
# password is password
curl http://127.0.0.1:10080/login -u user
# returns a auth token

# login and assign the value of the JWT to a variable
TOKEN=$(curl http://127.0.0.1:10080/login -u user | jq -r '.token')
echo $TOKEN

# access the secure endpoint using the JWT
curl -H "Authorization: Bearer $TOKEN" http://127.0.0.1:10080/secure