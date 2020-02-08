install.packages('renv')
renv::consent()
renv::install("mlbgameday")
#renv::install("pitchRx")
library(mlbgameday)
library(renv)
#library(pitchRx)
library(DBI)
renv::install("odbc")
library(odbc)
odbc <- dbConnect(RODBCDBI::ODBC(), dsn = "PostgreSQL")
dat <- scrape(start = "2013-08-01", end = "2013-08-01", async = TRUE)
dat
names(dat)
dim(dat[["pitch"]])
data(gids, package = 'pitchRx')
head(gids)


files <- c("miniscoreboard.xml", "players.xml", "inning/inning_hit.xml")
scrape(start = "2008-01-01", end = Sys.Date(), suffix = files, connect = db$con)
con <- DBI::dbConnect(odbc::odbc(),
                      Driver   = "postgres",
                      Server   = "postgres",
                      Database = "postgres",
                      UID      = rstudioapi::askForPassword("Database user"),
                      PWD      = rstudioapi::askForPassword("Database password"),
                      Port     = 5432)
