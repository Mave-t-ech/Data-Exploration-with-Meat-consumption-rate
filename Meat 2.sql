Select *
from slaughtered
where Year > 2010
order by 1,2;

select *
from supplyperperson
where year > 2010
order by 1,2;

select *
from meattype
where year > 2010
order by 1,2;

Select *
from slaughtered
where Year > 2010
--and entity = 'Nigeria'
--group by entity
order by 1,2;

--Countries and the year they had max slaughter of each meat type. 
WITH RankedBP AS (
    SELECT entity, Year, mutton, beef, chicken, chevon,turkey,duck,
        ROW_NUMBER() OVER (PARTITION BY entity ORDER BY beef DESC) AS BeefRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY mutton DESC) MuttonRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY Pork DESC) PorkRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY chicken DESC) chickenRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY chevon DESC) chevonRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY turkey DESC) turkeyRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY duck DESC) duckRank

    FROM slaughtered
	where year >2010
)
SELECT entity, --Year, mutton, beef,--, poultry
max (case when  BeefRank = 1 THEN Year END) as MaxBeefYEAR,
Max ( CASE WHEN BeefRank = 1 THEN beef END) as MaxBeefSlaughter,
Max (Case when MuttonRank = 1 THEN Year END) as MaxMuttonYear,
Max (Case WHEN MuttonRank = 1 Then mutton END) as MaxMuttonSlaughter,
Max (Case when PorkRank = 1 THEN Year END) as MaxPorkYear,
Max (Case WHEN PorkRank = 1 Then mutton END) as MaxPorkSlaughter,
Max (Case when chickenRank = 1 THEN Year END) as MaxChickenYear,
Max (Case WHEN chickenRank = 1 Then mutton END) as MaxChickenSlaughter,
Max (Case when chevonRank = 1 THEN Year END) as MaxChevonYear,
Max (Case WHEN chevonRank = 1 Then mutton END) as MaxChevonSlaughter,
Max (Case when turkeyRank = 1 THEN Year END) as MaxturkeyYear,
Max (Case WHEN turkeyRank = 1 Then mutton END) as MaxturkeySlaughter,
Max (Case when duckRank = 1 THEN Year END) as MaxduckYear,
Max (Case WHEN duckRank = 1 Then mutton END) as MaxduckSlaughter
FROM RankedBP
WHERE entity not like '%FAO%'
and entity not like '%income%' and entity not like '%America%' and entity not like '%Europe%'
and entity not in ('Africa', 'Oceania', 'Asia', 'World') 
--and entity = 'Nigeria'
Group by entity;

--Continents and the year they had max slaughters of each meat type
WITH RankedBP AS (
    SELECT entity, Year, mutton, beef, chicken, chevon,turkey,duck,
        ROW_NUMBER() OVER (PARTITION BY entity ORDER BY beef DESC) AS BeefRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY mutton DESC) MuttonRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY Pork DESC) PorkRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY chicken DESC) chickenRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY chevon DESC) chevonRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY turkey DESC) turkeyRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY duck DESC) duckRank

    FROM slaughtered
	where year >2010
)
SELECT entity, 
max (case when  BeefRank = 1 THEN Year END) as MaxBeefYEAR,
Max ( CASE WHEN BeefRank = 1 THEN beef END) as MaxBeefSlaughter,
Max (Case when MuttonRank = 1 THEN Year END) as MaxMuttonYear,
Max (Case WHEN MuttonRank = 1 Then mutton END) as MaxMuttonSlaughter,
Max (Case when PorkRank = 1 THEN Year END) as MaxPorkYear,
Max (Case WHEN PorkRank = 1 Then mutton END) as MaxPorkSlaughter,
Max (Case when chickenRank = 1 THEN Year END) as MaxChickenYear,
Max (Case WHEN chickenRank = 1 Then mutton END) as MaxChickenSlaughter,
Max (Case when chevonRank = 1 THEN Year END) as MaxChevonYear,
Max (Case WHEN chevonRank = 1 Then mutton END) as MaxChevonSlaughter,
Max (Case when turkeyRank = 1 THEN Year END) as MaxturkeyYear,
Max (Case WHEN turkeyRank = 1 Then mutton END) as MaxturkeySlaughter,
Max (Case when duckRank = 1 THEN Year END) as MaxduckYear,
Max (Case WHEN duckRank = 1 Then mutton END) as MaxduckSlaughter
FROM RankedBP
--WHere entity = 'Asia'
WHERE entity not like '%FAO%'
--and entity not like '%income%' 
--and entity  like '%America%' and entity  like '%Europe%'
and entity in ('Africa', 'Oceania', 'Asia', 'South America', 'North America', 'Europe', 'Eastern Asia') 
--and entity = 'Nigeria'
Group by entity
;
--countries and the year they had the highest supply of meat, fish and others for an individual per kg per capita
select entity, max(beef)--, year
from meattype
where year > 2010
group by entity--, year
order by 1,2;

WITH Rankeddata AS (
    SELECT entity, Year, mutton_chevon, beef, poultry, fish, other, pork,
        ROW_NUMBER() OVER (PARTITION BY entity ORDER BY beef DESC) AS BeefRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY mutton_chevon DESC) MCRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY Pork DESC) PorkRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY poultry DESC) PRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY fish DESC) FRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY other DESC) oRank

    FROM meattype
	where year >2010
)
SELECT entity, 
max (case when  BeefRank = 1 THEN Year END) as MaxBeefYEAR,
Max ( CASE WHEN BeefRank = 1 THEN beef END) as MAxBeef,
Max (Case when MCRank = 1 THEN Year END) as MaxMutton_ChevonYear,
Max (Case WHEN MCRank = 1 Then mutton_chevon END) as MaxMutton_Chevon,
Max (Case when PorkRank = 1 THEN Year END) as MaxPorkYear,
Max (Case WHEN PorkRank = 1 Then pork END) as MaxPork,
Max (Case when PRank = 1 THEN Year END) as MaxpoultryYear,
Max (Case WHEN PRank = 1 Then poultry END) as MaxPoultry,
Max (Case when FRank = 1 THEN Year END) as MaxFishYear,
Max (Case WHEN FRank = 1 Then Fish END) as MaxFish,
Max (Case when oRank = 1 THEN Year END) as MaxOtherYear,
Max (Case WHEN oRank = 1 Then other END) as MaxOther
FROM Rankeddata
WHERE entity not like '%FAO%'
and entity not like '%income%' and entity not like '%America%' and entity not like '%Europe%'
and entity not in ('Africa', 'Oceania', 'Asia', 'World') 
--and entity = 'Nigeria'
Group by entity;

--continents an the year they had the highest supply of meat, fish and other for an individual per kg per capita
WITH Rankeddata AS (
    SELECT entity, Year, mutton_chevon, beef, poultry, fish, other, pork,
        ROW_NUMBER() OVER (PARTITION BY entity ORDER BY beef DESC) AS BeefRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY mutton_chevon DESC) MCRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY Pork DESC) PorkRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY poultry DESC) PRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY fish DESC) FRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY other DESC) oRank

    FROM meattype
	where year >2010
)
SELECT entity, 
max (case when  BeefRank = 1 THEN Year END) as MaxBeefYEAR,
Max ( CASE WHEN BeefRank = 1 THEN beef END) as MAxBeefSupply,
Max (Case when MCRank = 1 THEN Year END) as MaxMutton_ChevonYear,
Max (Case WHEN MCRank = 1 Then mutton_chevon END) as MaxMutton_ChevonSupply,
Max (Case when PorkRank = 1 THEN Year END) as MaxPorkYear,
Max (Case WHEN PorkRank = 1 Then pork END) as MaxPorkSupply,
Max (Case when PRank = 1 THEN Year END) as MaxpoultryYear,
Max (Case WHEN PRank = 1 Then poultry END) as MaxPoultrySupply,
Max (Case when FRank = 1 THEN Year END) as MaxFishYear,
Max (Case WHEN FRank = 1 Then Fish END) as MaxFishSupply,
Max (Case when oRank = 1 THEN Year END) as MaxOtherYear,
Max (Case WHEN oRank = 1 Then other END) as MaxOtherSupply
FROM Rankeddata
WHERE entity not like '%FAO%'
and entity in ('Africa', 'Oceania', 'Asia', 'South America', 'North America', 'Europe', 'Eastern Asia') 
Group by entity;

--Comapring to see if the years with the max slaughter is same with the max suppliesperperson (Continent)
Create view Continentalsupply as 
WITH Rankeddata AS (
    SELECT entity, Year, mutton_chevon, beef, poultry, fish, other, pork,
        ROW_NUMBER() OVER (PARTITION BY entity ORDER BY beef DESC) AS BeefRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY mutton_chevon DESC) MCRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY Pork DESC) PorkRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY poultry DESC) PRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY fish DESC) FRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY other DESC) oRank

    FROM meattype
	where year >2010
)
SELECT entity, 
max (case when  BeefRank = 1 THEN Year END) as MaxBeefYEAR,
Max ( CASE WHEN BeefRank = 1 THEN beef END) as MAxBeefSupply,
Max (Case when MCRank = 1 THEN Year END) as MaxMutton_ChevonYear,
Max (Case WHEN MCRank = 1 Then mutton_chevon END) as MaxMutton_ChevonSupply,
Max (Case when PorkRank = 1 THEN Year END) as MaxPorkYear,
Max (Case WHEN PorkRank = 1 Then pork END) as MaxPorkSupply,
Max (Case when PRank = 1 THEN Year END) as MaxpoultryYear,
Max (Case WHEN PRank = 1 Then poultry END) as MaxPoultrySupply,
Max (Case when FRank = 1 THEN Year END) as MaxFishYear,
Max (Case WHEN FRank = 1 Then Fish END) as MaxFishSupply,
Max (Case when oRank = 1 THEN Year END) as MaxOtherYear,
Max (Case WHEN oRank = 1 Then other END) as MaxOtherSupply
FROM Rankeddata
WHERE entity not like '%FAO%'
and entity in ('Africa', 'Oceania', 'Asia', 'South America', 'North America', 'Europe', 'Eastern Asia') 
Group by entity;

Create view ContinentalSlaughter as
WITH RankedBP AS (
    SELECT entity, Year, mutton, beef, chicken, chevon,turkey,duck,
        ROW_NUMBER() OVER (PARTITION BY entity ORDER BY beef DESC) AS BeefRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY mutton DESC) MuttonRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY Pork DESC) PorkRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY chicken DESC) chickenRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY chevon DESC) chevonRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY turkey DESC) turkeyRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY duck DESC) duckRank

    FROM slaughtered
	where year >2010
)
SELECT entity, 
max (case when  BeefRank = 1 THEN Year END) as MaxBeefYEAR,
Max ( CASE WHEN BeefRank = 1 THEN beef END) as MaxBeefSlaughter,
Max (Case when MuttonRank = 1 THEN Year END) as MaxMuttonYear,
Max (Case WHEN MuttonRank = 1 Then mutton END) as MaxMuttonSlaughter,
Max (Case when PorkRank = 1 THEN Year END) as MaxPorkYear,
Max (Case WHEN PorkRank = 1 Then mutton END) as MaxPorkSlaughter,
Max (Case when chickenRank = 1 THEN Year END) as MaxChickenYear,
Max (Case WHEN chickenRank = 1 Then mutton END) as MaxChickenSlaughter,
Max (Case when chevonRank = 1 THEN Year END) as MaxChevonYear,
Max (Case WHEN chevonRank = 1 Then mutton END) as MaxChevonSlaughter,
Max (Case when turkeyRank = 1 THEN Year END) as MaxturkeyYear,
Max (Case WHEN turkeyRank = 1 Then mutton END) as MaxturkeySlaughter,
Max (Case when duckRank = 1 THEN Year END) as MaxduckYear,
Max (Case WHEN duckRank = 1 Then mutton END) as MaxduckSlaughter
FROM RankedBP
--WHere entity = 'Asia'
WHERE entity not like '%FAO%'
--and entity not like '%income%' 
--and entity  like '%America%' and entity  like '%Europe%'
and entity in ('Africa', 'Oceania', 'Asia', 'South America', 'North America', 'Europe', 'Eastern Asia') 
--and entity = 'Nigeria'
Group by entity

select *
from ContinentalSlaughter as csl
LEFT JOIN Continentalsupply as csu
ON csl.entity = csu.entity;

--ContinentalBeef
select csu.entity, csl.MaxBeefYEAR, MaxBeefSlaughter, csu.MaxBeefYEAR, MAxBeefSupply
from ContinentalSlaughter as csl
LEFT JOIN Continentalsupply as csu
ON csl.entity = csu.entity;

--Comparing countries' Slaughter vs Supply Max years
Create view CountrySlaughter as
WITH RankedBP AS (
    SELECT entity, Year, mutton, beef, chicken, chevon,turkey,duck,
        ROW_NUMBER() OVER (PARTITION BY entity ORDER BY beef DESC) AS BeefRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY mutton DESC) MuttonRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY Pork DESC) PorkRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY chicken DESC) chickenRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY chevon DESC) chevonRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY turkey DESC) turkeyRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY duck DESC) duckRank

    FROM slaughtered
	where year >2010
)
SELECT entity, --Year, mutton, beef,--, poultry
max (case when  BeefRank = 1 THEN Year END) as MaxBeefYEAR,
Max ( CASE WHEN BeefRank = 1 THEN beef END) as MaxBeefSlaughter,
Max (Case when MuttonRank = 1 THEN Year END) as MaxMuttonYear,
Max (Case WHEN MuttonRank = 1 Then mutton END) as MaxMuttonSlaughter,
Max (Case when PorkRank = 1 THEN Year END) as MaxPorkYear,
Max (Case WHEN PorkRank = 1 Then mutton END) as MaxPorkSlaughter,
Max (Case when chickenRank = 1 THEN Year END) as MaxChickenYear,
Max (Case WHEN chickenRank = 1 Then mutton END) as MaxChickenSlaughter,
Max (Case when chevonRank = 1 THEN Year END) as MaxChevonYear,
Max (Case WHEN chevonRank = 1 Then mutton END) as MaxChevonSlaughter,
Max (Case when turkeyRank = 1 THEN Year END) as MaxturkeyYear,
Max (Case WHEN turkeyRank = 1 Then mutton END) as MaxturkeySlaughter,
Max (Case when duckRank = 1 THEN Year END) as MaxduckYear,
Max (Case WHEN duckRank = 1 Then mutton END) as MaxduckSlaughter
FROM RankedBP
WHERE entity not like '%FAO%'
and entity not like '%income%' and entity not like '%America%' and entity not like '%Europe%'
and entity not in ('Africa', 'Oceania', 'Asia', 'World') 
--and entity = 'Nigeria'
Group by entity;

Create view CountrySupply as
WITH Rankeddata AS (
    SELECT entity, Year, mutton_chevon, beef, poultry, fish, other, pork,
        ROW_NUMBER() OVER (PARTITION BY entity ORDER BY beef DESC) AS BeefRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY mutton_chevon DESC) MCRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY Pork DESC) PorkRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY poultry DESC) PRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY fish DESC) FRank,
		Row_NUMBER() OVER (PARTITION BY entity ORDER BY other DESC) oRank

    FROM meattype
	where year >2010
)
SELECT entity, 
max (case when  BeefRank = 1 THEN Year END) as MaxBeefYEAR,
Max ( CASE WHEN BeefRank = 1 THEN beef END) as MaxBeefSupply,
Max (Case when MCRank = 1 THEN Year END) as MaxMutton_ChevonYear,
Max (Case WHEN MCRank = 1 Then mutton_chevon END) as MaxMutton_ChevonSupply,
Max (Case when PorkRank = 1 THEN Year END) as MaxPorkYear,
Max (Case WHEN PorkRank = 1 Then pork END) as MaxPorkSupply,
Max (Case when PRank = 1 THEN Year END) as MaxpoultryYear,
Max (Case WHEN PRank = 1 Then poultry END) as MaxPoultrySupply,
Max (Case when FRank = 1 THEN Year END) as MaxFishYear,
Max (Case WHEN FRank = 1 Then Fish END) as MaxFishSupply,
Max (Case when oRank = 1 THEN Year END) as MaxOtherYear,
Max (Case WHEN oRank = 1 Then other END) as MaxOtherSupply
FROM Rankeddata
WHERE entity not like '%FAO%'
and entity not like '%income%' and entity not like '%America%' and entity not like '%Europe%'
and entity not in ('Africa', 'Oceania', 'Asia', 'World') 
--and entity = 'Nigeria'
Group by entity;

Select *
From CountrySlaughter as cos
Left Join CountrySupply as cosu
ON cos.entity = cosu.entity;

--Country beef
Select cos.entity, cos.MaxBeefYEAR, MaxBeefSlaughter, cosu.MaxBeefYEAR, MaxBeefSupply
From CountrySlaughter as cos
Left Join CountrySupply as cosu
ON cos.entity = cosu.entity
--Where cos.entity = 'Nigeria';

-- Checking out the most slaughtered animal per country 
With msl as ( SELECT entity, Year, 
		Case
		when chicken >= greatest (beef,mutton,chevon,turkey,duck,pork) then 'chicken'
		when mutton >= greatest (beef,chicken,chevon,turkey,duck,pork) then 'mutton'
		when beef >= greatest (chicken,mutton,chevon,turkey,duck,pork) then 'beef'
		when chevon >= greatest (beef,mutton,chicken,turkey,duck,pork) then 'chevon'
		when turkey >= greatest (beef,mutton,chevon,chicken,duck,pork) then 'turkey'
		when pork >= greatest (beef,mutton,chevon,chicken,duck,turkey) then 'pork'
		else 'duck'
end as most_slaughtered
	from slaughtered
	where year > 2010
	and entity not like '%FAO%'
and entity not like '%income%' and entity not like '%America%' and entity not like '%Europe%'
and entity not in ('Africa', 'Oceania', 'Asia', 'World') 
)
select entity, max(most_slaughtered) as most_slaugthered
from msl 
--for cases other than chicken activate the where cause below
--where most_slaughtered <> 'chicken'
group by entity;
-- checking out the most slaughtered other than chicken over the years (2011-2021)
   With msc as ( SELECT entity, Year, 
			Case
		when chicken >= greatest (beef,mutton,chevon,turkey,duck,pork) then 'chicken'
		when mutton >= greatest (beef,chicken,chevon,turkey,duck,pork) then 'mutton'
		when beef >= greatest (chicken,mutton,chevon,turkey,duck,pork) then 'beef'
		when chevon >= greatest (beef,mutton,chicken,turkey,duck,pork) then 'chevon'
		when turkey >= greatest (beef,mutton,chevon,chicken,duck,pork) then 'turkey'
		when pork >= greatest (beef,mutton,chevon,chicken,duck,turkey) then 'pork'
		else 'duck'
end as most_slaughteredOtherThanChicken
	from slaughtered
	where year > 2010
	and	Case
		when chicken >= greatest (beef,mutton,chevon,turkey,duck,pork) then 'chicken'
		when mutton >= greatest (beef,chicken,chevon,turkey,duck,pork) then 'mutton'
		when beef >= greatest (chicken,mutton,chevon,turkey,duck,pork) then 'beef'
		when chevon >= greatest (beef,mutton,chicken,turkey,duck,pork) then 'chevon'
		when turkey >= greatest (beef,mutton,chevon,chicken,duck,pork) then 'turkey'
		when pork >= greatest (beef,mutton,chevon,chicken,duck,turkey) then 'pork'
		else 'duck'
end <> 'chicken'
)
select entity, max(most_slaughteredOtherThanChicken) as most_slaughteredOtherThanChicken
from msc
group by entity
order by entity

--checking out the most supplied per person per capita in 2000- 2021
 with MS as (SELECT entity, Year, 
		Case
		when poultry >= greatest (beef,mutton_chevon,fish,pork,other) then 'poultry'
		when mutton_chevon >= greatest (beef,poultry,fish,pork, other) then 'mutton_chevon'
		when beef >= greatest (poultry,mutton_chevon,fish,pork, other) then 'beef'
		when fish >= greatest (beef,mutton_chevon, poultry,pork, other) then 'fish'
		when other >= greatest (beef,mutton_chevon,fish,pork, poultry) then 'other'
		else 'pork'
end as most_supplied
	from meattype
	where year > 2010
	and entity not like '%FAO%'
and entity not like '%income%' and entity not like '%America%' and entity not like '%Europe%'
and entity not in ('Africa', 'Oceania', 'Asia', 'World') 
--and entity = 'Nigeria'
--order by entity
)
select entity, max(most_supplied) as MaxSupplied
from MS
group by entity
order by entity;