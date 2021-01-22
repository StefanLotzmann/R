#### zusätzliche Programmbibliotheken einbinden ####
library(ProjectManagement)
library(plotly)

#### Erzeugen der Vektoren mit den geschützten Vorgangsdauern: opt = optimistischer Fall, mol = wahrscheinlichster Fall, pes = pessimistischer Fall ####
opt = c( 93,110, 88,0,19,30,0,12,26, 8,20,5,2)
mol = c(108,135,116,0,23,35,0,15,33,10,24,6,5)
pes = c(195,190,120,0,33,46,0,24,46,12,34,7,8)

#### Funktion zur Berechnung von Mittelwert,Varianz und Standardabweichung für Modell mit Dreieckverteilung ####
est =  function(opt,act,pes) {
    mu  = (opt+mol+pes)/3
    var = ((opt-pes)^2+(pes-mol)^2+(opt-mol)^2)/36
    sd  = sqrt(var)
    mat = round(data.frame(mu,sd,var),2)
    print(mat)
}
n = est(opt,mol,pes)

#### Definition der Präzedenten-Matrix aller Vorgänge ####
prec1and2 <- matrix(c(0,1,1,0,0,0,0,0,0,0,0,0,0,
                      0,0,0,1,1,0,0,0,0,0,0,0,0,
                      0,0,0,1,0,0,0,0,0,0,0,0,0,
                      0,0,0,0,0,1,0,0,0,0,0,0,0,
                      0,0,0,0,0,0,1,0,1,0,0,0,0,
                      0,0,0,0,0,0,0,1,0,0,0,0,0,
                      0,0,0,0,0,0,0,1,0,0,0,0,0,
                      0,0,0,0,0,0,0,0,0,1,0,0,0,
                      0,0,0,0,0,0,0,0,0,0,1,0,0,
                      0,0,0,0,0,0,0,0,0,0,1,0,0,
                      0,0,0,0,0,0,0,0,0,0,0,1,0,
                      0,0,0,0,0,0,0,0,0,0,0,0,1,
                      0,0,0,0,0,0,0,0,0,0,0,0,0),nrow=13,ncol=13,byrow=TRUE) 

#### Berechnung des PERT-Netzplanes (Vor- und Rückwärtsterminierung) ####
schedule.pert(prec1and2=prec1and2, duration = n$mu, PRINT=TRUE)

#### Definition der PDF für jeden Vorgang ####
distribution <- c("TRIANGLE","TRIANGLE","TRIANGLE","TRIANGLE","TRIANGLE","TRIANGLE","TRIANGLE","TRIANGLE","TRIANGLE","TRIANGLE","TRIANGLE","TRIANGLE","TRIANGLE")

#### Erzeugen einer Matrix mit den notwendigen Verteilungsparametern (Dreieckverteilung) ####
values = matrix(c(opt,pes,mol),13,3 );values

#### Simulation des PERT-Netzplanes unter der Annahme Vorgansdauern sind i.i.d. Triangle(opt,act,pes) ####
set.seed(1024)
stochastic.pert(prec1and2=prec1and2,distribution=distribution,values=values, percentile = 0.95, compilations = 100000)

### Varianz der Vorgangsdauern auf dem kritischen Pfad ####
variance = n$var[1] + n$var[2] + n$var[4] + n$var[6] + n$var[8] + n$var[10] + n$var[11] + n$var[12] + n$var[13]
sigma = sqrt(variance)

#### Berechnung der Wahrscheinlichkeiten, dass das Projekt spätestens nach 359 oder 377 ZE endet ####
mu = 379.1915
pnorm((359-mu)/sigma)
pnorm((377-mu)/sigma)
