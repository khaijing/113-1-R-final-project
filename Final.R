install.packages("tidyverse")

install.packages("remotes")

remotes::install_github("tpemartin/ntpuR")

library(ntpuR)
setup_github_personal_access_token

library(readr)
data <- read_csv("政府行政機關辦公日曆表_export.csv")
 

library(tidyverse)

data <- data %>%
  rename(
    日期 = date,
    年份 = year,
    名稱 = name,
    是否為假日 = isholiday,
    假日類別 = holidaycategory,
    描述 = description
  )

print(data)

data <- data %>%
  mutate(年份 = 年份 - 1911)

print(data)
