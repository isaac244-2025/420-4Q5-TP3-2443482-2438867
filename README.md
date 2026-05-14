# Configuration des machines virtuelles

## 1. Préparer les deux VM

Configurer deux machines virtuelles avec des adresses IP statiques via Netplan.

#### VM1
Adresse IP : `172.20.47.145`
Utilisateur : `vm1`
Mot de passe : `bob123`

#### VM2
Adresse IP : `172.20.47.146`
Utilisateur : `vm2`
Mot de passe : `bob123`


## 2. Installer les dépendances sur VM1

Sur la machine **VM1**, exécuter le script `requirements_installer.sh` afin d’installer les outils nécessaires :

- Docker
- Docker Compose
- rsync
- Git
- OpenSSH

Commandes :

```bash
chmod +x requirements_installer.sh
./requirements_installer.sh
```



## 3. Préparer la machine de sauvegarde (VM2)

Afin que le script de sauvegarde fonctionne correctement, créer un utilisateur dédié nommé `backuphelper` sur la VM2.

Cet utilisateur doit :

- avoir accès en SSH ;
- avoir uniquement les permissions d’écriture sur le répertoire de sauvegarde `/srv/backup/tp3`.

#### Création de l’utilisateur et du répertoire

```bash
sudo useradd --create-home backuphelper

sudo mkdir -p /srv/backup/tp3

sudo chown backuphelper:backuphelper /srv/backup/tp3

sudo chmod 700 /srv/backup/tp3
```


## 4. Clés SSH

Connectez-vous sur la VM1 et executer les commandes suivantes pour générer les clés SSH pour avoir l'accès sans mot de passe à l'utilisatuer backuphelper:
**VM1**
````bash
ssh-keygen -t rsa
scp /home/vm1/.ssh/id_rsa.pub backuphelper@172.20.47.146:/home/backuphelper/.ssh/
````
**VM2** user backuphelper
````bash
cd .ssh
mv id_rsa.pub authorized_keys2
````



http://localhost:8080/wp-admin/install.php en local sur windows