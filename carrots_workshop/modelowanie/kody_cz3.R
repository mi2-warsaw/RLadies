library("faraway")
library("dplyr")
library('magrittr')
library("ggplot2")
library("rpart")

dane <- read.csv('titanic.csv')
dane %<>% select(-c(PassengerId,Name, Ticket, Cabin))
head(dane)

table(dane$Survived)

apply(dane, 2, FUN = function(x){
  any(is.na(x))}
)


m.Age <- median(dane$Age, na.rm = TRUE)
m.Age
dane %<>% mutate(Age = if_else(is.na(Age),m.Age ,Age))

dane <- model.matrix(~.-1 , data=dane) %>% data.frame() %>% 
  select(-c(EmbarkedC,Sexmale))


set.seed(555)
los <- sample(1:nrow(dane), ceiling(0.7*nrow(dane)),replace = F)
train <- dane[los,] 
test <- dane[-los,]

check_class <- function(true, pred){
  t <- table(true, pred)
  results <- c(sum(diag(t))/sum(t), t[2,2]/sum(t[2,]), t[2,2]/sum(t[,2]), t[1,1]/sum(t[,1]))
  names(results) <- c("% popr. odp.", "czu³oœæ", "precyzja", "specyficznoœæ")
  results
}

# regresja liniowa:
logit <- glm(Survived ~ ., family=binomial(link="logit"), data=train)
probit <- glm(Survived ~ ., family=binomial(link="probit"), data=train)
cloglog <- glm(Survived ~ ., family=binomial(link="cloglog"), data=train)

logit.bic <- step(logit, direction = "backward", k = log(nrow(train)))

anova(logit.bic, logit, test = "Chisq") 

logit.bic.2 <- glm(Survived~ Pclass + Sexfemale + Age  +
                     I(Age^2) , data=train, family="binomial")

anova(logit.bic,logit.bic.2, test = "Chisq")

prplot(logit.bic,3)


r_resp <- residuals(logit.bic, type='response')
qplot(y = r_resp, x = 1:length(r_resp)) + ggtitle("Wykres reszt modelowych") +
  geom_point(size = 2.5) + labs(y = "Reszty modelowe", x = "Index") + theme_minimal() +
  theme(axis.title.x = element_text(size = 15, angle = 0, face = "italic"), 
        axis.title.y = element_text(size = 15, angle = 90, face = "italic")) +
  theme(legend.title = element_text(size = 14, face = "bold")) +
  theme(legend.text = element_text(colour = "black", size = 12)) + 
  guides(color = guide_legend(keywidth = 2, keyheight = 2)) + theme(title = element_text(size = 20)) + theme(axis.text= element_text(size = 14)) 


outlier <- which(abs(logit.bic$residuals)/sqrt(1-hatvalues(logit.bic))>2) 
train[outlier[1:5],]

predict(logit.bic, data.frame(Pclass=1, Sexfemale = 0,Age = 24, 
                              SibSp = 0), se.fit=T, type='response')$fit

probs <- predict(logit.bic, test,type='response')

qplot(probs) + ggtitle("Histogram uzyskanych prawdopodobieñstw przynale¿noœci do klasy 1") +
  labs(y = "Czêstoœæ", x = "Prawdopodobieñstwo") + theme_minimal() +
  theme(axis.title.x = element_text(size = 15, angle = 0, face = "italic"), 
        axis.title.y = element_text(size = 15, angle = 90, face = "italic")) +
  theme(legend.title = element_text(size = 14, face = "bold")) +
  theme(legend.text = element_text(colour = "black", size = 12)) + 
  guides(color = guide_legend(keywidth = 2, keyheight = 2)) + theme(title = element_text(size = 20)) + theme(axis.text= element_text(size = 14)) 


class <- ifelse(probs > 0.6,1,0)
check_class(test$Survived, class)

dane <- read.table("earthquake.txt", h = T)


ggplot(data = dane, aes(x = body, y = surface, col = popn))+
  geom_point(size = 2.5) + theme_minimal() + ggtitle("Przyk³ad danych liniowo separowalnych") +
  theme(axis.title.x = element_text(size = 15, angle = 0, face = "italic"), 
        axis.title.y = element_text(size = 15, angle = 90, face = "italic")) +
  theme(legend.title = element_text(size = 14, face = "bold")) + theme(title = element_text(size = 20)) +
  theme(legend.text = element_text(colour = "black", size = 12)) + 
  guides(color = guide_legend(keywidth = 2, keyheight = 2)) + theme(legend.position = "bottom") +
  theme(axis.text= element_text(size = 14)) +
  theme(legend.title = element_text(size = 16, face = "bold")) +
  theme(legend.text = element_text(colour = "black", size = 14))

model <- glm(popn ~ ., data = dane, family = "binomial")

# Drzewa klasyfikacyjne
model.tree <- rpart(as.factor(popn) ~ ., data = dane, minsplit = 5)

plot(model.tree)
text(model.tree)


xp <- seq(4.5, 6.5, length = 50)
yp <- seq(3.5, 6.5, length = 50)
siatka <- expand.grid(body = xp, surface = yp)

P1 <- predict(model.tree, newdata = siatka, type = "prob")
zp1 <- ifelse(P1[,1] == 1, 1, -1)

ggplot() + xlim(c(4.4, 6.6)) + ylim(c(3.4, 6.8)) + theme_minimal() +
  geom_contour(data = cbind(siatka, data.frame(pred2 = zp1)), 
               aes(x = body, y = surface, z = pred2), bins = 1, col = "black", 
               linetype = 1, size = 1.2, alpha = 0.5) + 
  geom_point(data = dane, aes(x = body, y = surface, col = popn), size = 2) + 
  xlab("body") + ylab("surface") + ggtitle("Przyk³ad klasyfikacji za pomoc¹ drzewa") +
  theme(plot.title = element_text(face = "bold", size = 20)) + 
  theme(axis.title.x = element_text(size = 18, angle = 0, face = "italic"), 
        axis.title.y = element_text(size = 18, angle = 90, face = "italic")) +
  theme(axis.text= element_text(size = 14)) +
  theme(legend.title = element_text(size = 16, face = "bold")) +
  theme(legend.text = element_text(colour = "black", size = 14),
        legend.position = "bottom") +
  guides(color = guide_legend(keywidth = 2, keyheight = 2))
title("Drzewo klasyfikacyjne")


tree.tmp <- rpart(factor(Survived)~., data = train, cp = 0.0001, minsplit = 5)
plotcp(tree.tmp)
printcp(tree.tmp)


n <- nrow(train)
n1 <- floor(n*0.7)
lp <- 300
zmienne <- c("1")
zmienne.bezpowt <- c("1")
m <- 0
cp_opt <- 0.00547112
for(i in 1:lp){
  m <- m + 1
  pseud <- sample(1:n, n1)
  tmp.tree <- rpart(factor(Survived)~., data = train[pseud,], cp = cp_opt, minsplit = 5)
  zmienne <- c(zmienne, tmp.tree$frame$var)
  zmTMP <- sort(tmp.tree$frame$var) %>% as.character()
  zmTMP <- zmTMP[zmTMP!="<leaf>"]
  zmTMP.bezpowt <- c("1")
  for(i in 2:length(zmTMP)){
    if(zmTMP[i]!= zmTMP[i-1])
      zmTMP.bezpowt <- c(zmTMP.bezpowt, as.character(zmTMP[i]))
  }
  
  zmienne.bezpowt <- c(zmienne.bezpowt, zmTMP.bezpowt)
}

print(table(zmienne.bezpowt)[-1])
