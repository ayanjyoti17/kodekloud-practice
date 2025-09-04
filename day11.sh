# Day 11: Install and Configure Tomcat Server

# The Nautilus application development team recently finished the beta version of one of their Java-based applications,
# which they are planning to deploy on one of the app servers in Stratos DC. After an internal team meeting,
# they have decided to use the tomcat application server. Based on the requirements mentioned below complete the task:

#a. Install tomcat server on App Server 3.

#b. Configure it to run on port 8082.

#c. There is a ROOT.war file on Jump host at location /tmp.
# Deploy it on this tomcat server and make sure the webpage works directly on base URL i.e curl http://stapp03:8082


# step 1 : Connect to App Server 3
ssh banner@stapp03

# step 2 : Install tomcat server on App Server 3
sudo yum install tomcat -y

# step 3 : Configure Tomcat to use port 8082
Open the Tomcat server configuration file -> 
sudo vi /etc/tomcat/server.xml

#Locate the <Connector> element and change the port
Find the line that contains port="8080" and change it to port="8082".
<Connector port="8082" protocol="HTTP/1.1" connectionTimeout="20000" redirectPort="8443" />

Save and close the file.

# step 4 : Restart the Tomcat service for the changes to take effect.
sudo systemctl restart tomcat

# step 5 : Deploy the ROOT.war file
# Copy the ROOT.war file to a temporary directory
From your jump host, copy the file to the /tmp directory on stapp03 ->
scp /tmp/ROOT.war banner@stapp03:/tmp/

# Move the WAR file to the Tomcat webapps directory
SSH into stapp03 as the banner user-> 
ssh banner@stapp03
sudo mv /tmp/ROOT.war /var/lib/tomcat/webapps/

# Change the ownership of the file to the tomcat user and group so that the server can properly access it.
sudo chown tomcat:tomcat /var/lib/tomcat/webapps/ROOT.war

# step 6 : Verify the deployment
Finally, use curl from the jump host to confirm that the application is accessible on the base URL at the new port->
curl http://stapp03:8082