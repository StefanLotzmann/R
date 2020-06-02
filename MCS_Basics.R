### Basics zur Entwicklung einer Monte-Carlo-Simulation ###


# Was heißt "simulieren"?

norm.simulated <- rnorm(n = 100, mean = 5, sd = 2)                           # erzeugt 100 (5, 2)-normalverteilte Zufallszahlen / 100 Realisationen einer (5, 2)-Normalverteilung
par(mfrow = c(3,1))
plot(norm.simulated)                                                         # Scatter-Plot der erzeugten Zufallszahlen
hist(norm.simulated)                                                         # Histogramm der erzeugten Zufallszahlen (absolute Häufigkeiten)
hist(norm.simulated, freq = FALSE)                                           # Histogramm der erzeugten Zufallszahlen (relative Häufigkeiten)         
curve(dnorm(x, mean = 5, sd = 2), from = 0, to = 10, add = TRUE, col = "red")   # plottet den Graphen der Dichte (Density Function) einer (5, 2)-Normalverteilung in das letzte Histogramm mit ein (Add = TRUE)


