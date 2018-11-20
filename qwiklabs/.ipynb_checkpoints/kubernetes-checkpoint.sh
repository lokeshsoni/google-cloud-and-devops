PROJECT_ID=deep-learning-research-1611

gcloud container clusters create hello-world \
                --num-nodes 2 \
                --machine-type n1-standard-1 \
                --zone us-central1-a 
#                 --enable-basic-auth
#                 --issue-client-certificate
#                 --metadata disable-legacy-endpoints=true
                
# gcloud config set container/new_scopes_behavior true

kubectl run hello-node \
    --image=gcr.io/$PROJECT_ID/hello-node:v1 \
    --port=8080
    
kubectl get deployments
kubectl get pods

kubectl cluster-info
kubectl config view
kubectl get events

kubectl logs <pod-name>

kubectl expose deployment hello-node --type="LoadBalancer"

kubectl get services

kubectl scale deployment hello-node --replicas=4

kubectl get deployment

# update
kubectl edit deployment hello-node
    gcr.io/deep-learning-research-1611/hello-node:v2
    
# dashboard
gcloud container clusters get-credentials hello-world \
    --zone us-central1-a --project $PROJECT_ID
    
kubectl -n kube-system describe $(kubectl -n kube-system \
   get secret -n kube-system -o name | grep namespace) | grep token:
   
kubectl proxy --port 8081
    http://localhost:8081/ui
    
# cleanup
kubectl delete service hello-node
gcloud container clusters delete hello-world --zone us-central1-a