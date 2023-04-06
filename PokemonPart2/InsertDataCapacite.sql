USE Pokemon3;
GO

-- Création de la procédure stockée
CREATE OR ALTER PROCEDURE InsertDataIntoCapaciteTable
    @Nom NVARCHAR(15),
    @Lev_unlock INT,
    @Power_cap INT,
    @Accuracy INT,
    @PP INT,
    @Category NVARCHAR(12),
    @Type_cap NVARCHAR(8)
AS
BEGIN
    -- Vérifier si l'enregistrement existe déjà dans la table Capacite
    IF NOT EXISTS (SELECT 1 FROM Capacite WHERE Nom = @Nom AND Lev_unlock = @Lev_unlock)
    BEGIN
        -- Insertion des données dans la table Capacite
        INSERT INTO Capacite (Nom, Lev_unlock, Power_cap, Accuracy, PP, Category, Type_cap)
        VALUES (@Nom, @Lev_unlock, @Power_cap, @Accuracy, @PP, @Category, @Type_cap);
    END
    ELSE
    BEGIN
        PRINT 'L''enregistrement existe déjà dans la table Capacite.';
    END
END;
GO

-- Exemples de données
EXEC InsertDataIntoCapaciteTable 'Charge', 1, 50, 100, 35, 'Physique', 'Normal';
GO
EXEC InsertDataIntoCapaciteTable 'Vive-Attaque', 15, 40, 100, 30, 'Physique', 'Normal';
GO
EXEC InsertDataIntoCapaciteTable 'Flammeche', 5, 40, 100, 25, 'Spécial', 'Feu';
GO
EXEC InsertDataIntoCapaciteTable 'Pistolet à O', 10, 40, 100, 25, 'Spécial', 'Eau';
GO
EXEC InsertDataIntoCapaciteTable 'Eclair', 5, 40, 100, 30, 'Spécial', 'Electrik';
GO
EXEC InsertDataIntoCapaciteTable 'Jet-Pierres', 5, 50, 90, 15, 'Physique', 'Roche';
GO
EXEC InsertDataIntoCapaciteTable 'Tranche', 20, 70, 100, 20, 'Physique', 'Normal';
GO
EXEC InsertDataIntoCapaciteTable 'Mach Punch', 25, 40, 100, 30, 'Physique', 'Combat';
GO
-- Sélectionner les données de la table Capacite pour vérifier les enregistrements
SELECT * FROM Capacite;