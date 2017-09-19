
##This code is to convert the labnames database into a long format to be run in the shiny app LABNAMES

library(reshape2)
data <- read.csv("labname.csv", stringsAsFactors = FALSE)
dim(data)

#first we clean the dataframe to just the rows and columns with information
data[data==""]<-NA
data[,9:11]<-list(NULL)   #to remove columns with NA values
dat_wide<-na.omit(data)      #to remove NAs in rows


#now we convert from wide to long
data_long <- melt(dat_wide,
                  # ID variables - all the variables to keep but not split apart on
                  id.vars=c(names(dat_wide[,4:8])),
                  # The source columns
                  measure.vars=c(names(dat_wide[,1:3])),
                  # Name of the destination column that will identify the original
                  # column that the measurement came from
                  variable.name="Topic",
)
data_long<-data_long[!(data_long$value==0),]  #we only keep where the value==1 (where we had a 1 in the CC, Soc or Ec)

write.table(data_long, file="data_long", sep="\t", row.names=F) 
proba<-write.csv (data_long)


datalong<-dataFrame.to_csv
