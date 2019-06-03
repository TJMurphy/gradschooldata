library(tidyverse)
library(viridis)
library(plotly)

##DATA SOURCE: https://collegescorecard.ed.gov/data/preliminary/

##The source above was trimmed to derive the data below. Excluded are undergraduate programs and programs for which DEBTMEAN values are not provided.

dataset <- read.csv("2016-17_grad_debt.csv")

FIELDS <- reorder(dataset$FIELD, desc(dataset$FIELD))

p1 <- ggplot(dataset, aes(DEBTMEAN, FIELDS, 
       color=CREDDESC, name=CIPDESC, text=NAME))+
  geom_point(shape=0, size=4, alpha=0.5)+
  scale_color_viridis_d()+
  scale_x_continuous(breaks=c(0, 100000, 200000, 300000, 400000), labels=paste0(c("$0", "$100K", "$200K", "$300K", "$400K")))+
  labs(x="MEAN STUDENT LOAN DEBT", y=NULL, color="CREDENTIAL", title="AVERAGE GRADUATE STUDENT LOAN DEBT PER PROGRAM")+
  theme_light()
p1

ggplotly(p1, tooltip=c("DEBTMEAN","FIELDS", "CREDDESC", "CIPDESC", "NAME"))

ggplot(dataset, aes(DEBTMEAN, FIELDS, 
                    color=TYPE))+
  geom_point(shape=1, size=4, alpha=0.5)+
  scale_color_viridis_d()+
  scale_x_continuous(breaks=c(0, 100000, 200000, 300000, 400000), labels=paste0(c("$0", "$100K", "$200K", "$300K", "$400K")))+
  labs(x="MEAN STUDENT LOAN DEBT", y=NULL, color="TYPE", title="AVERAGE GRADUATE STUDENT LOAN DEBT PER PROGRAM")+
  theme_light()

#Color by type of university

DEGREE <- paste(dataset$CREDDESC, dataset$CIPDESC, sep=", " )

p2 <- ggplot(dataset, aes(DEBTMEAN, FIELDS, 
                    color=TYPE, name=DEGREE, text=NAME))+
  geom_point(shape=1, size=3, alpha=0.5)+
  scale_color_viridis_d()+
  scale_x_continuous(breaks=c(0, 100000, 200000, 300000, 400000), labels=paste0(c("$0", "$100K", "$200K", "$300K", "$400K")))+
  labs(x="MEAN STUDENT LOAN DEBT", y=NULL, color="TYPE", title="AVERAGE GRADUATE STUDENT LOAN DEBT PER PROGRAM", caption="Data Source: CollegeScorecard.ed.gov, Data Science: GitHub@TJMurphy")+
  theme_light()

p2

ggplotly(p2, tooltip=c("DEBTMEAN", "FIELDS", "DEGREE", "NAME"))

##A facet view

p3 <- ggplot(dataset, aes(DEBTMEAN, reorder(FIELD, desc(FIELD)), 
                    color=CREDDESC, name=CIPDESC, text=NAME))+
  geom_point(shape=1, size=4, alpha=0.5)+
  scale_color_viridis_d()+
  scale_x_continuous(breaks=c(0, 100000, 200000, 300000, 400000), labels=paste0(c("$0", "$100", "$200", "$300", "$400")))+
  labs(x="MEAN STUDENT LOAN DEBT (x1000)", y=NULL, title="AVERAGE GRADUATE STUDENT LOAN DEBT PER PROGRAM")+
  theme_light()+
  facet_grid(cols=vars(TYPE))

p3

ggplotly(p3, tooltip=c("DEBTMEAN","FIELDS", "CREDDESC", "CIPDESC", "NAME"))

