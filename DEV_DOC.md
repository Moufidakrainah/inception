# Developer Documentation

## Prerequisites

- Virtual Machine with Debian
- Docker
- Docker Compose
- Make
- Git

## Environment setup from scratch

### 1. Clone the repository
```bash
git clone <your-repo> inception
cd inception
```

### 2. Create the secrets
```bash
mkdir -p secrets
echo "your_db_password" > secrets/db_password.txt
echo "your_root_password" > secrets/db_root_password.txt
echo "your_admin_password" > secrets/wp_admin_password.txt
echo "your_user_password" > secrets/wp_user_password.txt
```

### 3. Configure the .env file
```bash
nano srcs/.env
```
```
DOMAIN_NAME=mobougri.42.fr
MYSQL_DATABASE=wordpress_db
MYSQL_USER=wp_user
MYSQL_HOST=mariadb
WP_ADMIN=mobougri
WP_ADMIN_EMAIL=mobougri@student.42.fr
WP_USER=wpuser
WP_USER_EMAIL=wpuser@student.42.fr
```

### 4. Configure /etc/hosts
```bash
echo "127.0.0.1    mobougri.42.fr" >> /etc/hosts
```

### 5. Create data directories
```bash
mkdir -p /home/mobougri/data/mariadb
mkdir -p /home/mobougri/data/wordpress
```

## Build and launch
```bash
make
```

## Useful commands

| Command | Description |
|---------|-------------|
| `make` | Build and start all containers |
| `make down` | Stop all containers |
| `make re` | Rebuild and restart |
| `make clean` | Stop and remove volumes |
| `make fclean` | Full cleanup including images |
| `docker ps` | List running containers |
| `docker logs <name>` | View container logs |
| `docker exec -it <name> bash` | Enter a container |

## Data persistence

All persistent data is stored on the host machine in `/home/mobougri/data`:

- `/home/mobougri/data/mariadb` — MariaDB database files
- `/home/mobougri/data/wordpress` — WordPress website files

These directories are mounted as Docker named volumes:
- `srcs_db_volume` → `/home/mobougri/data/mariadb`
- `srcs_wp_volume` → `/home/mobougri/data/wordpress`

Data persists across container restarts. To reset all data:
```bash
make clean
rm -rf /home/mobougri/data/mariadb/*
rm -rf /home/mobougri/data/wordpress/*
```
