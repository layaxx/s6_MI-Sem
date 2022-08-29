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
dataF1 <- data.frame(
  lexrank = c(31.34, 31.51, 31.05, 41.01, 49.71),
  textrank = c(40.8, 29.69, 31, 38.44, 46.3),
  mmr = c(30.57, 28.3, 31.8, 42.07, 45.48),
  icsisumm = c(24.27, 27.82, 29.83, 44.71, 50.98),
  pg = c(23.08, 26.32, 16.08, 43.89, 21.85),
  pgmmr = c(24.3, 26.9, 16.39, 43.93, 21.72),
  trans = c(15.72, 17.82, 16.38, 44.54, 21.35),
  himap = c(25.89, 24.3, 20.36, 42.55, 19.84),
  row.names = c("DUC", "TAC", "Opin", "Multin", "CQAS")
)

m <- as.matrix(apply(apply(dataF1, 1, rank), 1, rev))

maximums <- as.list(rowMax(m))
names(maximums) <- rownames(m)

df <- melt(m)
colnames(df) <- c("corpus", "system", "value")

ggplot(df, aes(x = system, y = corpus, fill = ifelse(value == 1, NA, value))) +
  geom_tile(color = "black") +
  geom_text(aes(label = value), color = "black", size = 4) +
  coord_fixed() +
  scale_fill_gradient2(
    na.value = "#4459d6",
    low = "blue",
    mid = "darkgray",
    high = "white",
    midpoint = 1
  ) +
  scale_x_discrete(position = "top") +
  theme(
    axis.line = element_blank(),
    legend.position = "none",
    panel.background = element_blank()
  )
