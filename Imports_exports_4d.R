rm(list=ls())
dir <- setwd("D:/work/UoU/Semester 6/R")

####Unzip individual census import files into a folder

library(plyr)
zipF <- list.files(path = "D:/work/UoU/Second paper/Imports_exports_Schott/Exports_4d", pattern = "*.zip", full.names = TRUE)
ldply(.data = zipF, .fun = unzip, exdir = "D:/work/UoU/Second paper/Imports_exports_Schott/Exports_4d")
detach("package:plyr",unload=TRUE)


######Save each file onto the directory (Here you can choose to have it as excel file or dta)
dir <- setwd("D:/work/UoU/Second paper/Imports_exports_Schott/Exports_4d")
in_files <- list.files(path="D:/work/UoU/Second paper/Imports_exports_Schott/Exports_4d", pattern = "exp_detl_yearly_[0-9]*n.dta", full.names = TRUE)
in_files <- setNames(in_files, in_files)

library(xlsx)
###Loops over each file and creates .xlsx files for import
for (filename in in_files) {
  data <- read_dta(filename)
  data$naics3d <-substr(data$naics,1,4)
  df_summed <- data %>% 
    group_by(naics3d) %>% 
    summarize(v_imports = 
                sum(gen_val_yr),year=mean(year))
  write_xlsx(df_summed, paste(filename,".xlsx"))}


####Unzip individual census export files into a folder

library(plyr)
zipF <- list.files(path = "D:/work/UoU/Second paper/Imports_exports_Schott/Exports_4d", pattern = "*.zip", full.names = TRUE)
ldply(.data = zipF, .fun = unzip, exdir = "D:/work/UoU/Second paper/Imports_exports_Schott/Exports_4d")
detach("package:plyr",unload=TRUE)

dir <- setwd("D:/work/UoU/Second paper/Imports_exports_Schott/Exports_4d")
in_files <- list.files(path="D:/work/UoU/Second paper/Imports_exports_Schott/Exports_4d", pattern = "exp_detl_yearly_[0-9]*n.dta", full.names = TRUE)
in_files <- setNames(in_files, in_files)
##data <- read_dta("exp_detl_yearly_98n.dta")
###Loops over each file and creates .xlsx files for exports

library(xlsx)
for (filename in in_files) {
  data <- read_dta(filename)
  data$naics3d <-substr(data$naics,1,4)
  df_summed <- data %>% 
    group_by(naics3d) %>% 
    summarize(v_exports = 
                sum(all_val_yr),year=mean(year))
  write_xlsx(df_summed, paste(filename,".xlsx"))}