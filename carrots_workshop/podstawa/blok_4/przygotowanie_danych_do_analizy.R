### PRZYGOTOWYWANIE DANYCH DO ANALIZY

# konwersje typów

#czyli co sie dzieje kiedy ladujemy dane do R i nie sa one dokladnie w takim typie jakbysmy chcieli

#1. Wymiencie znane typy danych
#2. Jakie typy na jakie mozemy chciec konwertowac?

titanic <- read.table("titanic.csv", sep=";", quote="", header=TRUE)

titanic[1:10,]

summary(titanic)

#mozna sprawdzic typy danych dla wszystkich kolumn jednoczesnie:
sapply(titanic, class)

#albo pojedynczo

is.factor(titanic$Survived)
is.numeric(titanic$Survived)
#is.integer()
#is.character()

as.factor(titanic$Survived)
#sprawdzmy!

is.factor(titanic$Survived)

titanic$Survived<-as.factor(titanic$Survived)

is.factor(titanic$Survived)

is.numeric(titanic$Fare)
is.numeric(titanic$Age)
is.factor(titanic$Pclass)
is.numeric(titanic$Pclass)
titanic$Pclass <- as.factor(titanic$Pclass)
is.factor(titanic$Pclass)
is.factor(titanic$Sex)

#konwersja z factor do numeric
as.numeric(factor(c(-2,2)))


as.numeric(as.character(factor(c(-2,2))))

#konwersja dat

#instalacja jesli nie mamy:
install.packages("lubridate")

require(lubridate)

?lubridate
dates <- c("2013-06-01 08:07:00","2005-12-12", "2006-12-12", "2007-12-12")

is.factor(dates)
is.character(dates)

dates <- as.Date(dates)
is.Date(dates)
years <- year(dates)
years

#####################################################################
# wyrażenia regularne

summary(titanic)
sapply(titanic, class)

titanic$Name<- as.character(titanic$Name)

is.character(titanic$Name)

#grep, grepl
?grep
grep("James", titanic$Name)
grep("[jJ]ames", titanic$Name, value= TRUE)
length( grep("James", titanic$Name))

grep("Miss", titanic$Name)
length(grep("Miss", titanic$Name))
grepl("Miss", titanic$Name)

#czy ponizszy kod znajdzie nam wszystkie mozliwe osoby majace na imie James lub Mark?
grep("[jJ]ames | [mM]ark", titanic$Name, value= TRUE)

imiona <-c("James","Mark")
lista<- unique (grep(paste(imiona,collapse="|"), titanic$Name, value= TRUE))
lista

grep("^H", titanic$Name, value= TRUE)

grep("a$", titanic$Name, value= TRUE)

grep("a+", c("abc", "def", "cba a", "aa"),  value=FALSE)

grep("a+", c("abc", "def", "cba a", "aa"),  value=TRUE)

grepl("a+", c("abc", "def", "cba a", "aa"))

#regexpr, gregexpr

regexpr(",(.*)", titanic$Name)
?substr
new_name<- substr(titanic$Name,0,",")


regmatches(titanic$Name, regexpr("Miss(.*)",titanic$Name))
regexpr("a+", c("abc", "def", "cba a", "aa"), perl=TRUE)


gregexpr("a+", c("abc", "def", "cba a", "aa"), perl=TRUE)

x <- c("abc", "def", "cba a", "aa")
m <- regexpr("a+", x, perl=TRUE)
regmatches(x, m)

m <- gregexpr("a+", x, perl=TRUE)
regmatches(x, m)

#sub, gsub
sub('"\"', "", titanic$Name)

gsub('"\"', "", titanic$Name)

#regexec

r<-regexec("Mr.(.*?)", titanic$Name)
r 
m <-regmatches(titanic$Name, r)

m
###################################################################
# radzenie sobie z brakami danych
summary(titanic)
#testowanie na brakujace dane
is.na(titanic$Age) 


#na poczatek warto sie przyjrzec czy sa to wybrakowane obserwacje i je usunac

titanic[!complete.cases(titanic),]
#albo

which(!rowSums(!is.na(titanic)))

#brakujace dane mozna uzupelnic srednia badz mediana, dane titanic 

titanic[is.na(titanic$Cabin),]
#albo
subset(titanic,is.na(Embarked))

mean(titanic$Age) 
mean(titanic$Age, na.rm=TRUE)
median(titanic$Age, na.rm=TRUE)



titanic$Age[is.na(titanic$Age)] <- mean(titanic$Age, na.rm=TRUE)

mean(titanic$Age) 

#brakujace dane mozna uzupelnic np danymi z dnia poprzedniego



# zbior danych bez nulls
titanic2 <- na.omit(titanic) 
