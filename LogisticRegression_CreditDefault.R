install.packages("fBasics")
install.packages("ISLR")
install.packages("ggplot2")
library(fBasics)
library(ISLR)
library(ggplot2)

data("Default")
attach(Default)

##################################################
################# PREPARING DATA #################

# 1. CREATING A DUMMY QUANTITATE VARIABLE STUDENT: STUDENT = 1, NON-STUDENT = 0.
rows = nrow(Default)
student_dummy = matrix(nrow=rows, ncol=1)
for (i in 1:rows)
  {
    if (student[i]=="Yes") {
      student_dummy[i,] = 1
    } else { 
      student_dummy[i,] = 0
    }  
  }
mean(student_dummy)

default_lr = cbind(Default,student_dummy)
head(default_lr)

# 2. CREATING A DUMMY TO QUANTITATE VARIABLE DEFAULT: DEFAULT = 1, NON-DEFAULT = 0.
default_dummy = matrix(nrow=rows, ncol=1)
for (i in 1:rows)
  {
    if (default[i]=="Yes") {
      default_dummy[i,] = 1
    } else {
      default_dummy[i,] = 0
    }
  }
mean(default_dummy)

default_lr = cbind(default_lr, default_dummy)
head(default_lr)

# 3. WRITE THE NEW DATA TO A CSV FILE FOR FUTURE USES.
write.csv(default_lr, "D:/R Projects/Dataset" )

##################################################
############## VISUALIZING THE DATA ##############

# 1. PLOT OF ANNUAL INCOME VS BALANCE
par(mfcol=c(1,1))
plot(default_lr$balance, default_lr$income,
     xlab='Balance', ylab='Income',  main='Income vs Balance',
     pch=ifelse(default_lr$default_dummy==1, 4, 1),
     cex.main=1, frame.plot=TRUE,
     col=ifelse(default_lr$default_dummy==1, 'brown', 'blue'))

par(mfcol=c(1,2))
boxplot(balance~default_dummy, data=default_lr,
        xlab='Default', ylab='Balance', col=(c("blue","red")))
boxplot(income~default_dummy,data=default_lr,
        xlab='Default', ylab='Income', col=(c("blue","red"))) 

##################################################
######### PERFORMING LOGISTIC REGRESSION #########
####### cALCULATING PROBABILITY OF DEFAULT #######

# 1. RUNNING A LOGISTIC REGRESSION TO PREDICT THE DEFAULT PROBABILITY FROM BALANCE, INCOME, AND STUDENT STATUS.

fit1 = glm(default~balance+income+student_dummy, family="binomial", data=default_lr)
summary(fit1)

# 2. CALCULATE THE DEFAULT PROBABILITY FOR EACH INDIVIDUAL BASED ON PREDICTED MODEL "fit1"

pred_default_prob = predict(fit1,type="response")

# 3. SET A THRESHOLD OF 0.5 AND TEACH THE MACHINE THAT EVERY INDIVIDUALS HAVE DEFAULT PROBABILITY HIGHER THAN THERSHOLD WILL DEFAULT.
glm.pred = rep("No",10000)
glm.pred[pred_default_prob > 0.5] = "Yes"

# 4. CREATE A CONFUSION MATRIX TO COMPARE THE PREDICTED RESULT WITH TRUE EVENTS.
table(glm.pred,default)

##################################################
# ADJUSTING THRESHOLDS TO FIND THE MOST ACCURATE #


