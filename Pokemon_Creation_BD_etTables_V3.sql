IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'Pokemon2') 
BEGIN
    CREATE DATABASE Pokemon2;
END

USE Pokemon2;

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Pokedex' AND type = 'U')
BEGIN
	CREATE TABLE Pokedex(
		id_pokedex INT NOT NULL PRIMARY KEY IDENTITY(1,1),
		Nom_du_jeu NVARCHAR(255) NOT NULL,
		Pokemon_number INT NOT NULL,
		CONSTRAINT UC_Pokedex UNIQUE (id_pokedex)
	);

END

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Champions' AND type = 'U')
BEGIN
    CREATE TABLE Champions(
        id_champion INT NOT NULL PRIMARY KEY IDENTITY(1,1),
        Nom NVARCHAR(15) NOT NULL,
        Team_type NVARCHAR(15) NOT NULL,
        id_pokedex INT NOT NULL,
        Nom_region NVARCHAR(8) NOT NULL,
        CONSTRAINT UC_Champions UNIQUE (id_champion),
        FOREIGN KEY(id_pokedex) REFERENCES Pokedex
    );
END

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Capacite' AND type = 'U')
BEGIN
	CREATE TABLE Capacite(
		id_capacite INT NOT NULL PRIMARY KEY IDENTITY(1,1),
		Nom NVARCHAR(15) NOT NULL,
		Lev_unlock INT NOT NULL,
		Power_cap INT,
		Accuracy INT,
		PP INT NOT NULL,
		Category NVARCHAR(12) NOT NULL,
		Type_cap NVARCHAR(8) NOT NULL,
		CONSTRAINT UC_Capacite UNIQUE (id_capacite)
	);
END

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Generations' AND type = 'U')
BEGIN
	CREATE TABLE Generations(
        Gen_number INT NOT NULL PRIMARY KEY IDENTITY(1,1),
        Nom_region NVARCHAR(8) NOT NULL,
		id_champion INT NOT NULL,
		CONSTRAINT UC_Generations UNIQUE (Gen_number),
		FOREIGN KEY(id_champion) REFERENCES Champions(id_champion),
    );
END

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Pokemon' AND type = 'U')
BEGIN
	CREATE TABLE Pokemon(
		Pokemon_number INT NOT NULL PRIMARY KEY IDENTITY(1,1),
		Nom_Pokemon NVARCHAR(255) NOT NULL,
		Type_1 NVARCHAR(8) NOT NULL,
		Type_2 NVARCHAR(8),
		Gen_number INT NOT NULL,
		HP INT NOT NULL,
		Attack INT NOT NULL,
		Defense INT NOT NULL,
		Sp_Attack INT NOT NULL,
		Sp_Defense INT NOT NULL,
		Speed INT NOT NULL,
		CONSTRAINT UC_Pokemon UNIQUE (Pokemon_number),
		FOREIGN KEY(Gen_number) REFERENCES Generations,
	);
END

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Dresseur' AND type = 'U')
BEGIN
    CREATE TABLE Dresseur(
        id_dresseur INT NOT NULL PRIMARY KEY IDENTITY(1,1),
        Nom NVARCHAR(15) NOT NULL,
        Gen_number INT NOT NULL,
        Gender NVARCHAR(15) NOT NULL,
        Team_size TINYINT NOT NULL, /*Max 6*/
        CONSTRAINT UC_Dresseur UNIQUE (id_dresseur),
        FOREIGN KEY(id_dresseur) REFERENCES Champions(id_champion),
        FOREIGN KEY(Gen_number) REFERENCES Generations(Gen_number)
    );
END


IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Pokemon_Dresseur' AND type = 'U')
BEGIN
	CREATE TABLE Pokemon_Dresseur(
		id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
		id_dresseur INT NOT NULL,
		Pokemon_number INT NOT NULL,
		Pokemon_level TINYINT,
		CONSTRAINT UC_Pokemon_Dresseur UNIQUE (id_dresseur,Pokemon_number),
		FOREIGN KEY(id_dresseur) REFERENCES Dresseur,
		FOREIGN KEY(Pokemon_number) REFERENCES Pokemon,
	);
END

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Pokemon_Capacite' AND type = 'U')
BEGIN
	CREATE TABLE Pokemon_Capacite(
		id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
		Pokemon_number INT NOT NULL,
		Nom NVARCHAR(15) NOT NULL,
		Level INT NOT NULL,
		id_capacite INT NOT NULL,
		CONSTRAINT UC_Pokemon_Capacite UNIQUE (Pokemon_number, id_capacite),
		FOREIGN KEY(Pokemon_number) REFERENCES Pokemon,
		FOREIGN KEY(id_capacite) REFERENCES Capacite,
	);
END

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Dresseur_Generation' AND type = 'U')
BEGIN
	CREATE TABLE Dresseur_Generation(
		id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
        Gen_number INT NOT NULL,
        id_dresseur INT NOT NULL,
		CONSTRAINT UC_Dresseur_Generation UNIQUE (Gen_number,id_dresseur),
		FOREIGN KEY(id_dresseur) REFERENCES Dresseur,
		FOREIGN KEY(Gen_number) REFERENCES Generations
    );
END

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Pokemon_Pokedex' AND type = 'U')
BEGIN
	CREATE TABLE Pokemon_Pokedex(
		id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
        pokemon_number INT NOT NULL,
        id_pokedex INT NOT NULL,
		CONSTRAINT UC_Pokemon_Pokedex UNIQUE (pokemon_number, id_pokedex),
		FOREIGN KEY(id_pokedex) REFERENCES Pokedex,
		FOREIGN KEY(pokemon_number) REFERENCES Pokemon,
    );
END