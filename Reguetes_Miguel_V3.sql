use Pokemon2;

-- S�lectionnez les colonnes Nom_Pokemon, Type_1, Type_2, et Nom_region pour les Pok�mon appartenant � la r�gion de Kanto
SELECT p.Nom_Pokemon, p.Type_1, p.Type_2, g.Nom_region
FROM Pokemon p
JOIN Generations g ON p.Gen_number = g.Gen_number
WHERE g.Nom_region = 'Kanto';


-- S�lectionnez le nom et le type de tous les Pok�mon ainsi que le nombre de champions qui les poss�dent :
SELECT Pokemon.Nom_Pokemon, Pokemon.Type_1, Pokemon.Type_2, COUNT(DISTINCT Champions.id_champion) AS Nb_champions
FROM Pokemon
JOIN Generations ON Pokemon.Gen_number = Generations.Gen_number
JOIN Champions ON Generations.id_champion = Champions.id_champion
GROUP BY Pokemon.Nom_Pokemon, Pokemon.Type_1, Pokemon.Type_2

-- S�lectionnez les 5 premiers champions avec une capacit� de type "Electric"
SELECT TOP 5
    c.Nom AS Champion,
    p.Nom_Pokemon AS Pokemon,
    ca.Nom AS Capacite,
    ca.Type_cap AS Type
FROM Champions c
JOIN Pokemon_Dresseur pd ON c.id_champion = pd.id_dresseur
JOIN Pokemon p ON pd.Pokemon_number = p.Pokemon_number
JOIN Pokemon_Capacite pc ON p.Pokemon_number = pc.Pokemon_number
JOIN Capacite ca ON pc.id_capacite = ca.id_capacite
WHERE ca.Type_cap = 'Electric';

-- S�lectionnez les colonnes Dresseur, Type_1 et Type_2 des dresseurs qui ont des Pok�mon de type 'Fire' ou 'Water' dans leur �quipe.
SELECT DISTINCT
    d.Nom AS Dresseur,
    p.Type_1,
    p.Type_2
FROM Dresseur d
JOIN Pokemon_Dresseur pd ON d.id_dresseur = pd.id_dresseur
JOIN Pokemon p ON pd.Pokemon_number = p.Pokemon_number
WHERE p.Type_1 IN ('Fire', 'Water') OR p.Type_2 IN ('Fire', 'Water');


-- S�lectionnez les Pok�mon avec une capacit� de puissance entre 50 et 70
SELECT
    p.Nom_Pokemon AS Pokemon,
    ca.Nom AS Capacite,
    ca.Power_cap AS Puissance
FROM Pokemon p
JOIN Pokemon_Capacite pc ON p.Pokemon_number = pc.Pokemon_number
JOIN Capacite ca ON pc.id_capacite = ca.id_capacite
WHERE ca.Power_cap BETWEEN 50 AND 70;

-- S�lectionnez les dresseurs et leurs Pok�mon ayant une capacit� avec "Charge" dans le nom:
SELECT
    d.Nom AS Dresseur,
    p.Nom_Pokemon AS Pokemon,
    ca.Nom AS Capacite
FROM Dresseur d
JOIN Pokemon_Dresseur pd ON d.id_dresseur = pd.id_dresseur
JOIN Pokemon p ON pd.Pokemon_number = p.Pokemon_number
JOIN Pokemon_Capacite pc ON p.Pokemon_number = pc.Pokemon_number
JOIN Capacite ca ON pc.id_capacite = ca.id_capacite
WHERE ca.Nom LIKE '%Charge%';


-- S�lectionnez le nombre de Pok�mon par type principal, en ayant au moins 2 Pok�mon de ce type:
SELECT
    p.Type_1 AS Type,
    COUNT(*) AS Nombre_Pokemon
FROM Pokemon p
GROUP BY p.Type_1
HAVING COUNT(*) >= 2;

--a) Liste des capacit�s qui n'ont pas �t� apprises par un Pok�mon :
SELECT Capacite.Nom AS Capacite_Nom
FROM Capacite
WHERE NOT EXISTS (SELECT * FROM Pokemon_Capacite WHERE Capacite.id_capacite = Pokemon_Capacite.id_capacite);
GO

--b) affiche la liste des Pok�mon et les capacit�s qu'ils ont apprises en joignant les tables Pokemon, Pokemon_Capacite et Capacite
SELECT p.Nom_Pokemon, c.Nom AS Capacite_Nom
FROM Pokemon p
JOIN Pokemon_Capacite pc ON p.Pokemon_number = pc.Pokemon_number
JOIN Capacite c ON pc.id_capacite = c.id_capacite;

