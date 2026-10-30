Pourquoi ne faut-il pas envoyer les fichiers .db sur GitHub alors qu'on envoie schema.sql ?
Le fichier schema.sql contient uniquement la structure de la base de données (définition des tables, types, relations), ce qui est statique et indispensable pour que l'application sache comment construire ses tables. En revanche, les fichiers .db contiennent les données vivantes et modifiées de l'utilisateur (données locales, tests, etc.). Les stocker sur GitHub créerait des conflits constants, alourdirait le dépôt pour rien et présenterait des risques de fuite de données personnelles ou de test. Chaque appareil doit générer sa propre base SQLite locale à partir du schéma.

Réponse à la question de réflexion :

Si votre application ne fonctionne plus après la partie 07, comment l'historique des commits vous permet-il de retrouver la dernière version qui marchait ?
L'historique des commits agit comme des points de sauvegarde (« checkpoints »). En tapant git log --oneline, vous pouvez identifier le hachage (hash) du commit de la partie précédente qui fonctionnait, puis utiliser git checkout <hash> (ou git restore) pour revenir instantanément à cette version stable, inspecter ce qui a cassé, ou créer une branche de correction propre.

Question 1.3 
SQLite ne possède ni type BOOLEAN ni type DATETIME. Comment stocke-t-on disponible et date_ajout ?

disponible est stocké sous forme d'un INTEGER (valeur 1 pour vrai/vrai, 0 pour faux).

date_ajout est stocké sous forme de TEXT en respectant le format standard ISO 8601 (ex. '2026-10-01T09:00:00').

Quel est le rôle de AUTOINCREMENT ?

Il garantit que chaque nouvel enregistrement reçoit automatiquement un identifiant (id) unique, entier et incrémenté de manière séquentielle (1, 2, 3...).

Quel est le rôle de UNIQUE sur nom ?

Il interdit l'insertion de deux catégories portant exactement le même nom, évitant ainsi les doublons dans la table categories.

Quel est le rôle de CHECK (prix >= 0) ?

C'est une règle de validation (contrainte) qui empêche d'insérer ou de modifier un produit avec un prix négatif.

Que signifie ON DELETE RESTRICT ?

Cela empêche la suppression d'une catégorie si des produits y sont encore rattachés, protégeant ainsi l'intégrité des relations de la base.

Q1.8.
SQLite gère des verrous d'accès et des fichiers journaux (-wal, -shm). Si DB Browser garde le fichier ouvert en mode exclusif ou maintient une transaction active, une autre application (comme votre appli Flutter) se verra refuser l'accès en écriture, ce qui provoquera un blocage ou une exception dans l'application.

Q2.1.
sqflite : Le package Flutter standard pour interagir avec des bases de données SQLite sur mobile (Android/iOS).

path : Un package utilitaire indispensable pour manipuler et joindre des chemins de fichiers de manière sécurisée (cross-platform).

sqflite_common_ffi : Permet d'exécuter SQLite via l'interface FFI (Foreign Function Interface), ce qui est obligatoire pour faire tourner SQLite sur un bureau desktop (Windows ou Linux).

Q2.3
Pourquoi id est-il de type int? (nullable) ?
Parce qu'avant qu'une catégorie ne soit insérée dans la base de données, elle n'a pas encore reçu son id auto-incrémenté par SQLite. L'objet Dart est créé en mémoire avec un id à null.

Pourquoi toMap() n'ajoute-t-il id que s'il n'est pas null ?
Parce que lors d'un nouvel enregistrement (INSERT), c'est SQLite qui doit générer automatiquement l'id grâce à AUTOINCREMENT. Si on envoyait explicitement un id à null, cela pourrait entrer en conflit avec la génération automatique de la base.