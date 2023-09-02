<p align="center">
  <img src="https://media.makeameme.org/created/the-simulation-environment.jpg" alt="Inception Logo" width="400">
</p>

<h1 align="center">Inception</h1>

<p align="center">
  <strong>🚀 Self deploying docker containers running a LEMP stack 🚀</strong>
</p>

---

## 📖 Table of Contents

- [Introduction](#-introduction)
- [Features](#-features)
- [Setup & Installation](#-setup--installation)
- [Usage](#-usage)

---

##  📢  Introduction

Inception is a robust project that leverages the power of Docker to seamlessly integrate Nginx, MariaDB and wordpress. 
  
---

## 📚  Features

- **Nginx** -> Nginx with SSL to localhost (user.42.fr). 
- **MariaDB** -> MariaDB database ready for wordpress. 
- **Wordpress** -> Wordpress installation with admin and custom user 

---

## 🛠  Setup & Installation


   ```bash
    git clone https://github.com/gde-alme/inception.git
    cd inception 
   ```
   ```
    Edit srcs/.env-default file to desired values ( database name , wp-admin user , etc ) 
    and save it as srcs/.env
   ```
   ```bash
    make
   ```
    

## 🧪  Usage

- **Admin** -> Go to https://$user.42.fr/wp-admin.
- **Visitor** -> Go to https://$user.42.fr.

---
