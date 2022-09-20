select * from Covid_Deaths$
order by 3,4

select * from Covid_Vaccinations$
order by 3,4

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM Covid_Deaths$
order by 1,2

-- TOTAL CASES VS TOTAL DEATHS
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 AS deathpercentage
FROM Covid_Deaths$
order by 1,2

-- TOTAL CASES VS POPULATION
SELECT location, date, total_cases, population, (total_cases/population) * 100 AS casespercentage
FROM Covid_Deaths$
order by 1,2

-- Countries with Highest Infection Rate compared to Population
Select Location, Population, MAX(total_cases) as highestinfectioncount,  Max((total_cases/population))*100 as percentpopulationinfected
From Covid_Deaths$
Group by Location, Population
order by percentpopulationinfected desc

-- Countries with lowest Infection Rate compared to Population
Select Location, Population, MAX(total_cases) as lowestinfectioncount,  MAX((total_cases/population))*100 as percentpopulationinfected
From Covid_Deaths$
Group by Location, Population
order by percentpopulationinfected asc

-- Countries with Highest Death Count per Population
Select Location, MAX(cast(Total_deaths as int)) as HighestTotalDeathCount
From Covid_Deaths$
Where continent is not null 
Group by Location
order by HighestTotalDeathCount desc

-- Countries with Lowest Death Count per Population
Select Location, MAX(cast(Total_deaths as int)) as LowestTotalDeathCount
From Covid_Deaths$
Where continent is not null 
Group by Location
order by LowestTotalDeathCount

-- Showing contintents with the highest death count per population
Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From Covid_Deaths$
Where continent is not null 
Group by continent
order by TotalDeathCount desc

-- Showing contintents with the Lowest death count per population
Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From Covid_Deaths$
Where continent is not null 
Group by continent
order by TotalDeathCount 

-- GLOBAL NUMBERS
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From Covid_Deaths$
where continent is not null 
order by 1,2

-- Total population vs Vaccinations
-- population received atleast one covid vaccine
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From Covid_Deaths$ dea
Join Covid_Vaccinations$ vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3

