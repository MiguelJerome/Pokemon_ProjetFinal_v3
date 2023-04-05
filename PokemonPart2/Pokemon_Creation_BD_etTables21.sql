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
            CREATE TABLE ' + @PokedexTableName + ' (
                id_pokedex INT IDENTITY(1,1) PRIMARY KEY,
                ' + QUOTENAME(@Nom_du_jeu) + ' NVARCHAR(255) NOT NULL,
                ' + QUOTENAME(@Pokemon_number) + ' INT NOT NULL,
                CONSTRAINT UC_Pokedex UNIQUE (id_pokedex)
            );';
            SET @PokedexTableSQL = N'USE ' + QUOTENAME(@DatabaseName) + N'; ' + @PokedexTableSQL;
            EXEC sp_executesql @PokedexTableSQL;
        END

            IF OBJECT_ID(@ChampionsTableName, 'U') IS NULL
        BEGIN
            SET @ChampionsTableSQL = '
            CREATE TABLE ' + @ChampionsTableName + ' (
                id_champion INT NOT NULL PRIMARY KEY IDENTITY(1,1),
            ' + QUOTENAME(@Nom) + ' NVARCHAR(15) NOT NULL,
                ' + QUOTENAME(@Team_type) + ' NVARCHAR(15) NOT NULL,
                ' + QUOTENAME(@id_pokedex) + 'INT NOT NULL,
                ' + QUOTENAME(@Nom_region) + ' NVARCHAR(8) NOT NULL,
                CONSTRAINT UC_Champions UNIQUE (id_champion),
                FOREIGN KEY(id_pokedex) REFERENCES ' + @PokedexTableName + '(id_pokedex)
            );';
            SET @ChampionsTableSQL = N'USE ' + QUOTENAME(@DatabaseName) + N'; ' + @ChampionsTableSQL;
            EXEC sp_executesql @ChampionsTableSQL;
        END

        IF OBJECT_ID(@CapaciteTableName, 'U') IS NULL
        BEGIN
            SET @CapaciteTableSQL = '
            CREATE TABLE ' + @CapaciteTableName + ' (
                id_capacite INT NOT NULL PRIMARY KEY IDENTITY(1,1),
                ' + QUOTENAME(@Nom) + ' NVARCHAR(15) NOT NULL,
                ' + QUOTENAME(@Lev_unlock) + ' INT NOT NULL,
                ' + QUOTENAME(@Power_cap) + ' INT,
                ' + QUOTENAME(@Accuracy) + ' INT,
                ' + QUOTENAME(@PP) + ' INT NOT NULL,
                ' + QUOTENAME(@Category) + ' NVARCHAR(12) NOT NULL,
                ' + QUOTENAME(@Type_cap) + ' NVARCHAR(8) NOT NULL,
                CONSTRAINT UC_Capacite UNIQUE (id_capacite)
            );';
            SET @CapaciteTableSQL = N'USE ' + QUOTENAME(@DatabaseName) + N'; ' + @CapaciteTableSQL;
            EXEC sp_executesql @CapaciteTableSQL;
        END

    IF OBJECT_ID(@GenerationsTableName, 'U') IS NULL
    BEGIN
        SET @GenerationsTableSQL = '
        CREATE TABLE ' + @GenerationsTableName + ' (
            Gen_number INT NOT NULL PRIMARY KEY IDENTITY(1,1),
            ' + QUOTENAME(@Nom_region) + ' NVARCHAR(8) NOT NULL,
            ' + QUOTENAME(@id_champion) + ' INT NOT NULL,
            CONSTRAINT UC_Generations UNIQUE (Gen_number),
            FOREIGN KEY(' + QUOTENAME(@id_champion) + ') REFERENCES ' + @ChampionsTableName + '(' + QUOTENAME(@id_champion) + ')
        )';
        SET @GenerationsTableSQL = N'USE ' + QUOTENAME(@DatabaseName) + N'; ' + @GenerationsTableSQL;
        EXEC sp_executesql @GenerationsTableSQL;
    END

    IF OBJECT_ID(@PokemonTableName, 'U') IS NULL
    BEGIN
        SET @PokemonTableSQL = '
        CREATE TABLE '+ QUOTENAME(@PokemonTableName) + ' (
            Pokemon_number INT NOT NULL PRIMARY KEY IDENTITY(1,1),
            ' + QUOTENAME(@Nom_Pokemon) + ' NVARCHAR(255) NOT NULL,
            ' + QUOTENAME(@Type_1) + ' NVARCHAR(8) NOT NULL,
            ' + QUOTENAME(@Type_2) + ' NVARCHAR(8),
            ' + QUOTENAME(@Gen_number) + ' INT NOT NULL,
            ' + QUOTENAME(@HP) + ' INT NOT NULL,
            ' + QUOTENAME(@Attack) + ' INT NOT NULL,
            ' + QUOTENAME(@Defense) + ' INT NOT NULL,
            ' + QUOTENAME(@Sp_Attack) + ' INT NOT NULL,
            ' + QUOTENAME(@Sp_Defense) + ' INT NOT NULL,
            ' + QUOTENAME(@Speed) + ' INT NOT NULL,
            CONSTRAINT UC_Pokemon UNIQUE (Pokemon_number),
            FOREIGN KEY(' + QUOTENAME(@Gen_number) + ') REFERENCES ' + QUOTENAME(@GenerationsTableName) + '(' + QUOTENAME(@Gen_number) + ')   
        );';
        SET @PokemonTableSQL = N'USE ' + QUOTENAME(@DatabaseName) + N'; ' + @PokemonTableSQL;
        EXEC sp_executesql @PokemonTableSQL;
    END

    IF OBJECT_ID(@DresseurTableName, 'U') IS NULL
    BEGIN
        SET @DresseurTableSQL = '
        CREATE TABLE '+ QUOTENAME(@DresseurTableName) +' (
            id_dresseur INT NOT NULL PRIMARY KEY IDENTITY(1,1),
            ' + QUOTENAME(@Nom) + ' NVARCHAR(15) NOT NULL,
            ' + QUOTENAME(@Gen_number) + ' INT NOT NULL,
            ' + QUOTENAME(@Gender) + ' NVARCHAR(15) NOT NULL,
            ' + QUOTENAME(@Team_size) + ' TINYINT NOT NULL, /*Max 6*/
            CONSTRAINT UC_Dresseur UNIQUE (id_dresseur),
            FOREIGN KEY(id_dresseur) REFERENCES ' + @ChampionsTableName + '(id_champion),
            FOREIGN KEY(' + QUOTENAME(@Gen_number) + ') REFERENCES ' + @GenerationsTableName + '(Gen_number)
        );';
        SET @DresseurTableSQL = N'USE ' + QUOTENAME(@DatabaseName) + N'; ' + @DresseurTableSQL;
        EXEC sp_executesql @DresseurTableSQL;
    END

        IF OBJECT_ID(@PokemonDresseurTableName, 'U') IS NULL
        BEGIN
            SET @PokemonDresseurTableSQL = '
            CREATE TABLE '+ QUOTENAME(@PokemonDresseurTableName) +' (
                id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
                ' + QUOTENAME(@id_dresseur) + ' INT NOT NULL,
                ' + QUOTENAME(@Pokemon_number) + ' INT NOT NULL,
                ' + QUOTENAME(@Pokemon_level) + ' TINYINT,
                CONSTRAINT UC_PokemonDresseur UNIQUE (' + QUOTENAME(@id_dresseur) + ',' + QUOTENAME(@Pokemon_number) + '),
                FOREIGN KEY(' + QUOTENAME(@Pokemon_number) + ') REFERENCES ' + QUOTENAME(@PokemonTableName) + '(' + QUOTENAME('Pokemon_number') + '),
                FOREIGN KEY(' + QUOTENAME(@id_dresseur) + ') REFERENCES ' + QUOTENAME(@DresseurTableName) + '(' + QUOTENAME('id_dresseur') + ')
            );';
            SET @PokemonDresseurTableSQL = N'USE ' + QUOTENAME(@DatabaseName) + N'; ' + @PokemonDresseurTableSQL;
            EXEC sp_executesql @PokemonDresseurTableSQL;
        END

    IF OBJECT_ID(@PokemonCapaciteTableName, 'U') IS NULL
    BEGIN
        SET @PokemonCapaciteTableSQL = '
        CREATE TABLE '+@PokemonCapaciteTableName+' (
            id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
            ' + QUOTENAME(@Pokemon_number) + ' INT NOT NULL,
            ' + QUOTENAME(@Nom) + ' NVARCHAR(15) NOT NULL,
            ' + QUOTENAME(@Level) + ' INT NOT NULL,
            ' + QUOTENAME(@id_capacite) + ' INT NOT NULL,
            CONSTRAINT UC_PokemonCapacite UNIQUE (' + QUOTENAME(@Pokemon_number) + ',' + QUOTENAME(@id_capacite) + '),
            FOREIGN KEY(' + QUOTENAME(@Pokemon_number) + ') REFERENCES ' + @PokemonTableName + '(' + QUOTENAME('Pokemon_number') + '),
            FOREIGN KEY(' + QUOTENAME(@id_capacite) + ') REFERENCES ' + @CapaciteTableName + '(' + QUOTENAME('id_capacite') + ')
        );';
        SET @PokemonCapaciteTableSQL = N'USE ' + QUOTENAME(@DatabaseName) + N'; ' + @PokemonCapaciteTableSQL;
        EXEC sp_executesql @PokemonCapaciteTableSQL;
    END

    IF OBJECT_ID(@DresseurGenerationTableName, 'U') IS NULL
    BEGIN
        SET @DresseurGenerationTableSQL = '
        CREATE TABLE '+ QUOTENAME(@DresseurGenerationTableName) +' (
            id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
            ' + QUOTENAME(@Gen_number) + ' INT NOT NULL,
            ' + QUOTENAME(@id_dresseur) + ' INT NOT NULL,
            CONSTRAINT UC_DresseurGeneration UNIQUE (' + QUOTENAME(@Gen_number) + ',' + QUOTENAME(@id_dresseur) + '),
            FOREIGN KEY(' + QUOTENAME(@id_dresseur) + ') REFERENCES ' + QUOTENAME(@DresseurTableName) + '(' + QUOTENAME('id_dresseur') + '),
            FOREIGN KEY(' + QUOTENAME(@Gen_number) + ') REFERENCES ' + QUOTENAME(@GenerationsTableName) + '(' + QUOTENAME('Gen_number') + ')
        );';
        SET @DresseurGenerationTableSQL = N'USE ' + QUOTENAME(@DatabaseName) + N'; ' + @DresseurGenerationTableSQL;
        EXEC sp_executesql @DresseurGenerationTableSQL;
    END

    IF OBJECT_ID(@PokemonPokedexTableName, 'U') IS NULL
    BEGIN
        SET @PokemonPokedexTableSQL = '
        CREATE TABLE '+@PokemonPokedexTableName+' (
            id INT IDENTITY(1,1) PRIMARY KEY,
            ' + QUOTENAME(@Pokemon_number) + ' INT NOT NULL,
            ' + QUOTENAME(@id_pokedex) + ' INT NOT NULL,
            CONSTRAINT UC_Pokemon_Pokedex UNIQUE (' + QUOTENAME(@Pokemon_number) + ', ' + QUOTENAME(@id_pokedex) + '),
            FOREIGN KEY(' + QUOTENAME(@Pokemon_number) + ') REFERENCES ' + @PokemonTableName + '(' + QUOTENAME('Pokemon_number') + '),
            FOREIGN KEY(' + QUOTENAME(@id_pokedex) + ') REFERENCES ' + @PokedexTableName + '(' + QUOTENAME('id_pokedex') + ')
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