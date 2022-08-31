library(pacman)
p_load(plyr)
p_load(ggplot2)
p_load(jsonlite)


val <- fromJSON("/home/layaxx/Documents/s6_MI-SEM/summarization_bias/Corpus/val.json", flatten = TRUE)
train <- fromJSON("/home/layaxx/Documents/s6_MI-SEM/summarization_bias/Corpus/train.json", flatten = TRUE)
test <- fromJSON("/home/layaxx/Documents/s6_MI-SEM/summarization_bias/Corpus/test.json", flatten = TRUE)


dat <- rbind(test$values, train$values, val$values)
dat <- cbind(dat, list(dataset = rep(x = c("test", "train", "val"), times = c(1022, 8158, 1020))))
dim(dat)

tab <- as.data.frame(table(test$values$lengthSummary) / length(test$values$lengthSummary))

head(tab)

ggplot(dat, aes(x = lengthSummary)) +
  geom_histogram(aes(y = stat(density), fill = dataset),
    position = "dodge", alpha = .25,
  ) +
  geom_density(aes(color = dataset)) +
  xlab("Length of summary")



ggplot(dat, aes(x = numberArticles)) +
  geom_histogram(aes(y = stat(density), fill = dataset),
    position = "dodge", alpha = .5
  ) +
  geom_density(aes(color = dataset)) +
  xlab("Number of articles")
