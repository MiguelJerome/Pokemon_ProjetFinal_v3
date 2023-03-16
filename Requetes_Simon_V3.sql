--WHERE
SELECT * FROM Generations
WHERE Gen_number >= 6

--TOP
SELECT TOP(3) * FROM Capacite
WHERE Power_cap >= 50
ORDER BY Power_cap DESC

--LIKE
SELECT * FROM Champions
WHERE Nom LIKE '_____' --5 lettre

--OR
SELECT Nom_Pokemon FROM Pokemon
WHERE Type_1 = 'electric' OR Type_1 = 'water'

--AND
SELECT * FROM Dresseur
WHERE Gen_number = 1 AND Gender = 'female'

--IN
SELECT * FROM Pokemon
WHERE Type_1 IN ('water')

--EXISTS
SELECT * FROM Generations
WHERE EXISTS (SELECT * FROM Generations WHERE Gen_number < 5);

--GROUP BY
SELECT SUM(HP) AS HP_total, Type_1 FROM Pokemon
GROUP BY Type_1

--HAVING
SELECT COUNT(Power_cap) AS Capacite_total, Category, SUM(Power_cap) AS Attaque_total_de_la_capacite
FROM Capacite
GROUP BY Category
HAVING SUM(Power_cap) > 100
ORDER BY Attaque_total_de_la_capacite ASC

--BETWEEN
SELECT Nom, Power_cap, Accuracy, PP, Category, Type_cap FROM Capacite
WHERE PP BETWEEN '10' AND '20'
ORDER BY PP ASC