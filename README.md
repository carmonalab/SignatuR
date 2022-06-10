# SignatuR

A database of useful gene signatures for single-cell analysis


## Install
Get the database and the documentation using:
```
remotes::install_github("carmonalab/SignatuR")
library(data.tree)
library(SignatuR)
```

## Data format

The DB is structured as a `data.tree` object, with signatures organized by species and category.
Gene lists are stored in the "Signature" attribute, comments and references for the signature are stored in the "Reference" attribute.

See the examples below to browse and access this data type.


* See database structure
```
SignatuR
```

* See database with annotations
```
print(SignatuR, "Reference","Signature")
```

* Plot database structure
```
library(DiagrammeR)
plot(SignatuR)
```

* Extract a specific signature
```
s <- GetSignature(SignatuR$Mm$Programs$HeatShock)
```

* Extract all signatures below a given node (Get accessor)
```
ss <- GetSignature(SignatuR$Mm$Programs)
```

* Add a new signature to the DB (e.g. to "Cell_types" node)
```
SignatuR <- AddSignature(SignatuR,
	node=SignatuR$Mm$Cell_types,name="T_cell",
	reference="A simple T cell signature",
	signature=c("Cd2","Cd3d","Cd3e"
```

* Add a new node to the DB
```
SignatuR <- AddNode(SignatuR, parent_node=SignatuR$Hs, name="New_category")
```

* Save updated database (for package developers)
```
usethis::use_data(SignatuR, overwrite = TRUE)
```


