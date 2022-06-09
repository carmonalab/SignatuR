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

#Read in a list of signatures (from scGate blocklists)
base::load("data-raw/genes.blacklist.default.RData")

###########################################
# ADD SIGNATURES
# - mouse
programs.mm$AddChild("cellCycle.G1S",
                         Reference = "Tirosh et al. Science (2016)",
                         Signature=genes.blacklist.default$Mm$cellCycle.G1S)

programs.mm$AddChild("cellCycle.G2M",
                         Reference = "Tirosh et al. Science (2016)",
                         Signature=genes.blacklist.default$Mm$cellCycle.G2M)

programs.mm$AddChild("HeatShock",
                         Reference = "Curated HSPs",
                         Signature=genes.blacklist.default$Mm$HeatShock)

programs.mm$AddChild("IfnResp",
                     Reference = "Interferon response genes",
                     Signature=genes.blacklist.default$Mm$IfnResp)


compartments.mm$AddChild("Mito",
                         Reference = "Mitochondrial genes",
                         Signature=genes.blacklist.default$Mm$Mito)

compartments.mm$AddChild("Ribo",
                         Reference = "Ribosomal genes",
                         Signature=genes.blacklist.default$Mm$Ribo)

compartments.mm$AddChild("TCR",
                         Reference = "T cell receptor genes",
                         Signature=genes.blacklist.default$Mm$TCR)
# - human
programs.hs$AddChild("cellCycle.G1S",
                     Reference = "Tirosh et al. Science (2016)",
                     Signature=genes.blacklist.default$Hs$cellCycle.G1S)

programs.hs$AddChild("cellCycle.G2M",
                     Reference = "Tirosh et al. Science (2016)",
                     Signature=genes.blacklist.default$Hs$cellCycle.G2M)

compartments.hs$AddChild("Mito",
                         Reference = "Mitochondrial genes",
                         Signature=genes.blacklist.default$Hs$Mito)

compartments.hs$AddChild("Ribo",
                         Reference = "Ribosomal genes",
                         Signature=genes.blacklist.default$Hs$Ribo)

compartments.hs$AddChild("TCR",
                         Reference = "T cell receptor genes",
                         Signature=genes.blacklist.default$Hs$TCR)




#Set format for visualizing
SetFormat(SignatuR, "Signature", formatFun = function(x) {
  if (length(x) > 3) {
    paste0(c(x[1:3], "..."))
  } else {
    x[1:length(x)]
  }
})


#Visualize and access
print(SignatuR)
print(SignatuR, "Reference","Signature")
plot(SignatuR)

head(SignatuR$Hs$Compartments$TCR$Signature)
lapply(SignatuR$Hs$Compartments$Get("Signature", filterFun = isLeaf), head)

#Save processed data
usethis::use_data(SignatuR, overwrite = TRUE)
