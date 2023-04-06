USE Pokemon3;
GO

-- Création de la procédure stockée
CREATE OR ALTER PROCEDURE InsertDataIntoPokedex
    @Nom_du_jeu NVARCHAR(50),
    @Pokemon_number INT
AS
BEGIN
    -- Vérification si l'enregistrement existe déjà dans la table Pokedex
    IF NOT EXISTS (SELECT 1 FROM Pokedex WHERE Nom_du_jeu = @Nom_du_jeu AND Pokemon_number = @Pokemon_number)
    BEGIN
        -- Insertion des données dans la table Pokedex
        INSERT INTO Pokedex (Nom_du_jeu, Pokemon_number)
        VALUES (@Nom_du_jeu, @Pokemon_number);
    END
    ELSE
    BEGIN
        PRINT 'L''enregistrement existe déjà dans la table Pokedex.';
    END
END;
GO

-- Exécuter la procédure stockée pour insérer des données
EXEC InsertDataIntoPokedex 'Nom_du_jeu1', 1;
GO
EXEC InsertDataIntoPokedex 'Nom_du_jeu2', 2;
GO

-- Exécuter à nouveau la procédure stockée pour insérer des données
EXEC InsertDataIntoPokedex 'Nom_du_jeu1', 1;
GO
EXEC InsertDataIntoPokedex 'Nom_du_jeu2', 2;
GO
EXEC InsertDataIntoPokedex 'Nom_du_jeu3', 3;
GO

-- Sélectionner les données de la table Pokedex pour vérifier les enregistrements
SELECT * FROM Pokedex;

