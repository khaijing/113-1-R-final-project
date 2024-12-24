# 讀取 CSV 文件
export <- read_csv("臺北市企業營運總部分布圖.csv")

export <- export |> 
  mutate(
    western_year = str_sub(USEDATE, 1, 3) |> 
      as.numeric() + 1911, # 提取前3位年份並加上1911
    western_date = str_replace(USEDATE, "^\\d{3}", as.character(western_year)) # 用西元年取代台灣年
  )|> 
select(-western_year) # 如果不需要保留 `western_year` 欄位，可以刪除
print(export)

export <- export |> 
  mutate(
    district = str_extract(ADDR, "(?<=市).+?區") # 匹配市和區之間的文字
  )

glimpse(export[1:2,])

