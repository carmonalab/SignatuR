## CODE to prepare the DB goes here

#libraries
library(data.tree)
library(DiagrammeR)

#Set up root and species
SignatuR <- Node$new("SignatuR")

Hs <- SignatuR$AddChild("Hs")
Mm <- SignatuR$AddChild("Mm") 

#Set up layer of broad categories

blocklists.hs <- Hs$AddChild("Blocklists")
cell_types.hs <-  Hs$AddChild("Cell_types")
programs.hs <-  Hs$AddChild("Programs")
compartments.hs <- Hs$AddChild("Compartments")

blocklists.mm <- Mm$AddChild("Blocklists")
cell_types.mm <-  Mm$AddChild("Cell_types")
programs.mm <-  Mm$AddChild("Programs")
compartments.mm <- Mm$AddChild("Compartments")

print(SignatuR)
plot(SignatuR)

#Add signatures
Tcr <- compartments.hs$AddChild("TCR", Reference = "TCR genes", Signature= c("TRAC","TRBC1","TRBC2"))
cycling <- compartments.hs$AddChild("cycling", Reference = "Tirosh et al.", Signature=c("MKI67","TOP2A"))


#Visualize and access
print(SignatuR)
print(SignatuR, "Reference","Signature")
plot(SignatuR)

SignatuR$Hs$Compartments$Get("Signature")
SignatuR$Hs$Compartments$Get("Signature", filterFun = isLeaf)

#Save processed data
usethis::use_data(SignatuR, overwrite = TRUE)
