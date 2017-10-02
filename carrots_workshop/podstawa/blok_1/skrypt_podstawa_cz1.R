#Tu jest mój pierwszy komentarz
setwd("D:/Programowanie R") #set working directory
getwd()#get working directory
#ctrl+l --- clear the console
#ctrl+ENTER --- do formula/s 
data()#data sets built in R environment
help()#access to the documentation
help.search(rlm)#looking for documentation of rlm package
#You can try also in console using ??rlm or ?setwd
??nnet
#variable assignment
var<-5 #or
var=4
rm(var)
var1=1
var2=2
var3=3
ls() #list of created objects in environment, the same as objects()
objects()
var3 #shows value under the invoked variable

###ARYTMETYKA / LICZBY
zmienna<-100^3
format(10^5,scientific=TRUE)#shows mathematical var in scientific format
10%%3 #returns modulo
10%/%3 #return no modulo
abs(-5) #absolute value
log(2,10)#log(x,base)
exp(6)#e^6
factorial(5)# 1*2*3*4*5
#liczby specjalne
pi #pi value
options(digits=15)#change global settings ofshowing numbers
pi
.Machine$integer.max #max integer
.Machine$double.xmax #double max of the machine

###PAKIETY
install.packages("Deriv","ggplot2")#packages install (derivative)
library(Deriv) #upload package
s <- expression(1 / (1+e^-x));
deriv(s,'x');
D(expression(sqrt(1 - x^2)), 'x')

###FUNCTIONS
f<-function(x)
{
  return x^2
}
f(5)
#mark whole function, ctrl+enter and we got > f<-function(x)
#+ {
#  +   x^2
#  +   
#   + }

###DATA STRUCTURES

##vectors##
a<-c(1,2,3,4,6)
b<-c("aaa","bbb","333")
d<-c(5,6,1,2,3)
a<b
a=d
aa<-c("wewre",13)
aa
#connecting rows of vectors
rbind(a,d)
#connecting columns of vectors
cbind(a,d)
ff<-cbind(a,d)
str(ff) # string of two vectors
#random string of numbers from 1 to 100
a<-c(1:100)
a
#sequence from 2 to 3 , with 0.5 step
t<-seq(2,3,by=0.5)
t
#repeat 
rep(1:2, times=3)
rep(1:2, each=3)
rep(1:9, each =2)
#adding ten 
a+10
g<-c(1:100,9:100)
g
#average value
mean(a)
mean(b)
sort(a)
#counting
table(aa)
#reverse
rev(a)
#unque word
unique(a)

r<-15+6
x<-(3^2)/pow(2*pi,1/3)
integer(x)
?power
?pow
x<-floor((3^2)/((2*pi)^(1/3)))
floor(x)
install.packages("car")
library(car)
?car
aa
#without 4th and 2nd word
d[-4][-2]
#words greater than 5
d[d>5]
#if words are greater than 5
d>5
#exclude 2 from d
d[d!=2]
#looks for common words
d[d %in% c(5,2,4,56,9)]

###factor
student.genders<-c("male","female","others","m","f")
student.genders
#collects unique values and assigns to the levels
student.gend<-factor(student.genders)
student.gend
student.gend$Levels
Levels(student.gend)
#show LEVELS
levels(student.gend)
student.blood.group<-factor(c("a","b","ab","0","b","ab","0"), levels=c("a","b","ab","0"))
str(student.blood.group)
?str
?iris<-factor(c(IRIS),levels)
str(iris)
unique(iris$Species)

###matrixes
matrix<-matrix(1:9,nrow=3,ncol=3)
matrix
matrix[2,3]
matrix1<-matrix(5:13,nrow=3,ncol=3)
matrix1
matrix%*%matrix1
solve()
solve(matrix)
t(macierz)
solve(matrix)
mat<-matrix(1:50,nrow=10,ncol=5)
mat
?matrix
mat<-matrix(1:50,nrow=10,ncol=5,byrow="1")
mat<-matrix(1:50,nrow=10,ncol=5,byrow=1)
mat

###LISTS
lista<-list(x=1:5,y=c("a","b"))
lista
lista$x
lista[[1]]
student.nazwa<-c("Ja","ty","oni","one","wy","my")
student.waga<-c(60,70,80,90,200,75)
student.plec<-factor(c("k","m","k","m","m","m"), levels=c("k","m"))
student.ocena<-c(5L,6L,3L,4L,6L,2L)
student.Ja<-list(Nazwa=student.nazwa[1], plec=student.plec[1], waga=student.waga[1], ocena=student.ocena[1])
str(Ja)
str(student.Ja)
length(student.Ja)
student.Ja(1:2)
student.Ja[1:2]
typeof(student.Ja[1])
studenci<-list(Nazwa=student.nazwa, plec=student.plec, waga=student.waga, ocena=student.ocena)
length(studenci[1])

###DATA FRAME####
studenci.ramka<-data.frame(Nazwa=student.nazwa, plec=student.plec, waga=student.waga, ocena=student.ocena)
studenci.ramka[,3]
str(studenci.ramka[3])

###TABLES####
class1.student.fizyka.ocena<-c(5L,2L,4L,6L)
class1.student.matematyka.ocena<-c(3L,2L,1L,4L)
class1.student.polski.ocena<-c(5L,2L,1L,2L)
class.student.oceny<-cbind(class1.student.polski.ocena,class1.student.matematyka.ocena,class1.student.fizyka.ocena)
colnames(class.student.oceny)<-c("Polski","Matematyka","Fizyka")
class.student.oceny
class2.student.fizyka.ocena<-c(1L,2L,2L,3L)
class2.student.matematyka.ocena<-c(1L,2L,1L,1L)
class2.student.polski.ocena<-c(5L,6L,6L,2L)
class2.student.oceny<-cbind(class2.student.polski.ocena,class2.student.matematyka.ocena,class2.student.fizyka.ocena)
colnames(class2.student.oceny)<-c("Polski","Matematyka","Fizyka")
class2.student.oceny
class.student.oceny
klasy<-array(c(class.student.oceny,class2.student.oceny, dim=c(4,3,2)))
klasy
dane.nazwy<-c("macierz", "tabela", "ramka.danych", "lista")
dane.typy<-c("integer","double","float point", "boolean")
lista.zad<-data.frame(typy=dane.typy, nazwa=dane.nazwy)
lista.zad[2,3]
lista.zad[2:3]
#2 linia, 3 obiekt
lista.zad[[2]][3]
length.dane.nazwy
length(dane.nazwy)
length(dane.typy)
length(lista.zad[[1]])
lista.zad<-data.frame(typy=dane.typy, nazwa=dane.nazwy)
lista.zad
as.data.frame(lista.zad)
?labels

