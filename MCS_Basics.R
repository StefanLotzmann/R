### Basics zur Entwicklung einer Monte-Carlo-Simulation ###


# Was heißt "simulieren"?
norm.simulated <- rnorm(n = 100, mean = 5, sd = 2)                              # erzeugt 100 (5, 2)-normalverteilte Zufallszahlen / 100 Realisationen einer (5, 2)-Normalverteilung / zieht eine Stichprobe vom Umfang 100 aus einer (5, 2)-normalverteilten Grundgesamtheit
par(mfrow = c(3,1))
plot(norm.simulated)                                                            # Scatter-Plot der erzeugten Zufallszahlen
hist(norm.simulated)                                                            # Histogramm der erzeugten Zufallszahlen (absolute Häufigkeiten)
hist(norm.simulated, freq = FALSE)                                              # Histogramm der erzeugten Zufallszahlen (relative Häufigkeiten)         
curve(dnorm(x, mean = 5, sd = 2), from = 0, to = 10, add = TRUE, col = "red")   # plottet den Graphen der Dichte (Density Function) einer (5, 2)-Normalverteilung in das letzte Histogramm mit ein (Add = TRUE)

# Zusammenfassende Statistiken der obigen Simulation
mean(norm.simulated)                                                            # Mittelwert / arithmetisches Mittel der erzeugten Zufallszahlen           
sd(norm.simulated)                                                              # Standardabweichung (Stichprobenstandardabweichung) der erzeugten Zufallszahlen

# Wir wiederholen die Simulation nun viermal
norm.simulated_1 <- rnorm(n = 100, mean = 5, sd = 2) 
norm.simulated_2 <- rnorm(n = 100, mean = 5, sd = 2)
norm.simulated_3 <- rnorm(n = 100, mean = 5, sd = 2)
norm.simulated_4 <- rnorm(n = 100, mean = 5, sd = 2)

# ...und stellen fest, dass sich die Ergebnisse offenbar unterscheiden (klar, denn wir generieren in jeder Simulation verschiedene Realisierungen der (5,2)-normalverteilen Zufallsvariablen)
par(mfrow = c(2,2))
hist(norm.simulated_1)  
hist(norm.simulated_2)  
hist(norm.simulated_3)  
hist(norm.simulated_4)  

# ... die Mittelwerte sind liegen folglich auch alle nahe bei fünf, sind aber nicht identisch 
mean(norm.simulated_1) 
mean(norm.simulated_2)
mean(norm.simulated_3)
mean(norm.simulated_4) 

# Um die Zahl der erzeugten Zufallszahlen / Beobachtungen der Grundgesamtheit zu verändern, muss einfach n angepasst werden (analog der Verteilungstyp und dessen Parameter)
 
# Monte-Carlo-Simulation: Ausnutzen des Zentralen Grenzwertsatzes (punktweise Konvergenz der Verteilung der standardisierten Zufallsgröße Z_n gegen die (0, 1)-Standardnormalverteilung) und des starken Gesetzes der Großen Zahlen
# Sei f: [0,1] -> R, deren Integral I auf [0,1] berechnet werden soll. Wenn ein Rechner Zufallszahlen X_i i.i.d. gleichverteilt auf [0,1] generiert, dann konvergiert 
# I^_n := 1/n Sigma (f(X_i)) P-fast-sicher gegen I
norm.simulated.mc_1 <- replicate(n = 4, rnorm(n = 100, mean = 5, sd = 2))       # replicate-Funktion nutzen, um vektorielles Programmieren auszunutzen und Schleifen zu vermeiden 
par(mfrow = c(2,2))
apply(X = norm.simulated.mc_1, MARGIN = 2, FUN = hist)                          # speichere Simulation in Matrix X (4 Spalten á 100 Zufallszahlen), wende Funktion "hist" auf alle Spalten der Matrix an (MARGIN = 2, 1...Zeilen, c(1,2)...Zeilen und Spalten)
apply(X = norm.simulated.mc_1, MARGIN = 2, FUN = mean)                          # bestimme Mittelwert aller Spalten von X
apply(X = norm.simulated.mc_1, MARGIN = 2, FUN = sd)                            # bestimme Standardabweichung aller Spalten von X

# Wie sieht nun der Standardfehler / Stichprobenfehler von I^ aus?(bei einem erwartungstreuen Schätzer ist der Standardfehler ein Maß für die durchschnittliche Abweichung des geschätzten Parameterwertes vom wahren Parameterwert)
norm.simulated.mc_2 <- replicate(n = 2000, rnorm(n = 100, mean = 5, sd = 2))
sd(apply(X = norm.simulated.mc_2, MARGIN = 2, FUN = mean))

# Der erwarte Standardfehler für den Mittelwert ist sd/sqrt(sample size):
2/sqrt(100)

# Simulierte Stichprobenverteilung der Mittelwerte
par(mfrow = c(1,1))
hist(apply(X = norm.simulated.mc_2, MARGIN = 2, FUN = mean),
    main = "Simulierte Stichprobenverteilung der Mittelwerte",
    xlab = "geschätzte Mittelwerte")

########################################################################
# Anstelle von replicate kann die Simulation auch mit einer for-Schleife realisiert werden
########################################################################
N <- 1000                                                                       # Anzahl der Iterationen in der Simulation

simulated_means <- rep(NA, N)                                                   # intialisiere eine Variable vom Typ "Vector" mit Länge N und "missing data" zum Speichern der Mittelwerte

head(simulated_means)                                                           # Gibt den ersten Teil eines Objektes aus (vector, matrix, table, data frame, function), alternativ: tail

for (i in 1:N) {
    sim.data <- rnorm(n = 100, mean = 5, sd = 2)
    simulated_means[i] <- mean(sim.data)
    rm(sim.data)                                                                # nach jeder Iteration wird Variable sim.data überschrieben, um Speicherplatz wieder freizugeben
}

hist(simulated_means)    
sd(simulated_means)
