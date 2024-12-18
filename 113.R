# 讀取 CSV 文件
export <- read_csv("臺北市企業營運總部分布圖.csv")

# 新增西元日期範圍欄位
export <- export |>
  mutate(
    # 確保 USEDATE 是字串格式
    USEDATE = as.character(USEDATE),
    
    # 分割台灣日期為起始與結束部分
    taiwan_start = str_sub(USEDATE, 1, 7),  # 提取起始日期部分
    taiwan_end = str_sub(USEDATE, 9, 15),  # 提取結束日期部分
    
    # 將台灣年份轉換為西元年份並替換日期中的年份部分
    western_start = str_replace(
      taiwan_start,
      "^\\d{3}",
      as.character(as.numeric(str_sub(taiwan_start, 1, 3)) + 1911)
    ),
    western_end = str_replace(
      taiwan_end,
      "^\\d{3}",
      as.character(as.numeric(str_sub(taiwan_end, 1, 3)) + 1911)
    ),
    
    # 合併轉換後的起始與結束日期
    western_USEDATE = paste0(western_start, "-", western_end)  # 格式為 yyyymmdd-yyyymmdd
  ) |>
  # 移除不必要的中間欄位
  select(-taiwan_start, -taiwan_end, -western_start, -western_end)

# 檢視處理後的資料
glimpse(export)
