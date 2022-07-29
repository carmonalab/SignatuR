# SignatuR

A database of useful gene signatures for single-cell analysis


## Install
Get the database and its accessor functions:
```
remotes::install_github("carmonalab/SignatuR")
library(SignatuR)
```

## Data format

The DB is structured as a [data.tree](https://cran.r-project.org/web/packages/data.tree/vignettes/data.tree.html) object, with signatures organized by species and category.
Gene lists are stored in the "Signature" attribute, comments and references for the signature are stored in the "Reference" attribute.

Several functions for easy interaction with the data structure have been implemented. See some examples below:


* See database structure
```
SignatuR
```

* See database with annotations
```
print(SignatuR, "Reference","Signature")
```

* Plot database structure (requires installing `DiagrammeR`)
```
library(DiagrammeR)
plot(SignatuR)
```

* Extract a specific signature
```
s <- GetSignature(SignatuR$Mm$Programs$HeatShock)
```

* Extract all signatures below a given node
```
ss <- GetSignature(SignatuR$Mm$Programs)
```

* Add a new signature to the DB (e.g. to "Cell_types" node)
```
SignatuR <- AddSignature(SignatuR,
	node=SignatuR$Mm$Cell_types,name="T_cell",
	reference="A simple T cell signature",
	signature=c("Cd2","Cd3d","Cd3e"))
```

* Add a new node to the DB
```
SignatuR <- AddNode(SignatuR, parent_node=SignatuR$Hs, name="New_category")
```

* Save updated database (for package developers)
```
usethis::use_data(SignatuR, overwrite = TRUE)
```


## Use examples

* In gene feature selection for (data integration)[https://carmonalab.github.io/STACAS.demo/STACAS.demo.html#important-notes]

## To do

* Consider non-programmatical interface to add signatures (e.g. editing a text/csv file)
* Consider adding nodes for signature sets used by other tools

