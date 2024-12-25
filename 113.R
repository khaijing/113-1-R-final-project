export <- readr::read_csv("臺北市企業營運總部分布圖.csv")

view(export)

# 假設資料框名稱為 export
export <- export |>
  dplyr::mutate(
    # 分割起始日期與結束日期
    start_date = stringr::str_sub(USEDATE, 1, 7),
    end_date = stringr::str_sub(USEDATE, 9, 15),
    # 提取年份並轉換為西元年份
    start_year = as.numeric(stringr::str_sub(start_date, 1, 3)) + 1911,
    end_year = as.numeric(stringr::str_sub(end_date, 1, 3)) + 1911,
    # 替換年份並組合為西方日期格式
    western_start_date = stringr::str_c(start_year, stringr::str_sub(start_date, 4, 7)),
    western_end_date = stringr::str_c(end_year, stringr::str_sub(end_date, 4, 7)),
    # 組合完整範圍日期
    `western usedate` = stringr::str_c(western_start_date, "-", western_end_date)
  ) |>
  dplyr::select(-start_date, -end_date, -start_year, -end_year, -western_start_date, -western_end_date)

# 查看結果
print(export)

export <- export |> 
  mutate(
    district = str_extract(ADDR, "(?<=市).+?區")
  )

print(export)

district_data <- export |> 
  dplyr::filter(district == "中山區")

glimpse(district_data)

district_count <- export |> 
  dplyr::filter(district %in% c("中山區", "內湖區", "大同區", "信義區", "北投區", "士林區", "大安區", "南港區", "松山區", "中正區")) |> 
  dplyr::count(district) |> 
  dplyr::rename(數量 = n)

glimpse(district_count)

library(ggplot2)

district_count <- export |> 
  dplyr::filter(district %in% c("中山區", "內湖區", "大同區", "信義區", "北投區", "士林區", "大安區", "南港區", "松山區", "中正區")) |> 
  dplyr::count(district) |> 
  dplyr::rename(數量 = n)

ggplot(district_count, aes(x = district, y = 數量, fill = district)) +
  geom_bar(stat = "identity") +
  labs(title = "各區域的數量分佈", x = "區域", y = "數量") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

glimpse(export[1:2,])
