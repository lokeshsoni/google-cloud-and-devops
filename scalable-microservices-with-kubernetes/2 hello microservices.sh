# build and run the hello service
cd $GOPATH/src/github.com/udacity/ud615/app
go build -o ./bin/hello ./hello
sudo ./bin/hello -http 0.0.0.0:10082

# build and run the auth service
cd $GOPATH/src/github.com/udacity/ud615/app
go build -o ./bin/auth ./auth
sudo ./bin/auth -http :10090 -health :10091

# 
TOKEN=$(curl 127.0.0.1:10090/login -u user | jq -r '.token')
curl -H "Authorization:  Bearer $TOKEN" http://127.0.0.1:10082/secure
