# Santa Barbara - Coding in R
# created on: 12 august 2024
# created on: alj
# edited on: 17 august 2024
# edited by: alj 

# version 4.3.2
# packages used
### arrow 
### dplyr
### ggplot2

library("arrow")
library("dplyr")
library("ggplot2")

# create folders
# folder: data, folder: output
dir.create("data")
dir.create("output")

# let's get some data
install.packages("arrow")
library(arrow)

merged_data <- read_parquet(file = "data/merged_data.parquet", stringsAsFactors = TRUE)

# function (read_parquet): two pieces of information 
### 1. the file, tells R where to find it
### 2. stringsAsFactors, tells R how to treat text data 
### text as categorical data 

# variable name <- function name (function arguments)

head(merged_data)
# head shows you the first six rows of data 
tail(merged_data)
# tail shows you the last six rows of data

# something to look out for <NA>
# <NA> designates a missing value
# missing data require special handling 

# counted the number of NA values
sum(is.na(merged_data))
### 76081507
# dropped any row with missing data
# merged_data <- na.omit(merged_data)
### it dropped everything 
### went above to get data back 

# structure of data
str(merged_data)

# subsetting data 
# look at a single state
az_keep_r <- subset(merged_data, STATE_ABBR_2010SVI == "AZ")

# this shows an example of not working 
# az_keep <- c("AZ)
### this did it almost backwards? not what i was intending!
# subset_data_az <- merged_data[merged_data$STATE_ABBR_2010SVI %in% az_keep]
### because the piece above didn't work, this command won't work 
# subset_data_az <- merged_data[merged_data$state_ABBR_2010SVI %in% az_keep]
### this doesn't work because state is in lowercase in the variable name
### but notice that if you run it, it will replace what you do have
### that is, it will still WORK, just not do anything
### so make sure you're reviewing what your code does 

# what have we done?
### we created a list of AZ
### made a new data called subset arizona and stored that data 

# our original data are unchanged!

# summary 
summary(az_keep_r)
# for columns with categorical data: how many rows in each category
# for columns with numerical data: provides some statistics 
# we've got so much, i find it hard to process 

# summary statistics for groups of data 
# upward mobility 
upward_mean_2010_az <- mean(az_keep_r$upward_mobility_rate_2010)
upward_sd_2010_az <- sd(az_keep_r$upward_mobility_rate_2010)
upward_mean_2020_az <- mean(az_keep_r$upward_mobility_rate_2020)
upward_sd_2020_az <- sd(az_keep_r$upward_mobility_rate_2020)

# create a new subset dataset with just CA
# then create the same summary stats for CA

ca_keep_r <- subset(merged_data, STATE_ABBR_2010SVI == "CA")
upward_mean_2010_ca <- mean(ca_keep_r$upward_mobility_rate_2010)
upward_sd_2010_ca <- sd(ca_keep_r$upward_mobility_rate_2010)
upward_mean_2020_ca <- mean(ca_keep_r$upward_mobility_rate_2020)
upward_sd_2020_ca <- sd(ca_keep_r$upward_mobility_rate_2020)

# rm
# removes a value (or other entity) that you might not want 
# create something we don't want
# and then remove it 
upward_mean = mean(merged_data$upward_mobility_rate_2010)
rm(upward_mean)

# data subset within a call 
pima_upward_mean_2010_az <- mean(az_keep_r$upward_mobility_rate_2010
                                 [az_keep_r$COUNTY_2010SVI == "Pima County"])
pima_upward_sd_2010_az <- sd(az_keep_r$upward_mobility_rate_2010
                             [az_keep_r$COUNTY_2010SVI == "Pima County"])

delnorte_upward_mean_2010_ca <- mean(ca_keep_r$upward_mobility_rate_2010
                                     [ca_keep_r$COUNTY_2010SVI == "Del Norte County"])
delnorte_upward_sd_2010_ca <- sd(ca_keep_r$upward_mobility_rate_2010
                                     [ca_keep_r$COUNTY_2010SVI == "Del Norte County"])

install.packages("dplyr")
library("dplyr")
### you need to install the package once
### but you need to call it from the library every time you want to use it
### the FIRST time you want to use it

summary_stats_upward_2010_az <- az_keep_r %>%
  group_by(COUNTY_2010SVI) %>%
  summarize(mean_mobility_2010_az = mean(upward_mobility_rate_2010),
            sd_mobility_2010_az = sd(upward_mobility_rate_2010))

# think about replacing the %>% with the word "then"
# summary_stats_upward_2010_az <- az_keep_r then
# group_by(COUNTY_2010SVI) then
# summarize(mean_mobility_2010_az = mean(upward_mobility_rate_2010),
# sd_mobility_2010_az = sd(upward_mobility_rate_2010))

# and in just words
# make a new variable called "summary_stats_upward_2010_az)",
# take the subset data from arizona, then
# calculate the mean and standard deviation for the upward mobility figures
# store them in the columns called
# mean_mobility_2010_az and sd_mobility_2010_az 

head(summary_stats_upward_2010_az)

install.packages("ggplot2")
library("ggplot2")

mobility_plot <- ggplot(data = summary_stats_upward_2010_az,
                        mapping = aes(x = COUNTY_2010SVI, 
                                      y = mean_mobility_2010_az)) +
  geom_boxplot() 
print(mobility_plot)

# new plot called mobility_plot
# function ggplot - the function for making graphics in ggplot2
# giving R two pieces of information:
### 1. data - telling R which data to use (summary_stats_upward_2010_az)
### 2. mapping - telling R which variable to put on which axis 
# we then have to tell R to plot the data geom_boxplot 
# print: tell R to print 

summary_stats_upward_2010_all <- merged_data %>% 
  group_by(STATE_ABBR_2010SVI, COUNTY_2010SVI) %>%
  summarize(mean_mobility_2010 = mean(upward_mobility_rate_2010),
            sd_mobility_2010 = sd(upward_mobility_rate_2010))

mobility_plot <- ggplot(data = summary_stats_upward_2010_all,
                        mapping = aes(x = STATE_ABBR_2010SVI, 
                                      y = mean_mobility_2010)) +
  geom_boxplot()
print(mobility_plot)

summary_stats_upward_2010_all <- 
  summary_stats_upward_2010_all[!(summary_stats_upward_2010_all
                                  $STATE_ABBR_2010SVI 
                                  %in% c(NA)),]

summary_stats_upward_2010_all <- summary_stats_upward_2010_all %>% 
  filter(!is.na(STATE_ABBR_2010SVI))

# run plot again
# from line 164 

ggsave(plot = mobility_plot, filename = 
         "output/mobility-plot-2010.pdf")

# LESSON 1 OBJECTIVES
### 1. understanding the difference between files and objects
### 2. modify data 
### 3. summarized information from raw data
### 4. visualized data to convey information 