README: 
How my R script works :)  
#1 In this part, i'll create a work directory, I used the ifelse function
because if the directory that I'm gonna create exists the function prints 
an advice. then I download and unzip the data using the function download.file
with the parameter exdir = "project1", my working directory, then I list the files 
with list.files

#2 
#2.1,2.2,2.3
In this part I'll use the function read.table to read the information of features, 
activity and subject, and the ubication of this files

#3 I used the function rbind, for combine by rows the corresponding datasets of 
feature,subject an activity of train and test respectivily,and at this way I created
3 tables with all the information of subject, fetures and activity

#3.1,3.1.1 in these index i put names at the variables of the below datasets, 
i used the names function for this goal, in 3.1.1 I specified the ubication of
the names of features an i create a character vector with this info.

#4 I combined the 3 merged datasets by columns to obtain one data set with all the info

#5 I obtained the features about mean and standard deviation, with grep i filtered the values of DFnames$V2, that don't have any spaces
between mean and the character "(" and the other character ")", the same as for 
std(), i stored this result in a variable, and then i used this variable to select only
the columns that i want, using the subset function

#6 I changed the numbers in the activity columns, for its descriptive activity names, 
in this case i factorize the variable D$activity, and use the labels parameter 
to change numbers for decriptive activity names

#7 then I used gsub for replace all the prefixes for more appropietly descriptive variables
names

#8 At the end i used dplyr package to generate and independent data set, but first I
used the aggregate function to combine using the mean all of the repeated results. 
 
You could find more details on my script :) have a nice day!

P.D Sorry if i have grammar errors my language is the Spanish and my level of english
is very bad

