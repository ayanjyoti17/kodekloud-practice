# An application currently running on the Kubernetes cluster employs the nginx web server. The Nautilus application 
# development team has introduced some recent changes that need deployment. They've crafted an image nginx:1.19 with 
# the latest updates.
Execute a rolling update for this application, integrating the nginx:1.19 image. The deployment is named nginx-deployment.

Ensure all pods are operational post-update.

Note: The kubectl utility on jump_host is set up to operate with the Kubernetes cluster


# Solution ->>>>>>>>>>

# Step 1: Trigger the Rolling Update
kubectl set image deployment/nginx-deployment nginx-container=nginx:1.19

# Step 2: Monitor the Rollout Status
kubectl rollout status deployment/nginx-deployment

# Step 3: Verify the Pods
kubectl get pods
kubectl describe pod <your-new-pod-name> | grep Image # Inspect a new pod to confirm the image version