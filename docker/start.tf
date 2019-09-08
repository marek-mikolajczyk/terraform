# Configure the Docker provider
### needed modifying systemd for adding port 2376, daemon-reload and firewall
provider "docker" {
  host = "tcp://docker.marekexample.com:2376/"
}

### prepare 2 containers - one default, second with custom index.html
# configure nginx image 1
resource "docker_image" "nginx" {
  name  = "nginx:latest"
}

# Create an Nginx container 1
resource "docker_container" "nginx1" {
  image = "${docker_image.nginx.latest}"
  name  = "nginx1"
  ports {
    internal = 80
    external = 8010
  }
}

# configure nginx image 2
resource "docker_image" "nginx2" {
  name  = "nginx:latest"
}

# Create an Nginx container 2
resource "docker_container" "nginx2" {
  image = "${docker_image.nginx.latest}"
  name  = "nginx2"
  ports {
    internal = 80
    external = 8011
  }
  volumes {
    container_path  = "/usr/share/nginx/html"
    host_path = "/docker/my-nginx/html"
    read_only = true
  }
}


### for test purposes - 3rd container is same as 1st
# configure nginx image 3
resource "docker_image" "nginx3" {
  name  = "nginx:latest"
}

# Create an Nginx container 3
resource "docker_container" "nginx3" {
  image = "${docker_image.nginx.latest}"
  name  = "nginx3"
  ports {
    internal = 80
    external = 8012
  }
}
