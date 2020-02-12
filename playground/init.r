renv::consent()
renv::install("mlbgameday")
renv::install("odbc")

library(mlbgameday)
library(renv)
library(DBI)
library(odbc)
library(doParallel)
require("RPostgreSQL")

# multi_core
no_cores <- detectCores() - 2
cl <- makeCluster(no_cores)
registerDoParallel(cl)


#con <- DBI::dbConnect(RPostgreSQL::PostgreSQL(), dbname = "mlb_test",
#                      host = "172.28.1.2", port = 5432,
#                      user = "postgres", password = "postgres")

#dat <- get_payload(start = "2013-08-01", end = "2013-08-01", async = TRUE)
#dat <- get_payload(start = "2017-01-01", end = "2017-12-31", async = TRUE)

con2017 <- DBI::dbConnect(RPostgreSQL::PostgreSQL(), dbname = "mlb_2017",
                          host = "172.28.1.2", port = 5432,
                          user = "postgres", password = "postgres")
get_payload(start = "2017-01-01", end = "2017-12-31", async = TRUE, db_con=con2017)

con2018 <- DBI::dbConnect(RPostgreSQL::PostgreSQL(), dbname = "mlb_2018",
                          host = "172.28.1.2", port = 5432,
                          user = "postgres", password = "postgres")
get_payload(start = "2018-01-01", end = "2018-12-31", async = TRUE, db_con=con2018)

con2019 <- DBI::dbConnect(RPostgreSQL::PostgreSQL(), dbname = "mlb_2019",
                      host = "172.28.1.2", port = 5432,
                      user = "postgres", password = "postgres")
get_payload(start = "2019-01-01", end = "2019-12-31", async = TRUE, db_con=con2019)

con2016 <- DBI::dbConnect(RPostgreSQL::PostgreSQL(), dbname = "mlb_2016",
                          host = "172.28.1.2", port = 5432,
                          user = "postgres", password = "postgres")
get_payload(start = "2016-01-01", end = "2016-12-31", async = TRUE, db_con=con2016)

con2015 <- DBI::dbConnect(RPostgreSQL::PostgreSQL(), dbname = "mlb_2015",
                          host = "172.28.1.2", port = 5432,
                          user = "postgres", password = "postgres")
get_payload(start = "2015-01-01", end = "2015-12-31", async = TRUE, db_con=con2015)
con2014 <- DBI::dbConnect(RPostgreSQL::PostgreSQL(), dbname = "mlb_2014",
                          host = "172.28.1.2", port = 5432,
                          user = "postgres", password = "postgres")
get_payload(start = "2014-01-01", end = "2014-12-31", async = TRUE, db_con=con2014)



library(mlbgameday)
library(dplyr)

# Grap some Gameday data. We're specifically looking for Jake Arrieta's no-hitter.
gamedat <- get_payload(start = "2016-04-21", end = "2016-04-21")

# Subset that atbat table to only Arrieta's pitches and join it with the pitch table.
pitches <- inner_join(gamedat$pitch, gamedat$atbat, by = c("num", "url")) %>%
  subset(pitcher_name == "Jake Arrieta")
library(ggplot2)

# basic example
ggplot() +
  geom_point(data=pitches, aes(x=px, y=pz, shape=type, col=pitch_type)) +
  coord_equal() + geom_path(aes(x, y), data = mlbgameday::kzone)
