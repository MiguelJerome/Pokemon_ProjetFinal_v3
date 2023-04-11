-- Projet 2: 20% de la note globale
-- 1.	Utilisez votre base de données créée lors du projet 1
-- 2.	Creation des tables et insertion des données avec une procédure stockée
USE Pokemon3;
GO

-- Création de la procédure stockée
CREATE OR ALTER PROCEDURE CreateProjet2DatabaseAndTables
    @Nom_du_jeu NVARCHAR(50),
    @Nom_Pokemon NVARCHAR(50),
    @Nom NVARCHAR(50),
    @Team_type NVARCHAR(50),
    @Nom_region NVARCHAR(50),
    @Lev_unlock NVARCHAR(50),
    @Power_cap NVARCHAR(50),
    @Accuracy NVARCHAR(50),
    @PP NVARCHAR(50),
    @Category NVARCHAR(50),
    @Type_cap NVARCHAR(50),
    @Gen_number NVARCHAR(50),
    @Pokemon_number NVARCHAR(50),
    @id_champion NVARCHAR(50),
    @id_pokedex NVARCHAR(50),
    @Type_1 NVARCHAR(50),
    @Type_2 NVARCHAR(50),
    @HP NVARCHAR(50),
    @Attack NVARCHAR(50),
    @Defense NVARCHAR(50),
    @Sp_Attack NVARCHAR(50),
    @Sp_Defense NVARCHAR(50),
    @Speed NVARCHAR(50),
    @Gender NVARCHAR(50),
    @Team_size NVARCHAR(50),
    @id_dresseur NVARCHAR(50),
    @Pokemon_level NVARCHAR(50),
    @id_capacite NVARCHAR(50),
    @Level NVARCHAR(50)
AS
BEGIN
        DECLARE @DatabaseName NVARCHAR(50) = 'Pokemon3',
                @PokedexTableName NVARCHAR(50) = 'Pokedex',
                @PokemonTableName NVARCHAR(50) = 'Pokemon',
                @PokemonPokedexTableName NVARCHAR(50) = 'Pokemon_Pokedex',
                @ChampionsTableName NVARCHAR(50) = 'Champions',
                @CapaciteTableName NVARCHAR(50) = 'Capacite',
                @GenerationsTableName NVARCHAR(50) = 'Generations',
                @DresseurTableName NVARCHAR(50) = 'Dresseur',
                @PokemonDresseurTableName NVARCHAR(50) = 'Pokemon_Dresseur',
                @PokemonCapaciteTableName NVARCHAR(50) = 'Pokemon_Capacite',
                @DresseurGenerationTableName NVARCHAR(50) = 'DresseurGeneration',
                @PokedexTableSQL NVARCHAR(MAX),
                @PokemonTableSQL NVARCHAR(MAX),
                @PokemonPokedexTableSQL NVARCHAR(MAX),
                @ChampionsTableSQL NVARCHAR(MAX),
                @CapaciteTableSQL NVARCHAR(MAX),
                @GenerationsTableSQL NVARCHAR(MAX),
                @DresseurTableSQL NVARCHAR(MAX),
                @PokemonDresseurTableSQL NVARCHAR(MAX),
                @PokemonCapaciteTableSQL NVARCHAR(MAX),
                @DresseurGenerationTableSQL NVARCHAR(MAX),
                @sql NVARCHAR(MAX);

        SET @sql = 'IF DB_ID(''' + @DatabaseName + ''') IS NULL
        BEGIN
            CREATE DATABASE ' + QUOTENAME(@DatabaseName) + ';
        END';

        EXEC sp_executesql @sql;

        SET @sql = 'IF DB_ID(''' + @DatabaseName + ''') IS NULL
        BEGIN
            CREATE DATABASE ' + QUOTENAME(@DatabaseName) + ';
        END';

        EXEC sp_executesql @sql;

        IF OBJECT_ID(@PokedexTableName, 'U') IS NULL
        BEGIN
            SET @PokedexTableSQL = '
            CREATE TABLE ' + QUOTENAME(@PokedexTableName) + ' (
                id_pokedex INT IDENTITY(1,1) PRIMARY KEY,
                ' + QUOTENAME(@Nom_du_jeu) + ' NVARCHAR(255) NOT NULL,
                ' + QUOTENAME(@Pokemon_number) + ' INT NOT NULL,
                CONSTRAINT UC_Pokedex UNIQUE (id_pokedex),
                CONSTRAINT CK_PokemonNumber CHECK (' + QUOTENAME(@Pokemon_number) + ' > 0)
            );';
            SET @PokedexTableSQL = N'USE ' + QUOTENAME(@DatabaseName) + N'; ' + @PokedexTableSQL;
            EXEC sp_executesql @PokedexTableSQL;
        END

        IF OBJECT_ID(@ChampionsTableName, 'U') IS NULL
        BEGIN
            SET @ChampionsTableSQL = '
            CREATE TABLE ' + QUOTENAME(@ChampionsTableName) + ' (
                id_champion INT IDENTITY(1,1) PRIMARY KEY,
                ' + QUOTENAME(@Nom) + ' NVARCHAR(50) NOT NULL,
                ' + QUOTENAME(@Team_type) + ' NVARCHAR(50) NOT NULL,
                ' + QUOTENAME(@id_pokedex) + ' INT NOT NULL,
                ' + QUOTENAME(@Nom_region) + ' NVARCHAR(50) NOT NULL,
                CONSTRAINT UC_Champions UNIQUE (id_champion),
                CONSTRAINT FK_Champions_id_pokedex FOREIGN KEY (id_pokedex) REFERENCES ' + QUOTENAME(@PokedexTableName) + ' (id_pokedex)
            );';
            SET @ChampionsTableSQL = N'USE ' + QUOTENAME(@DatabaseName) + N'; ' + @ChampionsTableSQL;
            EXEC sp_executesql @ChampionsTableSQL;
        END


    IF OBJECT_ID(@CapaciteTableName, 'U') IS NULL
    BEGIN
        SET @CapaciteTableSQL = '
        CREATE TABLE ' + QUOTENAME(@CapaciteTableName) + ' (
            id_capacite INT IDENTITY(1,1) PRIMARY KEY,
            ' + QUOTENAME(@Nom) + ' NVARCHAR(50) NOT NULL,
            ' + QUOTENAME(@Lev_unlock) + ' INT NOT NULL CHECK (' + QUOTENAME(@Lev_unlock) + ' >= 0),
            ' + QUOTENAME(@Power_cap) + ' INT CHECK (' + QUOTENAME(@Power_cap) + ' >= 0),
            ' + QUOTENAME(@Accuracy) + ' INT CHECK (' + QUOTENAME(@Accuracy) + ' >= 0 AND ' + QUOTENAME(@Accuracy) + ' <= 100),
            ' + QUOTENAME(@PP) + ' INT NOT NULL CHECK (' + QUOTENAME(@PP) + ' >= 0),
            ' + QUOTENAME(@Category) + ' NVARCHAR(20) NOT NULL,
            ' + QUOTENAME(@Type_cap) + ' NVARCHAR(20) NOT NULL,
            CONSTRAINT UC_Capacite UNIQUE (id_capacite),
            CONSTRAINT UC_Nom UNIQUE (' + QUOTENAME(@Nom) + ')
        );';
        SET @CapaciteTableSQL = N'USE ' + QUOTENAME(@DatabaseName) + N'; ' + @CapaciteTableSQL;
        EXEC sp_executesql @CapaciteTableSQL;
    END


    IF OBJECT_ID(@GenerationsTableName, 'U') IS NULL
    BEGIN
        SET @GenerationsTableSQL = '
        CREATE TABLE ' + QUOTENAME(@GenerationsTableName) + ' (
            Gen_number INT IDENTITY(1,1) PRIMARY KEY,
            ' + QUOTENAME(@Nom_region) + ' NVARCHAR(50) NOT NULL,
            ' + QUOTENAME(@id_champion) + ' INT NOT NULL,
            CONSTRAINT UC_Generations UNIQUE (Gen_number),
            CONSTRAINT FK_Generations_id_champion FOREIGN KEY (' + QUOTENAME(@id_champion) + ') REFERENCES ' + QUOTENAME(@ChampionsTableName) + ' (' + QUOTENAME(@id_champion) + ')
        );';
        SET @GenerationsTableSQL = N'USE ' + QUOTENAME(@DatabaseName) + N'; ' + @GenerationsTableSQL;
        EXEC sp_executesql @GenerationsTableSQL;
    END


    IF OBJECT_ID(@PokemonTableName, 'U') IS NULL
    BEGIN
        SET @PokemonTableSQL = '
        CREATE TABLE ' + QUOTENAME(@PokemonTableName) + ' (
            Pokemon_number INT IDENTITY(1,1) PRIMARY KEY,
            ' + QUOTENAME(@Nom_Pokemon) + ' NVARCHAR(255) NOT NULL,
            ' + QUOTENAME(@Type_1) + ' NVARCHAR(20) NOT NULL,
            ' + QUOTENAME(@Type_2) + ' NVARCHAR(20),
            ' + QUOTENAME(@Gen_number) + ' INT NOT NULL,
            ' + QUOTENAME(@HP) + ' INT NOT NULL CHECK (' + QUOTENAME(@HP) + ' > 0),
            ' + QUOTENAME(@Attack) + ' INT NOT NULL CHECK (' + QUOTENAME(@Attack) + ' > 0),
            ' + QUOTENAME(@Defense) + ' INT NOT NULL CHECK (' + QUOTENAME(@Defense) + ' > 0),
            ' + QUOTENAME(@Sp_Attack) + ' INT NOT NULL CHECK (' + QUOTENAME(@Sp_Attack) + ' > 0),
            ' + QUOTENAME(@Sp_Defense) + ' INT NOT NULL CHECK (' + QUOTENAME(@Sp_Defense) + ' > 0),
            ' + QUOTENAME(@Speed) + ' INT NOT NULL CHECK (' + QUOTENAME(@Speed) + ' > 0),
            CONSTRAINT UC_Pokemon UNIQUE (Pokemon_number),
            CONSTRAINT FK_Pokemon_Gen_number FOREIGN KEY (' + QUOTENAME(@Gen_number) + ') REFERENCES ' + QUOTENAME(@GenerationsTableName) + ' (' + QUOTENAME(@Gen_number) + ')
        );';
        SET @PokemonTableSQL = N'USE ' + QUOTENAME(@DatabaseName) + N'; ' + @PokemonTableSQL;
        EXEC sp_executesql @PokemonTableSQL;
    END


    IF OBJECT_ID(@DresseurTableName, 'U') IS NULL
    BEGIN
        SET @DresseurTableSQL = '
        CREATE TABLE ' + QUOTENAME(@DresseurTableName) + ' (
            id_dresseur INT IDENTITY(1,1) PRIMARY KEY,
            ' + QUOTENAME(@Nom) + ' NVARCHAR(50) NOT NULL,
            ' + QUOTENAME(@Gen_number) + ' INT NOT NULL,
            ' + QUOTENAME(@Gender) + ' NVARCHAR(10) NOT NULL,
            ' + QUOTENAME(@Team_size) + ' TINYINT NOT NULL CHECK (' + QUOTENAME(@Team_size) + ' BETWEEN 1 AND 6), /*Max 6*/
            CONSTRAINT UC_Dresseur UNIQUE (id_dresseur),
            CONSTRAINT FK_Dresseur_id_champion FOREIGN KEY (id_dresseur) REFERENCES ' + QUOTENAME(@ChampionsTableName) + ' (id_champion),
            CONSTRAINT FK_Dresseur_Gen_number FOREIGN KEY (' + QUOTENAME(@Gen_number) + ') REFERENCES ' + QUOTENAME(@GenerationsTableName) + ' (Gen_number)
        );';
        SET @DresseurTableSQL = N'USE ' + QUOTENAME(@DatabaseName) + N'; ' + @DresseurTableSQL;
        EXEC sp_executesql @DresseurTableSQL;
    END


        IF OBJECT_ID(@PokemonDresseurTableName, 'U') IS NULL
    BEGIN
        SET @PokemonDresseurTableSQL = '
        CREATE TABLE ' + QUOTENAME(@PokemonDresseurTableName) + ' (
            id INT IDENTITY(1,1) PRIMARY KEY,
            ' + QUOTENAME(@id_dresseur) + ' INT NOT NULL,
            ' + QUOTENAME(@Pokemon_number) + ' INT NOT NULL,
            ' + QUOTENAME(@Pokemon_level) + ' TINYINT NOT NULL CHECK (' + QUOTENAME(@Pokemon_level) + ' BETWEEN 1 AND 100),
            CONSTRAINT UC_PokemonDresseur UNIQUE (' + QUOTENAME(@id_dresseur) + ', ' + QUOTENAME(@Pokemon_number) + '),
            CONSTRAINT FK_PokemonDresseur_Pokemon_number FOREIGN KEY (' + QUOTENAME(@Pokemon_number) + ') REFERENCES ' + QUOTENAME(@PokemonTableName) + ' (Pokemon_number),
            CONSTRAINT FK_PokemonDresseur_id_dresseur FOREIGN KEY (' + QUOTENAME(@id_dresseur) + ') REFERENCES ' + QUOTENAME(@DresseurTableName) + ' (id_dresseur)
        );';
        SET @PokemonDresseurTableSQL = N'USE ' + QUOTENAME(@DatabaseName) + N'; ' + @PokemonDresseurTableSQL;
        EXEC sp_executesql @PokemonDresseurTableSQL;
    END


    IF OBJECT_ID(@PokemonCapaciteTableName, 'U') IS NULL
    BEGIN
        SET @PokemonCapaciteTableSQL = '
        CREATE TABLE ' + QUOTENAME(@PokemonCapaciteTableName) + ' (
            id INT IDENTITY(1,1) PRIMARY KEY,
            ' + QUOTENAME(@Pokemon_number) + ' INT NOT NULL,
            ' + QUOTENAME(@Nom) + ' NVARCHAR(50) NOT NULL,
            ' + QUOTENAME(@Level) + ' INT NOT NULL CHECK (' + QUOTENAME(@Level) + ' BETWEEN 1 AND 100),
            ' + QUOTENAME(@id_capacite) + ' INT NOT NULL,
            CONSTRAINT UC_PokemonCapacite UNIQUE (' + QUOTENAME(@Pokemon_number) + ', ' + QUOTENAME(@id_capacite) + '),
            CONSTRAINT FK_PokemonCapacite_Pokemon_number FOREIGN KEY (' + QUOTENAME(@Pokemon_number) + ') REFERENCES ' + QUOTENAME(@PokemonTableName) + ' (Pokemon_number),
            CONSTRAINT FK_PokemonCapacite_id_capacite FOREIGN KEY (' + QUOTENAME(@id_capacite) + ') REFERENCES ' + QUOTENAME(@CapaciteTableName) + ' (id_capacite)
        );';
        SET @PokemonCapaciteTableSQL = N'USE ' + QUOTENAME(@DatabaseName) + N'; ' + @PokemonCapaciteTableSQL;
        EXEC sp_executesql @PokemonCapaciteTableSQL;
    END


    IF OBJECT_ID(@DresseurGenerationTableName, 'U') IS NULL
    BEGIN
        SET @DresseurGenerationTableSQL = '
        CREATE TABLE ' + QUOTENAME(@DresseurGenerationTableName) + ' (
            id INT IDENTITY(1,1) PRIMARY KEY,
            ' + QUOTENAME(@Gen_number) + ' INT NOT NULL,
            ' + QUOTENAME(@id_dresseur) + ' INT NOT NULL,
            CONSTRAINT UC_DresseurGeneration UNIQUE (' + QUOTENAME(@Gen_number) + ', ' + QUOTENAME(@id_dresseur) + '),
            CONSTRAINT FK_DresseurGeneration_id_dresseur FOREIGN KEY (' + QUOTENAME(@id_dresseur) + ') REFERENCES ' + QUOTENAME(@DresseurTableName) + ' (id_dresseur),
            CONSTRAINT FK_DresseurGeneration_Gen_number FOREIGN KEY (' + QUOTENAME(@Gen_number) + ') REFERENCES ' + QUOTENAME(@GenerationsTableName) + ' (Gen_number)
        );';
        SET @DresseurGenerationTableSQL = N'USE ' + QUOTENAME(@DatabaseName) + N'; ' + @DresseurGenerationTableSQL;
        EXEC sp_executesql @DresseurGenerationTableSQL;
    END


    IF OBJECT_ID(@PokemonPokedexTableName, 'U') IS NULL
    BEGIN
        SET @PokemonPokedexTableSQL = '
        CREATE TABLE ' + QUOTENAME(@PokemonPokedexTableName) + ' (
            id INT IDENTITY(1,1) PRIMARY KEY,
            ' + QUOTENAME(@Pokemon_number) + ' INT NOT NULL,
            ' + QUOTENAME(@id_pokedex) + ' INT NOT NULL,
            CONSTRAINT UC_Pokemon_Pokedex UNIQUE (' + QUOTENAME(@Pokemon_number) + ', ' + QUOTENAME(@id_pokedex) + '),
            CONSTRAINT FK_PokemonPokedex_Pokemon_number FOREIGN KEY (' + QUOTENAME(@Pokemon_number) + ') REFERENCES ' + QUOTENAME(@PokemonTableName) + ' (Pokemon_number),
            CONSTRAINT FK_PokemonPokedex_id_pokedex FOREIGN KEY (' + QUOTENAME(@id_pokedex) + ') REFERENCES ' + QUOTENAME(@PokedexTableName) + ' (id_pokedex)
        );';
        SET @PokemonPokedexTableSQL = N'USE ' + QUOTENAME(@DatabaseName) + N'; ' + @PokemonPokedexTableSQL;
        EXEC sp_executesql @PokemonPokedexTableSQL;
    END

END;
GO

EXEC CreateProjet2DatabaseAndTables
    'Nom_du_jeu',
    'Nom_Pokemon',
    'Nom',
    'Team_type',
    'Nom_region',
    'Lev_unlock',
    'Power_cap',
    'Accuracy',
    'PP',
    'Category',
    'Type_cap',
    'Gen_number',
    'Pokemon_number',
    'id_champion',
    'id_pokedex',
    'Type_1',
    'Type_2',
    'HP',
    'Attack',
    'Defense',
    'Sp_Attack',
    'Sp_Defense',
    'Speed',
    'Gender',
    'Team_size',
    'id_dresseur',
    'Pokemon_level',
    'id_capacite',
    'Level';

    -- 3.	Un même enregistrement (données) ne doit pas être insérer deux fois
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



-- Insertion dummy data
INSERT INTO Capacite (Nom, Lev_unlock, Power_cap, Accuracy, PP, Category, Type_cap)
VALUES
('Eclair', 1, 40, 100, 35, 'Physical', 'Normal'),
('Jet-Pierres', 5, 40, 100, 25, 'Special', 'Fire'),
('Flammeche', 9, 45, 100, 25, 'Physical', 'Grass');
Go
EXEC InsertDataIntoCapaciteTable 'Tranche', 20, 70, 100, 20, 'Physique', 'Normal';
GO
EXEC InsertDataIntoCapaciteTable 'Mach Punch', 25, 40, 100, 30, 'Physique', 'Combat';
GO
-- Sélectionner les données de la table Capacite pour vérifier les enregistrements
SELECT * FROM Capacite;

-- 4.	Mettre dans une vue les résultats de selection d'une table (au choix) de votre base de données 
USE Pokemon3;
GO

DECLARE @CreateViewSQL NVARCHAR(MAX);
DECLARE @CapaciteTableName NVARCHAR(128) = 'Capacite'; 

IF OBJECT_ID('CapaciteView', 'V') IS NULL
BEGIN
    SET @CreateViewSQL = '
    CREATE VIEW CapaciteView
    AS
        SELECT
            id_capacite,
            Nom,
            Lev_unlock,
            Power_cap,
            Accuracy,
            PP,
            Category,
            Type_cap
        FROM ' + QUOTENAME(@CapaciteTableName) + ';
    ';

    EXEC sp_executesql @CreateViewSQL;
END


USE Pokemon3;
GO

SELECT *
FROM CapaciteView;
