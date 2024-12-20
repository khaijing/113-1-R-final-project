# 讀取 CSV 文件
export <- read_csv("臺北市企業營運總部分布圖.csv")

USEDATE <- as.character(USEDATE)

library(stringr)

# 假設 USEDATE 是資料框中的一列
USEDATE <- c("1130909-1131010", "1121231-1130101") # 示例數據

# 將年份和日期分開處理
western_USEDATE <- str_replace_all(USEDATE, "(\\d{3})(\\d{4})-(\\d{3})(\\d{4})", function(x) {
  year1 <- as.numeric(substr(x, 1, 3)) + 1911
  year2 <- as.numeric(substr(x, 11, 13)) + 1911
  sprintf("%d%s-%d%s", year1, substr(x, 4, 7), year2, substr(x, 14, 17))
})

# 查看結果
western_USEDATE

glimpse(export)

library(dplyr)

# 確保 CATEGORY 是字符型，並處理 NA
filtered_export <- export |> 
  filter(!is.na(CATEGORY) & str_detect(as.character(CATEGORY), "民生化工類"))

glimpse(filtered_export)

library(dplyr)
library(stringr)

export <- export |> 
  mutate(extracted_area = str_extract(ADDR, "(?<=市).*?區"))

glimpse(export)

export <- export |> 
  select(-city_area)

glimpse(export)

glimpse(export[1:3,])

