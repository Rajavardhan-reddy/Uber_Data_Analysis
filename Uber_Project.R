getwd();
April <- read.csv("C:/Users/rajav/OneDrive/Desktop/uber-raw-data-apr14.csv");
May  <- read.csv("C:/Users/rajav/OneDrive/Desktop/uber_May14.csv");
June <- read.csv("C:/Users/rajav/OneDrive/Desktop/uber-raw-data-jun14.csv");
July  <- read.csv("C:/Users/rajav/OneDrive/Desktop/uber-raw-data-jul14.csv");
August  <- read.csv("C:/Users/rajav/OneDrive/Desktop/uber-raw-data-aug14.csv");
September  <- read.csv("C:/Users/rajav/OneDrive/Desktop/uber-raw-data-sep14.csv");

Combined_Data <- rbind(April,May,June,July,August,September);
View(Combined_Data);
str(Combined_Data);
#install.packages("ggplot2");
#install.packages("ggthemes");
#install.packages("lubirdate")
#install.packages("dplyr");
#install.packages("tidyr");
#install.packages("tidyverse")
#install.packages("DT");
#install.packages("scales");

library(ggplot2)
library(ggthemes)
library(lubridate)
library(dplyr)
library(tidyr)
library(DT)
library(scales)

colors <- c("#CC1011", "#665555", "#05a399", "#cfcaca", "#f5e840", "#0683c9", "#e075b0");
head(Combined_Data);

Combined_Data$Date.Time <- as.POSIXct(Combined_Data$Date.Time, format = "%m/%d/%Y %H:%M:%S");
Combined_Data$Time <- format(as.POSIXct(Combined_Data$Date.Time, format = "%m/%d/%Y %H:%M:%S"), format="%H:%M:%S");
Combined_Data$Date.Time <- ymd_hms(Combined_Data$Date.Time);           
head(Combined_Data);
Combined_Data$day <- factor(day(Combined_Data$Date.Time));
Combined_Data$month <- factor(month(Combined_Data$Date.Time, label = TRUE))
Combined_Data$year <- factor(year(Combined_Data$Date.Time))
Combined_Data$dayofweek <- factor(wday(Combined_Data$Date.Time, label = TRUE))


Combined_Data$hour <- factor(hour(hms(Combined_Data$Time)));
Combined_Data$minute <- factor(minute(hms(Combined_Data$Time)));
Combined_Data$second <- factor(second(hms(Combined_Data$Time)));

hour_data <- Combined_Data %>%
  group_by(hour) %>%
  dplyr::summarize(Total = n()) 
datatable(hour_data)

ggplot(hour_data, aes(hour, Total)) + 
  geom_bar( stat = "identity", fill = "steelblue", color = "red") +
  ggtitle("Trips Every Hour") +
  theme(legend.position = "none",plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust =0.5))+scale_y_continuous(labels = comma);