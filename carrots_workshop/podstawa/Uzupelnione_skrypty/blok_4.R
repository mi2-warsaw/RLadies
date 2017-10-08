getwd()
setwd('C:\\Users\\alicj\\Desktop\\Warsztaty_dzien_2\\blok_4')

titanic <- read.table('titanic.csv', sep=';', quote='', header=TRUE)

head(titanic, n=2)
tail(titanic)
View(titanic)
all(titanic[50:55, 'Age'] == titanic$Age[50:55])
any(titanic[50:55, 'Age'] == titanic$Age[50:55])
## wczytanie danych
## head, tail, view, subset

#1. Wymiencie znane typy danych
#2. Jakie typy na jakie mozemy chciec konwertowac?
#3. fodler roboczy

sapply(titanic, class)
titanic$PassengerId <- as.character(titanic$PassengerId)
is.character(titanic$PassengerId)
is.numeric(titanic$Pclass)
is.factor(titanic$Sex)

is.integer(titanic$Parch)
is.character(titanic$Parch)

is.integer(4L)
is.numeric(3)
is.integer(3.123)
#mozna sprawdzic typy danych dla wszystkich kolumn jednoczesnie:

#konwersja z factor do numeric
as.numeric(titanic$Sex[1:5])
as.character(titanic$Sex[1:5])

## sapply vs for

sapply(titanic, class)

for(i in 1:12){
  print(class(titanic[, i]))
}

#instalacja i wczytanie biblioteki lubridate
## is.Date
## konwersja
install.packages('lubridate')
require(lubridate)
library(lubridate)

is.Date()

dates <- c("2013-06-01 08:07:00",
           "2005-12-12",
           "2006-12-12",
           "2007-12-12",
           '2017:12:23')

is.factor(dates)
is.character(dates)
dates <- as.Date(dates)
is.Date(dates)

month(dates)

dates <- c("2013!06!01",
           "2005-12-12",
           "2006-12-12",
           "2007-12-12",
           '2017:11:12')

ymd(dates)
ydm(dates)

## class Name
# konwersja
is.character(titanic$Name)
titanic$Name = as.character(titanic$Name)
is.character(titanic$Name)

## grep, length, value
x = c('abc', 'cde', 'bac', 'aaa')
grep('a', x, value = TRUE)

grepl('a', x)

## grepl, sum
gdzie_jest_james = grep('James', titanic$Name)
length(gdzie_jest_james)

gdzie_jest_james2 = grepl('James', titanic$Name)
sum(as.integer(gdzie_jest_james2))
sum(gdzie_jest_james2)

## a co jak bya literowka
gdzie_jest_james3 = grep('[Jj]ames', titanic$Name)
length(gdzie_jest_james3)
## grep James, Miss | [mM], 
length( grep('Miss', titanic$Name) )

## james lub mark
grep('[Jj]ames|[Mm]ark', titanic$Name, value=TRUE)
grep('^[Hh]', titanic$Name, value=TRUE)
grep('a$', titanic$Name, value=TRUE)

grep("a+", c("abc", "def", "cba a", "aa"),  value=FALSE)

grep("a+", c("abc", "def", "cba a", "aa"),  value=TRUE)

grepl("a+", c("abc", "def", "cba a", "aa"))

tu_sa_przecinki = regexpr(',(.*)', titanic$Name)
substring(titanic$Name,0,tu_sa_przecinki-1)

tu_sa_przecinki2 = regexpr('[a-zA-Z](?=,)', titanic$Name, perl=T)
substr(titanic$Name, 0, tu_sa_przecinki2)
substr(titanic$Name, 0, ',')

substr('abcdefghijklmn', 4,7)

## regmatches
x <- c("abc", "def", "cba a", "aa")
m <- regexpr("a+", x, perl=TRUE)
regmatches(x, m)

x = c('pizza', 'piza', 'piwa')
gsub(pattern = 'z',
    replacement = 'Z',
    x)


## unikalna list ludzi z imionami x i y


#3 znalezc wszystkie panny regexpr %>% regmatches

## sub gsub

##___ dane, summary, imutacja age, mean, median

summary(titanic)
sum(is.na(titanic$Age))
sapply(titanic, function(x) sum(is.na(x)))


