-- Look at athlete details
select * from athleteevents

-- Look at regions competed in Olympics
select * from nocregions

-- Find duplicates
SELECT me, games, year, event, COUNT(*) 
FROM athleteevents
GROUP BY me, games, year, event
HAVING COUNT(*) > 1
-- Many athletes competed in the same event in the same year multiple times

-- Find total # of regions
select count(distinct region) as TotalRegions
from nocregions;
-- 207 countries competed in Olympics

-- Find total # of each sex
select sex, count(*) as TotalSex
from athleteevents
group by Sex;

-- Find total # of each sex per city with ratio as well
select city, sex, count(*) as TotalSex, sum(case when sex = "M" then 1 else 0 end) as male,
sum(case when sex = "F" then 1 else 0 end) as female,
sum(case when sex = "M" then 1 else 0 end)/sum(case when sex = "F" then 1 else 0 end) as Ratio
from athleteevents
group by city
order by 4 desc, 5 desc
limit 25;

-- Find all cities that had more than 10,000 participants in that olympics
select city, count(*) as Athletes
from athleteevents
group by city
having athletes > 10000
order by 2 desc;

-- Find total # of each sex per region with ratio as well
select region, sex, count(*) as TotalSex, sum(case when sex = "M" then 1 else 0 end) as male,
sum(case when sex = "F" then 1 else 0 end) as female,
sum(case when sex = "M" then 1 else 0 end)/sum(case when sex = "F" then 1 else 0 end) as Ratio
from athleteevents a inner join nocregions n on a.noc = n.noc
group by region
order by 1
limit 25;

-- Look at # of Medals Won by Males vs Females
-- Gold medals won
select medal, 
sum(case when sex = "M" then 1 else 0 end) as MaleMedalCount, 
sum(case when sex = "F" then 1 else 0 end) as FemaleMedalCount
from athleteevents
where medal = "gold";
-- Silver medals won
select medal, 
sum(case when sex = "M" then 1 else 0 end) as MaleMedalCount, 
sum(case when sex = "F" then 1 else 0 end) as FemaleMedalCount
from athleteevents
where medal = "silver";
-- Bronze medals won
select medal, 
sum(case when sex = "M" then 1 else 0 end) as MaleMedalCount, 
sum(case when sex = "F" then 1 else 0 end) as FemaleMedalCount
from athleteevents
where medal = "bronze";

-- # of Gold medals earned from top 10 countries
select medal, count(*) as TotalGold, region
from athleteevents a inner join nocregions n on a.noc = n.noc
where medal = "gold"
group by region
order by 2 desc
limit 10;
-- USA earned the most gold
select medal, count(*) as TotalGold, region
from athleteevents a inner join nocregions n on a.noc = n.noc
where medal = "gold"
group by region
order by 2 asc
limit 25;
-- 21 countries tied for the least gold won (1)

-- Look at various age groups of olympians
select case when age < 20 then "0-20" when age between 20 and 30 then "20-30"
when age between 30 and 40 then "30-40" when age between 40 and 50 then "40-50"
when age between 50 and 60 then "50-60" when age between 60 and 70 then "60-70"
when age between 70 and 80 then "70-80" when age > 80 then "above 80" end as age_range, age, count(age) as TotalAge
from athleteevents
group by age
order by age_range, TotalAge desc;

-- Gold medals won by those 50+
select sport, medal, count(*) as Gold50Plus
from athleteevents
where medal = "gold" and age > 50
group by sport
order by 3 desc;
-- Equesterianism was the most popular sport in this case

-- Gold medals won by those younger than 25
select sport, medal, count(*) as Gold25Minus
from athleteevents
where medal = "gold" and age < 25
group by sport
order by 3 desc;
-- Swimming was the most popular sport in this case

-- Find countries with highest # of olympians by season
select team, season, count(*) as Olympians
from athleteevents
where Season = "Summer"
group by Team
order by Olympians desc, season
limit 10;
--
select team, season, count(*) as Olympians
from athleteevents
where Season = "Winter"
group by Team
order by Olympians desc, season
limit 10;
-- US has the most olypmpians participated for both seasons

-- Find # of male athletes in each olympics
-- Winter
select sex, count(*) as MaleAthletes, year
from athleteevents
where sex = "M" and season = "winter"
group by year
order by 3;
-- Summer
select sex, count(*) as MaleAthletes, year
from athleteevents
where sex = "M" and season = "summer"
group by year
order by 3;

-- Find # of female athletes in each olympics
-- Winter
select sex, count(*) as FemaleAthletes, year
from athleteevents
where sex = "F" and season = "winter"
group by year
order by 3;
-- Summer
select sex, count(*) as FemaleAthletes, year
from athleteevents
where sex = "F" and season = "summer"
group by year
order by 3;

-- Most popular sports for each sex
-- Female
select event, count(*) as FemalePopSports
from athleteevents
where sex = "F"
group by Event
order by 2 desc
limit 5;
-- Volleyball is the most popular for females
-- Male
select event, count(*) as MalePopSports
from athleteevents
where sex = "M"
group by Event
order by 2 desc
limit 5;
-- Football is the most popular for males

-- # of participants per sport ordered by average height and weight
select sport, avg(height), avg(weight)
from athleteevents
group by sport
order by 2 desc, 3 desc
limit 20;
-- Find the sport with the tallest average height (cm)
select sport, avg(height)
from athleteevents
group by sport
order by 2 desc
limit 10;
-- Basketball is the answer
-- Find the sport with the heaviest average weight (kg)
select sport, avg(weight)
from athleteevents
group by sport
order by 2 desc
limit 10;
-- Tug-Of War is the answer

-- Height vs Weight Distribution that won Gold
select sex, medal, height, weight
from athleteevents
where medal = "gold"
group by height, weight;

-- # of athletes in summer vs winter olympics since 1980
select season,
sum(case when season = "summer" then 1 else 0 end) as SummerTotal,
sum(case when season = "winter" then 1 else 0 end) as WinterTotal
from athleteevents
where year >= 1980
group by Season;

-- Country with the most medals by year
select team, count(medal) as TotalMedals, year
from athleteevents
where medal in ("gold", "silver", "bronze")
group by team
order by TotalMedals desc;

-- Region with the most medals by year
select region, count(medal) as TotalMedals, year
from athleteevents a inner join nocregions n on a.noc = n.noc
where medal in ("gold", "silver", "bronze")
group by region
order by 2 desc;

-- Medal Count in 2016 Olympics
select team, year, count(medal) as NoOfGoldMedals
from athleteevents
where medal = "gold" and year = 2016
group by team
order by 3 desc
limit 20;
-- US won most golds
-- 
select team, year, count(medal) as NoOfMedals
from athleteevents
where year = 2016
group by team
order by 3 desc
limit 20;
-- US won most medals overall

-- US Olympians that have competed more than once and their career medal count
select temptable.me, count(temptable.me) as TimesParticipated
from
(select id,me,count(Medal) as MedalsWon
        from athleteevents
        where (Medal<>'None' and Team='United States')
        group by me
        having MedalsWon >= 9
        order by MedalsWon desc) as temptable LEFT JOIN athleteevents ON temptable.ID=athleteevents.ID
        where medal in ("gold", "silver", "bronze")
group by temptable.me
order by TimesParticipated desc;


