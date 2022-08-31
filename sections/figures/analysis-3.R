library(pacman)
p_load(ggplot2)
p_load(jsonlite)


# these are the outputs from running analysis.js on the three subsets of WCEP corpus
val <- fromJSON("/home/layaxx/Documents/s6_MI-SEM/summarization_bias/Corpus/val.json", flatten = TRUE)
train <- fromJSON("/home/layaxx/Documents/s6_MI-SEM/summarization_bias/Corpus/train.json", flatten = TRUE)
test <- fromJSON("/home/layaxx/Documents/s6_MI-SEM/summarization_bias/Corpus/test.json", flatten = TRUE)

dat <- rbind(test$values, train$values, val$values)
dat <- cbind(
  dat,
  list(dataset = rep(
    x = c("test", "train", "val"),
    times = c(
      length(test$values$id),
      length(train$values$id),
      length(val$values$id)
    )
  ))
)
# dim(dat)

# tab <- as.data.frame(table(test$values$lengthSummary) / length(test$values$lengthSummary))
# head(tab)

ggplot(dat, aes(x = lengthSummary)) +
  geom_histogram(aes(y = stat(density), fill = dataset),
    position = "dodge", alpha = .25, bins = 50
  ) +
  geom_density(aes(color = dataset)) +
  xlab("Length of summary")



ggplot(dat, aes(x = numberArticles)) +
  geom_histogram(aes(y = stat(density), fill = dataset),
    position = "dodge", alpha = .5, bins = 50
  ) +
  geom_density(aes(color = dataset)) +
  xlab("Number of articles per topic")
