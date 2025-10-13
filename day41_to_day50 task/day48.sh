# The Nautilus DevOps team is diving into Kubernetes for application management. One team member has a task 
# to create a pod according to the details below:

1.  Create a pod named pod-nginx using the nginx image with the latest tag. Ensure to specify the tag as nginx:latest.

2.  Set the app label to nginx_app, and name the container as nginx-container.
Note: The kubectl utility on jump_host is configured to operate with the Kubernetes cluster.


# Solution ->>>>>>

# Pod Manifest 

apiVersion: v1
kind: Pod
metadata:
  name: pod-nginx
  labels:
    app: nginx_app
spec:
  containers:
  - name: nginx-container
    image: nginx:latest

# Step 1: Save the Manifest
Save the YAML content above into a file named pod.yaml on the jump_host.

# Step 2: Apply the Manifest to the Cluster
kubectl apply -f pod.yaml

# Step 3: Verify the Pod ✅
kubectl get pods --show-labels
