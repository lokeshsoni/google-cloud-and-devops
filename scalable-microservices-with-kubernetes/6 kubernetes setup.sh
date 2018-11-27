# Provision a Kubernetes Cluster and connect to it

# Launch a single instance
kubectl run nginx --image=nginx:1.10.0

# Get pods
kubectl get pods

# Expose nginx
kubectl expose deployment nginx --port 80 --type LoadBalancer

# List services
kubectl get services

# Explore config file
cd cd $GOPATH/src/github.com/udacity/ud615/kubernetes
cat pods/monolith.yaml

# Create the monolith pod
kubectl create -f pods/monolith.yaml
kubectl describe pods monolith

# set up port-forwarding
kubectl port-forward monolith 10080:80

# testing
curl http://127.0.0.1:10080
curl http://127.0.0.1:10080/secure

curl -u user http://127.0.0.1:10080/login
curl -H "Authorization: Bearer <token>" http://127.0.0.1:10080/secure

# interactive shell to container
kubectl exec monolith --stdin --tty -c monolith /bin/sh

