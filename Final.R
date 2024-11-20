install.packages("tidyverse")

install.packages("remotes")

remotes::install_github("tpemartin/ntpuR")

library(ntpuR)
setup_github_personal_access_token

library(readr)
data <- read_csv("政府行政機關辦公日曆表_export.csv")
 
