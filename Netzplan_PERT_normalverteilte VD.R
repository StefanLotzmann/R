#### zus??tzliche Programmbibliotheken einbinden ####
library(ProjectManagement)
library(plotly)

#### Erzeugen der Vektoren mit den gesch??tzten Vorgangsdauern: opt = optimistischer Fall, mol = wahrscheinlichster Fall, pes = pessimistischer Fall ####
opt = c( 93,110, 88,0,19,30,0,12,26, 8,20,5,2)
mol = c(108,135,116,0,23,35,0,15,33,10,24,6,5)
pes = c(195,190,120,0,33,46,0,24,46,12,34,7,8)

#### Funktion zur Berechnung von Mittelwert,Varianz und Standardabweichung f??r Modell mit Normalverteilung ####
est =  function(opt,act,pes)
{
  mu  = (opt+4*mol+pes)/6
  sd  = (pes - opt) / 6
  var = sd^2 
  mat = round(data.frame(mu,sd,var),2)
  print(mat)
}
n = est(opt,mol,pes)

#### Definition der Pr??zedenz-Matrix aller Vorg??nge ####
prec1and2<-matrix(c(0,1,1,0,0,0,0,0,0,0,0,0,0,
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

#### Berechnung des PERT-Netzplanes (Vor- und R??ckw??rtsterminierung) ####
schedule.pert(prec1and2=prec1and2, duration = n$mu, PRINT=TRUE)

#### Definition der PDF f??r jeden Vorgang ####
distribution<-c("NORMAL","NORMAL","NORMAL","NORMAL","NORMAL","NORMAL","NORMAL","NORMAL","NORMAL","NORMAL","NORMAL","NORMAL","NORMAL")

#### Erzeugen einer Matrix mit den notwendigen Verteilungsparametern (Normalverteilung) ####
values = matrix(c(n$mu,n$sd),13,2 );values

#### Simulation des PERT-Netzplanes unter der Annahme Vorgansdauern sind i.i.d. N(mu,var) ####
set.seed(1024)
stochastic.pert(prec1and2=prec1and2,distribution=distribution,values=values, percentile = 0.95, compilations = 100000)

### Varianz der Vorgangsdauern auf dem kritischen Pfad ####
variance = n$var[1] + n$var[2] + n$var[4] + n$var[5] ++n$var[6] + n$var[8] + n$var[10] + n$var[11] + n$var[12] + n$var[13]
sigma = sqrt(variance)

#### Here we calculate the probability that the project will end at 359 & 377 time units. Thus, since the activities of the project follow the Normal Distribution we have:####
mu = 358.8328
pnorm((359-mu)/sigma)
pnorm((377-mu)/sigma)