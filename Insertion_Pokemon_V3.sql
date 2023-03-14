use Pokemon2;

INSERT INTO Pokedex (Nom_du_jeu, Pokemon_number) VALUES
('Pokemon Rouge Feu', 1),
('Pokemon Rouge Feu', 2),
('Pokemon Rouge Feu', 3),
('Pokemon Rouge Feu', 4),
('Pokemon Rouge Feu', 5),
('Pokemon Rouge Feu', 6),
('Pokemon Rouge Feu', 7),
('Pokemon Rouge Feu', 8),
('Pokemon Rouge Feu', 9),
('Pokemon Rouge Feu', 10);

INSERT INTO Champions (Nom, Team_type, id_pokedex, Nom_region) VALUES
('Red', 'Solo', 1, 'Kanto'),
('Blue', 'Solo', 1, 'Kanto'),
('Steven', 'Solo', 1, 'Hoenn'),
('Wallace', 'Solo', 1, 'Hoenn'),
('Cynthia', 'Solo', 1, 'Sinnoh'),
('Alder', 'Solo', 1, 'Unova'),
('Iris', 'Solo', 1, 'Unova'),
('Diantha', 'Solo', 1, 'Kalos'),
('Kukui', 'Solo', 1, 'Alola'),
('Leon', 'Solo', 1, 'Galar');

INSERT INTO Capacite (Nom, Lev_unlock, Power_cap, Accuracy, PP, Category, Type_cap) VALUES
('Charge', 1, 40, 100, 35, 'Physical', 'Electric'),
('Feinte', 1, 60, 0, 20, 'Physical', 'Dark'),
('Flammèche', 1, 40, 100, 25, 'Special', 'Fire'),
('Vibraqua', 1, 60, 100, 20, 'Special', 'Water'),
('Fouet lianes', 1, 45, 100, 25, 'Physical', 'Grass'),
('Chargeur', 1, 0, 0, 20, 'Status', 'Electric'),
('Coup d boule', 1, 70, 100, 15, 'Physical', 'Normal'),
('Bulles d O', 1, 40, 100, 30, 'Special', 'Water'),
('Mimi queue', 1, 0, 100, 30, 'Status', 'Normal'),
('Grincement', 1, 0, 85, 40, 'Status', 'Normal');

INSERT INTO Generations (Nom_region, id_champion) VALUES
('Kanto', 1),
('Kanto', 2),
('Hoenn', 3),
('Hoenn', 4),
('Sinnoh', 5),
('Unova', 6),
('Unova', 7),
('Kalos', 8),
('Alola', 9),
('Galar', 10);

INSERT INTO Pokemon (Nom_Pokemon, Type_1, Type_2, Gen_number, HP, Attack, Defense, Sp_Attack, Sp_Defense, Speed) VALUES
('Bulbasaur', 'Grass', 'Poison', 1, 45, 49, 49, 65, 65, 45),
('Charmander', 'Fire', NULL, 1, 39, 52, 43, 60, 50, 65),
('Squirtle', 'Water', NULL, 1, 44, 48, 65, 50, 64, 43),
('Pikachu', 'Electric', NULL, 1, 35, 55, 40, 50, 50, 90),
('Mewtwo', 'Psychic', NULL, 1, 106, 110, 90, 154, 90, 130),
('Typhlosion', 'Fire', NULL, 2, 78, 84, 78, 109, 85, 100),
('Feraligatr', 'Water', NULL, 2, 85, 105, 100, 79, 83, 78),
('Sceptile', 'Grass', 'Dragon', 3, 70, 85, 65, 105, 85, 120),
('Empoleon', 'Water', 'Steel', 4, 84, 86, 88, 111, 101, 60),
('Greninja', 'Water', 'Dark', 6, 72, 95, 67, 103, 71, 122);

INSERT INTO Dresseur (Nom, Gen_number, Gender, Team_size) VALUES
('Red', 1, 'Male', 6),
('Leaf', 1, 'Female', 6),
('Brendan', 3, 'Male', 6),
('May', 3, 'Female', 6),
('Dawn', 4, 'Female', 6),
('Hilbert', 5, 'Male', 6),
('Hilda', 5, 'Female', 6),
('Calem', 6, 'Male', 6),
('Serena', 6, 'Female', 6),
('Elio', 7, 'Male', 6);

INSERT INTO Pokemon_Dresseur (id_dresseur, Pokemon_number, Pokemon_level) VALUES
(1, 1, 5),
(1, 2, 5),
(1, 3, 5),
(2, 4, 5),
(2, 5, 5),
(2, 6, 5),
(3, 7, 50),
(3, 8, 50),
(3, 9, 50),
(4, 10, 5);


INSERT INTO Pokemon_Capacite (Pokemon_number, Nom, Level, id_capacite) VALUES
(1, 'Charge', 1, 1),
(1, 'Feinte', 1, 2),
(2, 'Charge', 1, 1),
(2, 'Feinte', 1, 2),
(4, 'Charge', 1, 1),
(4, 'Feinte', 1, 2),
(5, 'Charge', 1, 1),
(5, 'Feinte', 1, 2),
(7, 'Charge', 1, 1),
(7, 'Feinte', 1, 2);

INSERT INTO Dresseur_Generation (Gen_number, id_dresseur) VALUES (1, 1);
INSERT INTO Dresseur_Generation (Gen_number, id_dresseur) VALUES (1, 2);
INSERT INTO Dresseur_Generation (Gen_number, id_dresseur) VALUES (3, 3);
INSERT INTO Dresseur_Generation (Gen_number, id_dresseur) VALUES (3, 4);
INSERT INTO Dresseur_Generation (Gen_number, id_dresseur) VALUES (4, 5);
INSERT INTO Dresseur_Generation (Gen_number, id_dresseur) VALUES (5, 6);
INSERT INTO Dresseur_Generation (Gen_number, id_dresseur) VALUES (5, 7);
INSERT INTO Dresseur_Generation (Gen_number, id_dresseur) VALUES (6, 8);
INSERT INTO Dresseur_Generation (Gen_number, id_dresseur) VALUES (6, 9);
INSERT INTO Dresseur_Generation (Gen_number, id_dresseur) VALUES (7, 10);

INSERT INTO Pokemon_Pokedex (pokemon_number, id_pokedex) VALUES (1, 1);
INSERT INTO Pokemon_Pokedex (pokemon_number, id_pokedex) VALUES (2, 1);
INSERT INTO Pokemon_Pokedex (pokemon_number, id_pokedex) VALUES (3, 1);
INSERT INTO Pokemon_Pokedex (pokemon_number, id_pokedex) VALUES (4, 1);
INSERT INTO Pokemon_Pokedex (pokemon_number, id_pokedex) VALUES (5, 1);
INSERT INTO Pokemon_Pokedex (pokemon_number, id_pokedex) VALUES (6, 1);
INSERT INTO Pokemon_Pokedex (pokemon_number, id_pokedex) VALUES (7, 1);
INSERT INTO Pokemon_Pokedex (pokemon_number, id_pokedex) VALUES (8, 1);
INSERT INTO Pokemon_Pokedex (pokemon_number, id_pokedex) VALUES (9, 1);
INSERT INTO Pokemon_Pokedex (pokemon_number, id_pokedex) VALUES (10, 1);