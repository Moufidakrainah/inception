# User Documentation

## Services provided

This stack provides the following services:
- **WordPress** — a website accessible at `https://mobougri.42.fr`
- **MariaDB** — the database storing all WordPress content
- **NGINX** — the web server handling HTTPS connections on port 443

## Start and stop the project

**Start:**
```bash
make
```

**Stop:**
```bash
make down
```

**Rebuild from scratch:**
```bash
make re
```

## Access the website

1. Add this line to `/etc/hosts` on your machine:
```
127.0.0.1    mobougri.42.fr
```
2. Open your browser and go to: `https://mobougri.42.fr`
3. Accept the self-signed certificate warning

**WordPress admin panel:**
- URL: `https://mobougri.42.fr/wp-admin`
- Admin login: `mobougri`
- Password: stored in `secrets/wp_admin_password.txt`

## Credentials

All credentials are stored in the `secrets/` folder at the root of the project:
- `secrets/db_password.txt` — WordPress database password
- `secrets/db_root_password.txt` — MariaDB root password
- `secrets/wp_admin_password.txt` — WordPress admin password
- `secrets/wp_user_password.txt` — WordPress user password
- `secrets/credentials.txt` — list of usernames

## Check that services are running
```bash
docker ps
```

You should see three containers running:
- `nginx` — Up, port 443
- `wordpress` — Up, port 9000
- `mariadb` — Up, port 3306

**Check logs:**
```bash
docker logs nginx
docker logs wordpress
docker logs mariadb
```
