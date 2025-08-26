select *
from [PORTFOLIO PROJECT]..coviddeaths

insert into [PORTFOLIO PROJECT]..coviddeaths

values ('China','Asia','1416251616','503302','28567','10946987','5678','930057','56789','90543','54875','987')

update [PORTFOLIO PROJECT]..covidrecovered
set NewRecovered = '0' where NewRecovered is null

insert into [PORTFOLIO PROJECT]..covidrecovered
values ('China', 'Asia', '1412175000', '379053', '0')

UPDATE [PORTFOLIO PROJECT]..CovidDeaths
SET TotalCases = '99381761' WHERE Location = 'China'

UPDATE [PORTFOLIO PROJECT]..CovidDeaths
SET TotalTests = '3993817061' WHERE Location = 'China'

select *
from [PORTFOLIO PROJECT]..covidrecovered
--where Location = 'China'
order by 1

--display of the data that i will be using
select Location, TotalCases, NewCases, TotalDeaths, NewDeaths, ActiveCases, population
from [PORTFOLIO PROJECT]..coviddeaths
order by 7 desc

--working on total cases vs total deaths

--select Location, TotalCases,TotalDeaths, (totaldeaths/totalcases)*100 as Death_percentage
--from [PORTFOLIO PROJECT]..coviddeaths
--where location like '%Nigeria%'
--order by 4

--DEATH PERCENTAGE PER COUNTRY----shows likehood of dying of covid in your country
select Location, TotalCases,TotalDeaths, (totaldeaths/totalcases)*100 as Death_percentage
from [PORTFOLIO PROJECT]..coviddeaths
where (totaldeaths/totalcases)*100 is not null
order by 4 desc

----looking at total cases vs the population AND PERCENTAGE OF POPULATION AFFECTED

--select Location, TotalCases,population, (totalcases/population)*100 as Percentage_of_Population_infected
--from [PORTFOLIO PROJECT]..coviddeaths
--WHERE LOCATION IS NOT NULL
--order by Percentage_of_Population_infected desc


--Countries with Highest Infection rate compared to Population
select Location, Population, max(TotalCases) as Highest_Infection_Count, max((totalcases/population))*100 as Percentage_of_Population_infected
from [PORTFOLIO PROJECT]..coviddeaths
group by Location, Population
order by Percentage_of_Population_infected desc


--Showing Countries With Highest Death Count per Population

--select Location, max(TotalDeaths) as Total_Death_Count
--from [PORTFOLIO PROJECT]..coviddeaths
--group by Location
--order by Total_Death_Count desc


--Showing Total Death Count per Continent
select Continent, sum(TotalDeaths) as 'Sum_Of_Death_Count'
from [PORTFOLIO PROJECT]..coviddeaths
WHERE CONTINENT IS NOT NULL
group by Continent
order by Sum_Of_Death_Count desc



--Showing Continents With Highest Death Count per Population vs Continent Population Sum

select Continent, sum(TotalDeaths) as Total_Death_Count_Continent, SUM(population) as Population_Sum, (SUM(TOTALDEATHS)/SUM(POPULATION))*100 AS Death_Percentage_By_Continent
from [PORTFOLIO PROJECT]..coviddeaths
where Continent is not null
group by Continent
order by (SUM(TOTALDEATHS)/SUM(POPULATION))*100 desc

--Looking for Critical Cases vs Total cases and Percentage_Of_Critical_Cases_By_Location

--select Location, TotalCases, CriticalCases, (CriticalCases/TotalCases)*100 AS Percentage_Of_Critical_Cases_By_Location
--from [PORTFOLIO PROJECT]..coviddeaths
--WHERE CriticalCases IS NOT NULL
--order by Percentage_Of_Critical_Cases_By_Location desc


--Looking for  Critical Cases vs Total cases by location


--select Location, TotalCases, CriticalCases
--from [PORTFOLIO PROJECT]..coviddeaths
--where CriticalCases is not null
--order by 1,2,3



select *
from [PORTFOLIO PROJECT]..coviddeaths
where Location = 'China'

--This is showing the percentage of Persons tested positive per location
select Location, TotalTests,TotalCases,(TotalCases/TotalTests)*100 as Percentage_Of_Positive_test_per_Location
from [PORTFOLIO PROJECT]..coviddeaths
WHERE (TotalCases/TotalTests)*100 IS NOT NULL
group by Location, TotalTests,TotalCases
order by Percentage_Of_Positive_test_per_Location desc



--GLOBAL NUMBERS

--This Shows The Global Figure for Total Cases And Total Deaths

select SUM(TotalCases) as Total_Cases, SUM(totaldeaths) as Total_Deaths
from [PORTFOLIO PROJECT]..coviddeaths
--group by Location
order by Total_Cases desc

--Code Below shows the Global Death Percentage
select SUM(TotalCases) as Total_Cases, SUM(totaldeaths) as Total_Deaths, sum(totaldeaths)/sum(totalcases)*100 as Global_Death_Percentage
from [PORTFOLIO PROJECT]..coviddeaths
--group by Location
order by Total_Cases desc


select * from [PORTFOLIO PROJECT]..CovidRecovered

--TABLE DEATHS AND RECOVERED JOINED FROM HERE ON

--Looking for total cases vs total recovered by location(country)
select dea.Location,dea.Population,dea.TotalCases, rec.TotalRecovered
from [PORTFOLIO PROJECT]..CovidRecovered rec
join [PORTFOLIO PROJECT]..CovidDeaths dea
on rec.Location = dea.Location
order by TotalRecovered desc


--Looking for percentage of Persons recovered by Location (country)

select dea.Location,dea.Population,dea.TotalCases, rec.TotalRecovered, (TotalRecovered/TotalCases)*100 as Percentage_of_Recovered_by_Country
from [PORTFOLIO PROJECT]..CovidRecovered rec
join [PORTFOLIO PROJECT]..CovidDeaths dea
on rec.Location = dea.Location
order by Percentage_of_Recovered_by_Country desc


--Code Below shows the Global Recovered Percentage

select 
sum(dea.Population) as Sum_Of_Population,
sum(dea.TotalCases) as Sum_Of_TotalCases,
sum(rec.TotalRecovered) as Sum_of_TotalRecovered,
sum(TotalRecovered)/sum(TotalCases)*100 as Percentage_of_Global_Recovery
from [PORTFOLIO PROJECT]..CovidRecovered rec
join [PORTFOLIO PROJECT]..CovidDeaths dea
on rec.Location = dea.Location



--select *
--from [PORTFOLIO PROJECT]..CovidDeaths


--CREATING VIEW TO STORE DATA FOR FUTURE VISUALIZATIONS

create view Percentage_of_Recovered_by_Country as
select dea.Location,dea.Population,dea.TotalCases, rec.TotalRecovered, (TotalRecovered/TotalCases)*100 as Percentage_of_Recovered_by_Country
from [PORTFOLIO PROJECT]..CovidRecovered rec
join [PORTFOLIO PROJECT]..CovidDeaths dea
on rec.Location = dea.Location
--order by 5 desc


