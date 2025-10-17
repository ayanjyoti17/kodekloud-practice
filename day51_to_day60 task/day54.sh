# We are working on an application that will be deployed on multiple containers within a pod on Kubernetes cluster. 
# There is a requirement to share a volume among the containers to save some temporary data. The Nautilus DevOps team 
# is developing a similar template to replicate the scenario. Below you can find more details about it. 
1.  Create a pod named volume-share-xfusion. 
2.  For the first container, use image fedora with latest tag only and remember to mention the tag i.e fedora:latest, 
container should be named as volume-container-xfusion-1, and run a sleep command for it so that it remains in running state. 
Volume volume-share should be mounted at path /tmp/media. 
3.  For the second container, use image fedora with the latest tag only and remember to mention the tag i.e fedora:latest, 
container should be named as volume-container-xfusion-2, and again run a sleep command for it so that it remains in running state.
Volume volume-share should be mounted at path /tmp/demo. 
4.  Volume name should be volume-share of type emptyDir. 
5.  After creating the pod, exec into the first container i.e volume-container-xfusion-1, and just for testing create a 
file media.txt with any content under the mounted path of first container i.e /tmp/media. 
6.  The file media.txt should be present under the mounted path /tmp/demo on the second container volume-container-xfusion-2 
as well, since they are using a shared volume. 
Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.


# Solution ->>>>>>>>>>>
# Save the following content to a file named shared-volume-pod.yaml on the jump_host.
apiVersion: v1
kind: Pod
metadata:
  name: volume-share-xfusion
spec:
  # Define the shared volume at the Pod level
  volumes:
    - name: volume-share
      emptyDir: {}

  # Define the two containers that will use the volume
  containers:
    - name: volume-container-xfusion-1
      image: fedora:latest
      # Command to keep the container running
      command: ["/bin/bash", "-c", "sleep 3600"]
      # Mount the shared volume at the specified path
      volumeMounts:
        - name: volume-share
          mountPath: /tmp/media

    - name: volume-container-xfusion-2
      image: fedora:latest
      command: ["/bin/bash", "-c", "sleep 3600"]
      # Mount the same shared volume at a different path
      volumeMounts:
        - name: volume-share
          mountPath: /tmp/demo

# Step 1: Apply the Manifest
kubectl apply -f shared-volume-pod.yaml

# Step 2: Verify the Pod is Running
kubectl get pod volume-share-xfusion

# Step 3: Test the Shared Volume, Exec into the first container and create the test file in its mounted directory.
kubectl exec -it volume-share-xfusion -c volume-container-xfusion-1 -- touch /tmp/media/media.txt

# step 4: Verify the file exists in the second container. Exec into the second container and list the contents of its mounted directory.
kubectl exec -it volume-share-xfusion -c volume-container-xfusion-2 -- ls /tmp/demo

---- You should see media.txt listed in the output, confirming that the volume is successfully shared between the two containers.