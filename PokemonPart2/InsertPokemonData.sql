USE Pokemon3;
GO

-- Ajout d'un enregistrement avec une procédure stockée pour éviter les doublons
CREATE OR ALTER PROCEDURE AddRecord
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
-- Vérifier si l'enregistrement existe déjà dans la table Pokemon_Pokedex
IF NOT EXISTS (
SELECT 1
FROM Pokemon3.dbo.Pokemon_Pokedex
WHERE Pokemon_number = @Pokemon_number AND id_pokedex = @id_pokedex
)
BEGIN
-- Si l'enregistrement n'existe pas, ajoutez-le avec les valeurs spécifiées
EXEC CreateProjet2DatabaseAndTables
@Nom_du_jeu,
@Nom_Pokemon,
@Nom,
@Team_type,
@Nom_region,
@Lev_unlock,
@Power_cap,
@Accuracy,
@PP,
@Category,
@Type_cap,
@Gen_number,
@Pokemon_number,
@id_champion,
@id_pokedex,
@Type_1,
@Type_2,
@HP,
@Attack,
@Defense,
@Sp_Attack,
@Sp_Defense,
@Speed,
@Gender,
@Team_size,
@id_dresseur,
@Pokemon_level,
@id_capacite,
@Level;
END
ELSE
BEGIN
-- Si l'enregistrement existe déjà, affichez un message d'erreur
PRINT 'L''enregistrement existe déjà dans la base de données.';
END
END;
GO

-- Utiliser la procédure stockée AddRecord pour ajouter un nouvel enregistrement
EXEC AddRecord
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
