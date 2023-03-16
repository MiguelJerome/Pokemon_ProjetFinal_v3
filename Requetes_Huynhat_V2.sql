--	Script des requêtes incluant les clauses: 

--	Where
select * from Champions
where Nom_region = 'Hoenn'


--	Top
select top(5) Nom_Pokemon, Attack, Speed
from Pokemon
where Type_1 = 'Electric'
order by Attack desc

--	Like
select Nom_Pokemon
from Pokemon
where Nom_Pokemon like '%ja'

--	Or
select *
from Pokemon
where Type_1 = 'grass' or Attack >=100

--	And
select *
from Pokemon
where Type_1 = 'water' and Attack >=20

--	In
select Nom, Gen_number, Gender
from Dresseur
where Gender in ('male')

--	Exists 
select Nom_Pokemon
from Pokemon
where exists (select Nom_Pokemon from Pokemon where Type_2 is null);

--	Group by
select sum(Pokemon.Attack) as Total_Attack_Pokemon, Pokemon.Type_1 as Type_de_Pokemon
from Pokemon
group by Pokemon.Speed, Pokemon.Type_1

--	Having
select count(Pokemon.Attack) as Total_de_pokemon_par_type1, Type_1 as Type_de_pokemon, sum(Pokemon.Attack) as Total_Attaque
from Pokemon
group by Type_1
having sum(Pokemon.Attack) > 50
order by Total_Attaque asc

--	Between
select Nom_Pokemon, Speed
from Pokemon
where Speed between '75' and '150'
order by Speed asc