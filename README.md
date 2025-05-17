# Docker Commands and Usage

## Setup and User Permissions

1. Add your user to the Docker group:
   ```sh
   sudo usermod -aG docker $USER
   ```
2. Log out and log back in for the changes to take effect.
3. Verify your user is now part of the Docker group:
   ```sh
   groups $USER
   ```
4. Restart the Docker service if needed:
   ```sh
   sudo systemctl restart docker
   ```
5. If you encounter a permission denied error, refresh your group membership:
   ```sh
   newgrp docker
   ```

## Building and Managing Images

1. Build an image from the current directory:
   ```sh
   docker build .
   ```
2. List all images:
   ```sh
   docker image ls
   ```
3. Delete a specific image:
   ```sh
   docker image rm <image_id>
   ```
4. Build an image with a specific name:
   ```sh
   docker build -t node-app-image .
   ```

## Running and Managing Containers

1. Run a container from an image:
   ```sh
   docker run -p 5000:5000 -d --name node-app node-app-image
   ```
2. List running containers:
   ```sh
   docker ps
   ```
3. List all containers (including stopped ones):
   ```sh
   docker ps -a
   ```
4. Remove a container:
   ```sh
   docker rm node-app -f
   ```
5. Access the file system of a running container:
   ```sh
   docker exec -it node-app bash
   ```
   Exit the container shell:
   ```sh
   exit
   ```

## Docker Volumes

### Bind Mount

1. Run a container with a bind mount:
   ```sh
   docker run -v /local/path:/container/path -p 5000:5000 -d --name node-app node-app-image
   ```
2. Example:
   ```sh
   docker run -v $(pwd):/app -p 5000:5000 -d --name node-app node-app-image
   ```
3. Running with node_modules volume:
   ```sh
   docker run -v $(pwd):/app -v /app/node_modules -p 5000:5000 -d --name node-app node-app-image
   ```

### Read-Only Bind Mount

1. Prevent file modifications inside the container:
   ```sh
   docker run -v $(pwd):/app:ro -v /app/node_modules -p 5000:5000 -d --name node-app node-app-image
   ```
2. Use environment variables:
   ```sh
   docker run -v $(pwd):/app:ro -v /app/node_modules --env PORT=4000 -p 5000:4000 -d --name node-app node-app-image
   ```
3. Load environment variables from a file:
   ```sh
   docker run -v $(pwd):/app:ro -v /app/node_modules --env-file ./.env -p 5000:3000 -d --name node-app node-app-image
   ```

## Docker Logs and Cleanup

1. View logs of a container:
   ```sh
   docker logs node-app
   ```
2. List all volumes:
   ```sh
   docker volume ls
   ```
3. Prune unused volumes:
   ```sh
   docker volume prune
   ```
4. Delete a container along with its volume:
   ```sh
   docker rm node-app -fv
   ```

## Docker Compose

1. Install Docker Compose:
   ```sh
   sudo apt install docker-compose
   ```
2. Start containers in detached mode:
   ```sh
   docker-compose up -d
   ```
3. Stop and remove containers, networks, and volumes:
   ```sh
   docker-compose down -v
   ```
4. Build and start containers:
   ```sh
   docker-compose up -d --build
   ```

## Fixing KeyError: 'ContainerConfig' in Docker Compose

1. Restart Docker and prune the system:
   ```sh
   sudo systemctl restart docker
   docker system prune -a -f
   ```

## Docker Compose for Development and Production

1. Use separate configurations:
   ```sh
   docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d
   ```
2. Stop and remove containers, networks, and volumes:
   ```sh
   docker-compose -f docker-compose.yml -f docker-compose.dev.yml down -v
   ```
3. Run for production without bind mounts:
   ```sh
   docker-compose -f docker-compose.yml -f docker-compose.dev.yml -f docker-compose.prod.yml up -d
   ```
4. Force build changes:
   ```sh
   docker-compose -f docker-compose.yml -f docker-compose.dev.yml -f docker-compose.prod.yml up -d --build
   ```

## MongoDB in Docker

1. Access MongoDB container:
   ```sh
   docker exec -it learn-docker_mongo_1 bash
   ```
2. Connect to MongoDB shell:
   ```sh
   mongosh -u "root" -p "example"
   ```
3. Show databases:
   ```sh
   show dbs
   ```
4. Switch to a database:
   ```sh
   use myDB
   ```
5. Insert data:
   ```sh
   db.books.insertOne({"name": "NTM"})
   ```
6. View data:
   ```sh
   db.books.find()
   ```
7. Exit MongoDB shell:
   ```sh
   exit
   ```

## Storing Database Data Persistently

1. Create a named volume:
   ```sh
   docker volume create mongo-db
   ```
2. Use named volume with Docker Compose:
   
   ```sh
   docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d
   ```
3. Remove unused volumes:
   ```sh
   docker volume prune
   ```