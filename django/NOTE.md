ce fichier liste toutes les erreurs que j'ai rencontré en travaillant avec django

 - la fonction authenticate de django.contrib.auth ne marche pas avec les users qu'on ajoute via les fixtures parce que django encode les mdp, encodage qui n'est pas effectué avec les fixtures : workaround => https://stackoverflow.com/questions/8017204/users-in-initial-data-fixture créer des users via l'admin et dump les datas dans un fichier fixture
 en fait ça ne marche pas non plus, mdp toujours pas encodé : 
 solution finale : ouvrir le shell : 
 - make django/run/shell
 - from user_management.models import User
 - User.objects.create_user(email="test2@localhost", password="mdp")
 - active email through admin interface
 - dump data : make django/run/dump
 - filter data & select usermanagemnt data
 - load dumped data : make django/run/loaddata


 - guillaumeschaffer@yahoo.fr is not a valid email quand j'essaye de créer un user via shell j'ai pas ce problème quand je passe par postman je comprends pas trop pourquoi, suspission pb d'encodage encore une fois

 - quand j'essaye de créer un utilisateur on me dit que mon token est pas valide hors on devrait pas avoir à utiliser de token pour la route api/auth/register