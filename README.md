# miaged

# Projet développement mobile

## Réalisation d'une application de vente simiaire à vinted

## Compte rendu réalisation et mode d'emploi

### Travail réalisé

Au fur et à mesure des séances, j'ai pu développé l'application suivante en fonction des US et leurs critères d'acceptance. Ce sont près de 99% des critères demandés qui ont été respectés avec brio. L'interface de login, la liste de vêtement, le détail du vêtement, le profil utilisateur et le filtre sur la liste répondent à tous les critères d'acceptance donnés.

### Travail manquant Une petite partie d'un critère concernant le panier n'a pu être respecté :
La supression d'un article ne se fait que sur la partie front, mais celui ci est concervé dans le panier du client. Une fois que l'utilisateur recharge la page du panier, les atricles réapparaissent. En revanche, le prix se met bien à jour e fonction du panier.

Travail suplémentaire réalisé
En plus des Users Story de base, des fonctionnalités suplémentaires ont étés implémenter :

Pour l'interface de login:
- L'utilisater peut s'inscrire et créer un nouveau compte
- Une fois inscrit, l'utilisateur doit nécesairement confirmer son adresse mail afin de confirmer l'ouverture de son compte.
- Une foi le mail validé l'utilisater peut donc se connecter.
Pour le panier
- Chaque utilisatur dispose de son propre clavier; < /ol>

# Fonctionnement:

Afin de faire fonctionner le projet, voici la liste des demarches:
S'inscrire afin de pouvoir se valider son mail et accéde au magasin,
Lors d'un achat ont peut choisir entre tous les articles, ceux d'étés ou ceux d'hiver.
On peut ajouter des produit à notre panier ce qui augmente sa quantité dans notre panier.
Et enfin on pet consulter notre panier ou l'on peut supprimer nos articles.
On peut également modifier son profil, enregistrer les novelles informations, se déconnecter, changer de compte, notre panier sera correctemment conservé.

## Points bloquant J'ai essentiellement rencontré 3 dificultés au cours de se projet :

Tout d'abord de bloquage a démarage de l'application en essayant d'utilier Chrome
De difficultés à récupérés correctemment les informations de mon panier notamment, ou encore ajouter une clé étrangère dans firestore alors que ça fonctionne par documents.
Et enfin mettre à jour l'affichage de mon panier, e chargais ma ilste correctemment mais je ne sais pa pourquoi je n'arrivais pas à l'afficher mais j'ai pu trouver la fonction à appeller qui correspond au 'hot reload' de l'ordinateur et résoudre ce problème
## Points d'amelioration Mon code à pu correctement être factoé en créant par enxemple ne classe 'Commun' dans laquelle j'ai pu mettre la bar de navigation notamment afin d'avoir à éviter de rappeller le même code dans chaque onglets.
En revanche j'aurai pu faire de même pour les produits et leurs filtrage mais un peu pris par le temps je n'ai pu mettre à jour correctemment cette partie.
