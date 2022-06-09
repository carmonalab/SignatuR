# SignatuR

A database of useful gene signatures for single-cell analysis


## Install
Get the database and the documentation using:
```
remotes::install_github("carmonalab/SignatuR")
```

## Data format

The DB is structured as a `data.tree` object, with signatures organized by species and category.
Gene lists are stored in the "Signature" attribute, comments and references for the signature are stored in the "Reference" attribute.

See the examples below to browse and access this data type.


* Load database into memory
```
library(SignatuR)
data("SignatuR")
```

* See database structure
```
print(SignatuR)
```

* Plot database structure
```
library(DiagrammeR)
plot(SignatuR)
```

* See database with annotations
```
print(SignatuR, "Reference","Signature")
```

* Extract a specific signature
```
s <- SignatuR$Hs$Compartments$TCR$Signature
head(s)
```

* Extract all signatures below a given node (Get accessor)
```
ss <- SignatuR$Hs$Compartments$Get("Signature", filterFun = isLeaf)
lapply(ss, head)
```

