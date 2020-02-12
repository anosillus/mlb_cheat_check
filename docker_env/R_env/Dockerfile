FROM rocker/tidyverse

# Change environment to Japanese(Character and DateTime)
RUN apt-get update && \
    apt-get install -y \
    fonts-ipafont fonts-ipaexfont fonts-noto-cjk && \
    install2.r --error \
    --deps TRUE \
    DBI \
    odbc \
    RPostgres \
    doParallel \
    feather \
    lintr \
    renv \
    mlbgameday
