install.packages("tidyverse")

install.packages("remotes")

remotes::install_github("tpemartin/ntpuR")

library(ntpuR)
setup_github_personal_access_token

library(readr)
data <- read_csv("政府行政機關辦公日曆表_export.csv")
 
glimpse(data)

data <- data %>%
  mutate(
    date = as.character(date)
  )

data <- data %>%
  mutate(`year` = `year` - 1911)

print(data)

print(holiday_categories)

data <- data %>%
  mutate(
    holidaycategory = factor(
      holidaycategory,
      levels = c("放假之紀念日及節日", "星期六、星期日", "補行上班日", "補假", "調整放假日"),
      ordered = TRUE
    )
)

result_dates <- data %>%
  filter(holidaycategory == "星期六、星期日") %>% # 筛选出“星期六、星期日”的记录
  select(date) # 选择日期列

result_dates

result <- data %>%
  mutate(
    is_saturday_sunday = if_else(holidaycategory == "星期六、星期日", "yes", "no")
  ) %>%
  count(is_saturday_sunday, name = "count")

result
