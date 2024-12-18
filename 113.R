library(readr)
data <- read_csv("政府行政機關辦公日曆表_export.csv")

glimpse(data)

# Assuming you have a column `year` in a data frame named `data`

data <- data %>%
  mutate(
    year= year - 1911
  )

print(data)

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

data <- data %>%
  mutate (date = ymd(date),  # 将数字格式的日期转换为日期类型
         date = format(date, "%Y %b %d"))  # 转换为 "yyyy MMM dd" 格式

print(data)

