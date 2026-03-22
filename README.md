*This project has been created as part of the 42 curriculum by mobougri.*

# Inception

## Description

Inception is a system administration project from the 42 curriculum. The goal is to set up a small infrastructure composed of different services using Docker and Docker Compose, all running inside a virtual machine.

The infrastructure consists of three services:
- **NGINX** — the only entry point, handling HTTPS with TLSv1.2/TLSv1.3
- **WordPress + PHP-FPM** — the web application
- **MariaDB** — the database

### Design Choices

**Virtual Machines vs Docker**
A Virtual Machine emulates an entire operating system with its own kernel, requiring significant resources. Docker containers share the host kernel and are lightweight, faster to start, and more portable. However, VMs provide stronger isolation. For this project, Docker is used to run isolated services efficiently.

**Secrets vs Environment Variables**
Environment variables are convenient but can be exposed in logs or inspected easily. Docker secrets store sensitive data as files mounted in `/run/secrets/`, making them more secure. In this project, passwords are stored as Docker secrets while non-sensitive config uses environment variables.

**Docker Network vs Host Network**
Host network shares the host's network stack — containers can access all host ports, which is a security risk. Docker bridge network isolates containers in a private network, only exposing what is explicitly declared. This project uses a bridge network called `inception`.

**Docker Volumes vs Bind Mounts**
Bind mounts link a host directory directly into a container — they depend on the host's file structure. Docker named volumes are managed by Docker and are more portable. This project uses named volumes stored in `/home/mobougri/data` for data persistence.

## Instructions

### Prerequisites
- Docker
- Docker Compose
- Make

### Installation

1. Clone the repository
2. Configure your `/etc/hosts`:
```
127.0.0.1    mobougri.42.fr
```
3. Build and start the project:
```bash
make
```
4. Access the website at `https://mobougri.42.fr`

### Available commands
- `make` — build and start all containers
- `make down` — stop all containers
- `make re` — rebuild and restart
- `make clean` — stop and remove volumes
- `make fclean` — full cleanup

## Resources

- [Docker documentation](https://docs.docker.com)
- [Docker Compose documentation](https://docs.docker.com/compose)
- [WordPress CLI documentation](https://wp-cli.org)
- [NGINX documentation](https://nginx.org/en/docs)
- [MariaDB documentation](https://mariadb.com/kb/en)
- [PID 1 in Docker](https://cloud.google.com/architecture/best-practices-for-building-containers)

### AI Usage

AI was used in this project for:
- Debugging Docker configuration errors (MariaDB socket issues, PHP-FPM configuration)
- Understanding Docker concepts (PID 1, secrets, volumes)
