getwd()
setwd("C:\\Users\\IDM LAB-02\\Desktop\\Shabbir_r")


getwd()
Util <- read.csv("machine utilization.csv", na.strings=c(""))
Util
head(Util)
tail(Util)
head(Util,17)
str(Util)
names(Util)
summary(Util)
Util$Utilization = 1- Util$Percent.Idle
?POSIXct
Util$posixtime <- as.POSIXct(Util$Timestamp, format = "%d/%m/%Y %H:%M")
str(Util)
Util$Timestamp <-NULL
Util<- Util[,c(4,1,2,3)]
RL1<- Util[Util$Machine=="RL1", ]
summary(RL1)
RL1$Machine <- factor(RL1$Machine)
summary(RL1)
util_stat_rl1 <- c(min(RL1$Utilization, na.rm=T),mean(RL1$Utilization, na.rm=T),max(RL1$Utilization, na.rm=T))
which(RL1$Utilization <0.90)
length(which(RL1$Utilization <0.90))
util_under_90_flag <- length(which(RL1$Utilization <0.90))>0
util_under_90_flag

list_rl1 <- list( "RL1", util_stat_rl1, util_under_90_flag ) #create list
list_rl1
#renaming component of list
names(list_rl1)
names(list_rl1) <- c("machine", "states", "lowthreshold")
names(list_rl1)

list_rl1
list_rl1[1]
list_rl1[[1]]
list_rl1$machine

list_rl1[2]
typeof(list_rl1)
#how  would you access  3rd element of vector states
list_rl1[[2]][3]
list_rl1$states[3]
#--addinng and deleting list component
list_rl1[4] <- "new information"
list_rl1$unknownhours <- RL1[is.na(RL1$Utilization), "posixtime"]
list_rl1

#---ADD DATAFRAME
list_rl1[4] <-NULL #NUMERATION GET SHIFTED
list_rl1$Data <-RL1
list_rl1
summary(list_rl1)


#subsetting list
list_rl1
list_rl1[[4]][1]#first value of 4 element
list_rl1$unknownhours[1]
list_rl1[1:3]#list contain 3 element
list_rl1[c(1,4)]
#double equire breaket are not for subsetting
#[] is for subsetting
#list_rl1[[1:3]]#error


#-----time series plot
install.packages("ggplot2")
library(ggplot2)
p<- ggplot(data=util)
p+geom_line(aes(x=posixtime, y=Utilization,colour= Machine ), size=1.2)+
  facet_grid(Machine~.)+
  geom_hline(yintercept = 0.90, colour="Grey", size=1.2, linetype=3)
myplot<-p+geom_line(aes(x=posixtime, y=Utilization,colour= Machine ), size=1.2)+
  facet_grid(Machine~.)+
  geom_hline(yintercept = 0.90, colour="Grey", size=1.2, linetype=3)


list_rl1$plot <- myplot# to store into list
list_rl1
summary(list_rl1)
str(list_rl1)
