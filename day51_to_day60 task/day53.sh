# We encountered an issue with our Nginx and PHP-FPM setup on the Kubernetes cluster this morning, which halted its functionality. 
Investigate and rectify the issue: 
The pod name is nginx-phpfpm and configmap name is nginx-config. Identify and fix the problem. 

Once resolved, copy /home/thor/index.php file from the jump host to the nginx-container within the nginx document root. 

After this, you should be able to access the website using Website button on the top bar. 
Note: The kubectl utility on jump_host is configured to operate with the Kubernetes cluster.


# Solution ->>>>>>>>>
# Step 1 : Check existing running pods 
kubectl get pods

# Step 2 : check the shared volume path in existing config map 
kubectl get configmap
kubectl describe configmap nginx-config

# Step 3 : Get the configuration in the YAML file from the running pod 
kubectl get pod nginx-phpfpm -o yaml  > /tmp/nginx.yaml
ls /tmp/
cat /tmp/nginx.yaml

# Step 4 : Edit the nginx.yaml file and changed ‘/usr/share/nginx/html’ to ‘/var/www/html’ in 3 places.
vi /tmp/nginx.yaml
# you can check using this in which places to change->
cat /tmp/nginx.yaml  |grep /usr/share/nginx/html

# Step 5 : Post changes the mount path run below command to replace the running pods  
kubectl replace -f /tmp/nginx.yaml --force

# Step 6 : Wait for pods to get running status.
kubectl get pods

# Step 7 : Now copy the index.php file as per the task.  
ls /home/thor/
kubectl cp  /home/thor/index.php  nginx-phpfpm:/var/www/html -c nginx-container

# Step 8 : validate the task by curl the Nginx port 
kubectl exec -it nginx-phpfpm -c nginx-container  -- curl -I  http://localhost:8099
# you will see like this -> 
HTTP/1.1 200 OK

Server: nginx/1.21.1

Date: Fri, 17 Oct 2025 13:45:17 GMT

Content-Type: text/html; charset=UTF-8

Connection: keep-alive

X-Powered-By: PHP/7.2.34