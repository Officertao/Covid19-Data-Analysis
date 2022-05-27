select *
from [portfolio project]..CovidDeathvaccines
order by 3,4


select *
from [portfolio project]..CovidDeathinfo
order by 3,4


--select Data that we are going to be using

select location, date, total_Cases, new_cases, total_deaths,population
from [portfolio project]..CovidDeathinfo
order by 1,2

--we are looking at total_cases vs total_death
--This shows the percentage of dead people from the total cases

select location, date, total_Cases, total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
from [portfolio project]..CovidDeathinfo
Where location like '%States%'
order by 1,2

--We are looking at total_deaths vs populations
--Shows percentage of population that got covid
select location, date,population, total_Cases,(total_cases/population)*100 as  percentPopulationInfected
from [portfolio project]..CovidDeathinfo
Where location like '%States%'
order by 1,2

--Looking at country with highest infection rate compare to population

select location,population, Max(total_Cases) as HighestinfectionCounts,Max((total_cases/population))*100 as percentPopulationInfected
from [portfolio project]..CovidDeathinfo
--Where location like '%States%'
Group by location,population
order by  percentPopulationInfected desc

--we are looking at total death per population

select location,population, Max(cast(total_deaths as Int)) as TotalDeathCounts
from [portfolio project]..CovidDeathinfo
--Where location like '%States%'
where continent is not Null
Group by location,population
order by  TotalDeathCounts desc

--let's break things down by continent

select location, Max(cast(total_deaths as Int)) as TotalDeathCounts
from [portfolio project]..CovidDeathinfo
--Where location like '%States%'
where continent is  Null
Group by location
order by  TotalDeathCounts desc

--Global Numbers

select, Max(cast(total_deaths as Int)) as TotalDeathCounts
from [portfolio project]..CovidDeathinfo
--Where location like '%States%'
where continent is  Null
Group by location
order by  TotalDeathCounts desc

select Sum(new_Cases) as total_cases,Sum(Cast(new_Deaths as int)) as total_death, Sum(Cast(new_Deaths as int))/(Sum(new_Cases)*100 as Deathpercent
from [portfolio project]..CovidDeathinfo
where continent is not Null
order by 1,2

Select location, Sum(Cast(new_deaths as int)) as totaldeathcounts
from [portfolio project]..CovidDeathinfo
where continent is Null
and location not in ('world', 'international', 'European union')
Group by location
order by totaldeathcounts desc