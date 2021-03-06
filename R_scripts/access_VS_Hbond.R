#!/usr/bin/env Rscript

args <- commandArgs(TRUE) 

max_bonds_donor=3
max_bonds_acceptor=2
per=as.numeric(args[6])

Hbond_count <- as.numeric(unlist(strsplit(args[1],"_")))
access <- as.numeric(unlist(strsplit(args[2],"_")))
access_per <- replace(access, which(access > per), NA)

for (i in 1:length(access)) { 
	if (is.na(access_per[i])) {
		Hbond_count[i] = NA
	}
}

percent <- vector("numeric", max(Hbond_count, na.rm = TRUE))
for (i in 0:max(Hbond_count, na.rm = TRUE)+1) {
	percent[i]=sum(Hbond_count==i-1, na.rm = TRUE)
}
percent <- round(percent/sum(percent, na.rm = TRUE)*100, 2)

png(filename=args[3], width=600, height=600)
if (args[4]=="MC") {
	if (args[5]=="acceptor") {
		plot(access_per, Hbond_count, ylim=c(0,max_bonds_acceptor), xlab = "surface accessibility of the main chain (%)", ylab = "number of hydrogen bonds for each acceptor (% on the RIGHT)", col="brown2")
	} else {
		plot(access_per, Hbond_count, ylim=c(0,max_bonds_donor), xlab = "surface accessibility of the main chain (%)", ylab = "number of hydrogen bonds for each donor (% on the RIGHT)", col="brown2")
	}
} else {
	if (args[5]=="acceptor") {
		plot(access_per, Hbond_count, ylim=c(0,max_bonds_acceptor), xlab = "surface accessibility of the polar side chain (%)", ylab = "number of hydrogen bonds for each acceptor (% on the RIGHT)", col="brown2")
	} else {
		plot(access_per, Hbond_count, ylim=c(0,max_bonds_donor), xlab = "surface accessibility of the polar side chain (%)", ylab = "number of hydrogen bonds for each donor (% on the RIGHT)", col="brown2")
	}
}
axis(4, at=0:max(Hbond_count, na.rm = TRUE), labels=percent)
dev.off()

#Figure x : Number of hydrogen bonds and percentage for each acceptor according to the surface accessibility of the main chain
#Figure x : Number of hydrogen bonds and percentage for each acceptor according to the surface accessibility of the polar side chain
