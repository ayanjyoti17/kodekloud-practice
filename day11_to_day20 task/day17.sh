# Day 17: Install and Configure PostgreSQL
# The Nautilus application development team has shared that they are planning to deploy one newly developed application 
# on Nautilus infra in Stratos DC. The application uses PostgreSQL database, so as a pre-requisite we need to set up 
# PostgreSQL database server as per requirements shared below:

# PostgreSQL database server is already installed on the Nautilus database server.
# a. Create a database user kodekloud_rin and set its password to 8FmzjvFU6S.
# b. Create a database kodekloud_db2 and grant full permissions to user kodekloud_rin on this database.
# Note: Please do not try to restart PostgreSQL server service.

# step 1 : Connect to the Database Server
First, connect to the Nautilus database server from the jump host.
ssh peter@stdb01

# step 2 : Switch to the postgres User
To perform administrative tasks in PostgreSQL, you need to switch to the default postgres system user.
sudo -i -u postgres

# step 3 : Access the PostgreSQL Shell 
Now that you are the postgres user, you can access the interactive PostgreSQL command-line shell.
psql  #Your command prompt will change to 'postgres=#', indicating you are ready to enter SQL commands.

# step 4 : Run SQL Commands
# a. Create the database user and set its password 
CREATE USER kodekloud_rin WITH PASSWORD '8FmzjvFU6S';

# b. Create the database
CREATE DATABASE kodekloud_db2;

# c. Grant full permissions to the user on the new database
GRANT ALL PRIVILEGES ON DATABASE kodekloud_db2 TO kodekloud_rin;

## 5. Verify and Exit
You can quickly verify that the user and database were created.

To list users, type \du and press Enter. You should see kodekloud_rin in the list.

To list databases, type \l and press Enter. You should see kodekloud_db2 in the list.

Once you have confirmed, you can exit the psql shell and the postgres user session.

# Exit the psql shell
\q

# Exit from the postgres user back to your original user
exit

# The task is now complete.