# Code to calculate word frequency and sort in descending order
# written by Emily Golson

dat<-read.csv(file.choose(),header=T) #opens a window to choose a csv file to upload 
dat<-data.frame(dat) #turns your csv file into a dataframe (R's version of a spreadsheet)
attach(dat) #records headers
names(dat) #spits out headers
freq<-data.frame(table(dat[,1])) #calculates frequency of the data and turns it into a dataframe
sorted<-freq[order(-freq[,2]),] #sorts the frequency data by the 2nd row of the freq dataframe
write.csv(sorted, file = "sorted.csv") #automatically writes a .csv file to your hard drive. I usually search for the file on spotlight. each time you run this line I would change add a # to the end of the file name - like sorted1.csv, sorted2.csv- or rename the file completely so that you keep track of the different files you generate. 
