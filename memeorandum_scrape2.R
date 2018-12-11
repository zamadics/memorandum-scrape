# Memeoradum
# http://www.memeorandum.com
# begin in 2006
setwd("C:/Users/Joe/Dropbox/Bethany/Data/memeorandum")
library(rvest)

main <- "http://www.memeorandum.com/"

start.day <- 1
start.month <- 1
start.year <- 1

years <- c("06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16")
months <- c("01","02","03","04","05","06", "07", "08", "09", "10", "11", "12")
days <- c("01/","02/","03/","04/","05/","06/","07/","08/","09/","10/","11/","12/","13/",
          "14/","15/","16/","17/","18/","19/","20/","21/","22/","23/","24/","25/","26/",
          "27/","28/","29/","30/","31/")
hour.am <-"h0900"
hour.pm <- "h1700"

final_results <- matrix(NA, nrow = 1, ncol = 6)

for(j in start.year:length(years)){
  stuff <- matrix(NA, nrow = 1, ncol = 6)
  
  for(x in start.month:length(months)){
    monthstuff <- matrix(NA, nrow = 1, ncol = 6)
    
    for(i in start.day:length(days)){  
      main <- "http://www.memeorandum.com/"
      main.am <- paste0(main, years[j], months[x], days[i], hour.am)
      main.pm <- paste0(main, years[j], months[x], days[i], hour.pm)
      
      
      try(text.am <- read_html(main.am) %>% html_nodes(".ii") %>%  html_text(), silent = T) 
      try(source.am <- read_html(main.am) %>% html_nodes("cite a") %>%  html_text(), silent = T)
      try(text.pm <- read_html(main.pm) %>% html_nodes(".ii") %>%  html_text(), silent = T) 
      try(source.pm <- read_html(main.pm) %>% html_nodes("cite a") %>%  html_text(), silent = T) 
      
      
      
      output.am <- matrix(NA, nrow = 1, ncol = 6)
      output.am[,1] <- text.am[1]
      output.am[,2] <- years[j]
      output.am[,3] <- months[x]
      output.am[,4] <- days[i]
      output.am[,5] <- hour.am
      output.am[,6] <- source.am[1]
      
      output.pm <- matrix(NA, nrow = 1, ncol = 6)
      output.pm[,1] <- text.pm[1]
      output.pm[,2] <- years[j]
      output.pm[,3] <- months[x]
      output.pm[,4] <- days[i]
      output.pm[,5] <- hour.pm
      output.pm[,6] <- source.pm[1]
      
      stuff <- rbind(stuff, output.am, output.pm)
      print(i)
    }
    monthstuff <- rbind(monthstuff, stuff)
    print("this month finished:")
    print(j+2005)
    print(x)
  }
  final_results <- rbind(final_results, monthstuff)
  print("this year finished:")
  print(j+2005)
}

write.csv(final_results, file = "trial4.csv")
