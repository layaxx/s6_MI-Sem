library(pacman)

p_load(qlcMatrix)
p_load(reshape)
p_load(ggplot2)

dataR1 <- data.frame(
  lexrank = c(35.56, 33.1, 33.41, 38.27, 32.22),
  textrank = c(33.16, 44.98, 26.97, 38.44, 28.94),
  mmr = c(30.14, 30.54, 30.24, 38.77, 29.33),
  icsisumm = c(37.31, 28.09, 27.63, 37.2, 28.99),
  pg = c(31.43, 31.44, 19.65, 41.85, 31.09),
  pgmmr = c(36.42, 40.44, 19.8, 40.55, 36.54),
  trans = c(28.54, 31.54, 20.46, 43.57, 30.12),
  himap = c(35.78, 29.31, 18.02, 43.47, 31.41),
  row.names = c("DUC", "TAC", "Opin", "Multin", "CQAS")
)
dataR2 <- data.frame(
  lexrank = c(7.87, 7.5, 9.61, 12.7, 5.84),
  textrank = c(6.13, 9.28, 6.99, 13.1, 5.65),
  mmr = c(4.55, 4.04, 7.67, 11.98, 4.99),
  icsisumm = c(9.36, 3.78, 5.32, 13.5, 4.24),
  pg = c(6.03, 6.4, 1.29, 12.91, 5.52),
  pgmmr = c(9.36, 14.93, 1.34, 12.36, 6.67),
  trans = c(6.38, 5.9, 1.41, 14.03, 4.36),
  himap = c(8.9, 4.61, 1.46, 14.89, 4.69),
  row.names = c("DUC", "TAC", "Opin", "Multin", "CQAS")
)

m <- as.matrix(dataR1)

maximums <- as.list(rowMax(m))
names(maximums) <- rownames(m)

df <- melt(m)
colnames(df) <- c("dataset", "system", "value")
for (i in 1:nrow(df)) {
  value <- df$value[[i]]
  dataset <- df$dataset[[i]]
  maxValue <- maximums[[dataset]]

  df$fill[[i]] <- ifelse(value == maxValue, 100, 0)
}

ggplot(df, aes(x = system, y = dataset, fill = fill)) +
  geom_tile(color = "black") +
  geom_text(aes(label = value), color = "black", size = 4) +
  coord_fixed() +
  scale_x_discrete(position = "top") +
  theme(
    axis.line = element_blank(),
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    legend.position = "none",
    panel.background = element_blank()
  )
