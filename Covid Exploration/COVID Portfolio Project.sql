select *
from coviddeaths
where continent is not null
order by 3,4;

select *
from covidvaccinations
order by 3,4;

select location, date, total_cases, new_cases, total_deaths, population
from coviddeaths
where continent is not null
order by 1,2;


-- Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from coviddeaths
where location like '%states%'
and where continent is not null
order by 1,2;


-- Looking at Total Cases vs Population
-- Shows what percentage of population got Covid

select location, date, total_cases, Population, (total_cases/population)*100 as PercentPopulationInfected
from coviddeaths
where location like '%states%'
order by 1,2;


-- Looking at Countries with Highest Infection Rate compared to Population

select location, Population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as
	PercentPopulationInfected
from coviddeaths
-- where location like '%states%'
group by location, population
order by PercentPopulationInfected desc;


-- LET'S BREAK THINGS DOWN BY CONTINENT


-- Showing continents with the highest death count per population

select continent, MAX(Total_deaths) as TotalDeathCount
from coviddeaths
-- where location like '%states%'
where continent is not null
group by continent
order by TotalDeathCount desc;


-- Global Numbers

select SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, 
	SUM(New_deaths)/SUM(New_Cases)*100 as DeathPercentage
from coviddeaths
-- where location like '%states%'
where continent is not null
-- group by date
order by 1,2;

-- Looking at Total Population vs Vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
-- , (RollingPeopleVaccinated/population)*100
From CovidDeaths dea
Join CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3;

-- USE CTE

with PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) over (partition by dea.Location order by dea.location, dea.Date)
	as RollingPeopleVaccinated
-- , (RollingPeopleVaccinated/population)*100
from coviddeaths dea
join covidvaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
-- order by 2,3;
)
select *, (RollingPeopleVaccinated/Population)*100
from PopvsVac


-- Creating View to store data for later visualizations

create view PercentPopulationVaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) over (partition by dea.Location order by dea.location, dea.Date)
	as RollingPeopleVaccinated
-- , (RollingPeopleVaccinated/population)*100
from coviddeaths dea
join covidvaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
-- order by 2,3;


select *
from PercentPopulationVaccinated
