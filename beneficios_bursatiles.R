#load libs

library(tidyverse)
library(rvest)
library(janitor)

#url where data are found

url <- 'https://www.moneycontrol.com/stocks/marketstats/nse-gainer/nifty-500_7/'

#obtain html 

url_html <- read_html(url)

#table extraction

url_tables <- url_html %>% html_table(fill = TRUE)

#extract relevant table

top_gainers <- url_tables[[2]]

#extract relevant columns

top_gainers %>%
  select(1:7) -> top_gainers

top_gainers %>% 
  clean_names() -> top_gainers

top_gainers %>%
  filter(!is.na(low)) -> top_gainers

top_gainers %>%
  separate(company_name,
           into = 'company_name',
           sep = '\t') -> top_gainers           
           
 write_csv(top_gainers,paste0('data/',Sys.Date(),'_top_gainers_500','.csv'))

