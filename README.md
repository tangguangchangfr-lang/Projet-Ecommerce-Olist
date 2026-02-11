# 📦 Performance Supply & Livraison – Olist  

## 🎯 Contexte et Objectif du projet
Olist est une plateforme brésilienne reliant des milliers de vendeurs à des clients via une marketplace unique. La performance logistique et la satisfaction client sont des enjeux stratégiques :  
Les retards de livraison impactent directement les mauvaises notes clients.  
Ce projet vise à analyser la performance logistique et son impact sur satisfaction client sur la marketplace Olist, en exploitant un jeu de données e-commerce réel.  
---

## 🧠 Analyse descriptive (Data Analyst)

### Approche en 3 parties
- Analyse globale de la satisfaction client  
- Performance logistique, vendeurs et produits
- Synthèse & recommandations business 

---

## 🧱 Données utilisées
Les données proviennent du **dataset public Olist** disponible sur Kaggle.  
Elles sont réparties en plusieurs tables reliées par `order_id` et `customer_id` :

| Fichier | Description |
|----------|-------------|
| `olist_orders_dataset.csv` | Détails des commandes (dates, statuts, délais estimés) |
| `olist_order_items_dataset.csv` | Articles commandés (produits, vendeurs, prix, transport) |
| `olist_customers_dataset.csv` | Informations clients (identifiants, localisation) |
| `olist_sellers_dataset.csv` | Données des vendeurs (localisation, ID) |
| `olist_order_reviews_dataset.csv` | Avis clients (note, commentaire, timestamp) |
| `olist_products_dataset.csv` | Caractéristiques des produits |
| `olist_order_payments_dataset.csv` | Méthodes et montants des paiements |
| `olist_geolocation_dataset.csv` | Coordonnées géographiques (lat/lon) |
| `product_category_name_translation.csv` | Traduction des catégories produits |

---

## 🧮 Méthodologie du projet

### 🩵 Étape 1 — Cadrage & exploration
- Lecture et compréhension des données.  
- Définition des KPI logistiques et satisfaction.  
- Vérification de la qualité et cohérence des données.

### 💽 Étape 2 — Préparation & fusion des datasets
- Nettoyage, jointures (`orders`, `order_items`, `sellers`, `customers`).  
- Création des variables : délais, retards, distance client–vendeur.  

### 📊 Étape 3 — Analyse descriptive
- Analyse des délais moyens par vendeur, produit et région.  
- Corrélation délai ↔ satisfaction (`review_score`).  
- Visualisations : histogrammes, heatmaps, cartes.  
- Dashboard Power BI :  
  - Page 1 : vue d'ensemble sur la satisfaction client  
  - Page 2 : Logistique 
  - Page 3 : Vendeurs
  - Page 4 : Produits

### 🧾 Étape 4 — Synthèse & recommandations
- Logistique: Alerte à J+2, Communication proactive + geste commercial 
- Vendeurs: Score multicritères, Bonus / Malus / accompagnement ciblé
- Produits: Audit & déréférencement temporaire, Ajustement des délais affichés

---

## 🔍 Key Insights
1. Croissance déséquilibrée entre volume et retards.
Entre 2017 et 2018, le volume de commandes a augmenté de +21,6 %, le taux de retard a augmenté de +36,4 %
👉 La croissance logistique n’a pas suivi la croissance commerciale, indiquant un risque structurel dans la capacité opérationnelle.
2. Impact critique du délai sur la satisfaction.
Lorsque le retard dépasse 2 jours,le taux de mauvaises notes (>50 %) explose.
👉 Le seuil de 2 jours constitue un point critique opérationnel à surveiller.
3. Responsabilité principale des retards: 77,6 % des retards sont imputables au transporteur
👉 Le levier d’amélioration principal se situe côté logistique transport, plus que côté préparation vendeur.
4. Déséquilibre géographique des vendeurs: ~60 % des vendeurs sont concentrés à São Paulo. Ils génèrent plus de 70 % des commandes.
Leur taux d’insatisfaction est supérieur de +5 % à la moyenne. À l’inverse, les 5 régions suivantes présentent un taux d’insatisfaction inférieur à la moyenne.
👉 Forte dépendance à São Paulo avec un risque qualité concentré.
5. Concentration des vendeurs à risque: les vendeurs influents présentant Retards fréquents et forte insatisfaction client sont exclusivement situés à São Paulo.
👉 Une stratégie ciblée sur São Paulo pourrait réduire significativement l’insatisfaction globale.
---

## 🏗 Architecture Data

1. Nettoyage & préparation sous Python
2. Modélisation en schéma étoile (1 fact table + dimensions)
3. Intégration dans Power BI
4. Création des KPI et dashboards interactifs
---

## 🧰 Outils & technologies
- **Python** : Pandas, NumPy, Matplotlib, Seaborn
- **MySQL** : Modélisation en schéma étoile
- **Power BI** : DAX, visualisation interactive & storytelling  
- **Jupyter Notebook** : exploration et modélisation  
- **Git / GitHub** : versioning et documentation  

---

## 💡 Compétences démontrées
✅ Data cleaning & manipulation multi-tables  
✅ Calculs d’indicateurs logistiques & satisfaction  
✅ Création de dashboards interactifs   
✅ Storytelling data & restitution business  

---

## 🧑‍💻 Auteur
Projet réalisé dans le cadre d’une reconversion **Data Analyst**,  
avec une spécialisation en **analyse de données e-commerce**.  

> 🧭 Objectif : démontrer la capacité à relier analyse métier, modélisation et visualisation décisionnelle.
