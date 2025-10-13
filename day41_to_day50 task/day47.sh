# A python app needed to be Dockerized, and then it needs to be deployed on App Server 1. We have already copied 
# a requirements.txt file (having the app dependencies) under /python_app/src/ directory on App Server 1. 
# Further complete this task as per details mentioned below:

1.  Create a Dockerfile under /python_app directory:
    Use any python image as the base image.
    Install the dependencies using requirements.txt file.
    Expose the port 6300.
    Run the server.py script using CMD.

2.  Build an image named nautilus/python-app using this Dockerfile.

3.  Once image is built, create a container named pythonapp_nautilus:
    Map port 6300 of the container to the host port 8097.

4.  Once deployed, you can test the app using curl command on App Server 1.
    curl http://localhost:8097/


# Solution ->>>>>>>
first ssh into App Server 1,then 
cd /python_app 

# Step 1 : Create the Dockerfile

# a. Use a python image as the base image.
# A slim image is used to keep the final image size smaller.
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file from the src directory on the host
# into the container's working directory.
COPY ./src/requirements.txt .

# b. Install the dependencies using requirements.txt file.
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire src directory into the container's working directory.
COPY ./src .

# c. Expose the port 6300.
EXPOSE 6300

# d. Run the server.py script using CMD.
CMD [ "python", "server.py" ]

# Step 2 : Build the Docker Image
sudo docker build -t nautilus/python-app .

# Step 3: Run the Container
sudo docker run -d --name pythonapp_nautilus -p 8097:6300 nautilus/python-app

# Step 4: Verify the Application 
curl http://localhost:8097/