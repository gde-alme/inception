<p align="center">
  <img src="https://media.makeameme.org/created/the-simulation-environment.jpg" alt="Inception Logo" width="400">
</p>

<h1 align="center">Inception</h1>

<p align="center">
  <strong>🚀 Self deploying dockerized LEMP stack 🚀</strong>
</p>

---

## 📖 Table of Contents

- [Introduction](#-introduction)
- [Features](#-features)
- [Setup & Installation](#-setup--installation)

---

##  📢  Introduction

Three docker containers:
- **Nginx** -> Nginx with SSL to localhost (user.42.fr). 
- **MariaDB** -> MariaDB database ready for wordpress. 
- **Wordpress** -> Wordpress installation with admin and custom user 

---

## 🛠  Setup & Installation


   ```bash
    git clone https://github.com/gde-alme/inception.git
    cd inception 
   ```
    Edit srcs/.env-default file to desired values ( database name , wp-admin user , etc ) 
    and save it as srcs/.env 
   ```bash
    make
   ```
---
