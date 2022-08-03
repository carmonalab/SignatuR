#' A database of gene signatures for single-cell data analysis
#'
#' The DB is structured in a tree format, using the `data.tree` data type. See the examples below to browse and access this data type.
#' print(SignatuR) 
#' @format A `data.tree` object with signatures organized by species and category. Gene lists are stored in the "Signature" attribute,
#' comments and references for the signature are stored in the "Reference" attribute.
#' \describe{
#'   \item{See database structure}{`SignatuR`}
#'   \item{See database with annotations}{
#'   `print(SignatuR, "Reference","Signature")`}
#'   \item{Plot database structure}{
#'   `library(DiagrammeR)` \cr `plot(SignatuR)`}
#'   \item{Extract a specific signature}{
#'   `GetSignature(SignatuR$Mm$Programs$HeatShock)`}
#'   \item{Extract all signatures below a given node}{
#'   `GetSignature(SignatuR$Mm$Programs)`}
#'   \item{Add a new signature to the DB}{
#'   `SignatuR <- AddSignature(SignatuR, node=SignatuR$Mm$Cell_types,name="T_cell", reference="A simple T cell signature", signature=c("Cd2","Cd3d","Cd3e")`}
#'   \item{Add a new node to the DB}{
#'   `SignatuR <- AddNode(SignatuR, parent_node=SignatuR$Hs, name="New_category")`}
#'   \item{Save updated database (for developers)}{
#'   `usethis::use_data(SignatuR, overwrite = TRUE)`}
#' }
#' @import data.tree
"SignatuR"

#' Get signatures from DB
#'
#' Return one or more signatures from a specified database node. If an
#' intermediate node is specified, all signatures below that node are returned
#' as a list of signatures.
#'
#' @param node A database node, either internal or leaf
#' @return A single signature or list of signatures
#' @examples
#' # Single signature
#' GetSignature(SignatuR$Mm$Programs$HeatShock)
#' # Multiple signature from intermediate node
#' s <- GetSignature(SignatuR$Mm$Programs)
#' lapply(s, head)
#' @import data.tree
#' @export 

GetSignature <- function(node) {
   if (is.null(node)) {
      stop("Node does not exist.")
   }
   sigs <- node$Get("Signature")
   #Do not return empty signatures
   return(sigs[!is.na(sigs)])
}

#' Add signature to DB
#'
#' Add a new signature to the DB. This generates a local, updated copy of the database.
#'
#' @param db The database object to be updated
#' @param node A database node where the new signature should be added
#' @param name Signature name
#' @param signature Gene signature, as a vector of genes
#' @param reference A text describing source of the signature or other comments
#' @param overwrite Whether to replace an already existing signature with the same name
#' @return An update database containing the new signature
#' @examples
#' SignatuR <- AddSignature(SignatuR, node=SignatuR$Mm$Cell_types,
#'     name="T_cell", reference="A simple T cell signature", signature=c("Cd2","Cd3d","Cd3e"))
#' @import data.tree
#' @export 

AddSignature <- function(db, node, name="New_signature",
                         signature=NA, reference=NA,
                         overwrite=FALSE) {
   clone <- Clone(db)
   path <- node$Climb()$path

   loc <- clone
   if (length(path)>1) {
     for (i in 2:length(path)) {
       loc <- loc[[path[i]]]
     }
   }
   
   #check existing children
   if (name %in% names(node$children)) {
     if (overwrite == TRUE) {
       message(sprintf("Overwriting signature %s", name))
     } else {
       stop(sprintf("Signature %s is already present. Set overwrite=TRUE to replace it.", name))
     }
   }
   #add child
   loc$AddChild(name=name,
                  Reference=reference,
                  Signature=signature)
   
   
   sig_reformat(clone)
   return(clone)
}

#' Remove signature from DB
#'
#' Remove a given signature or node from the database
#'
#' @param node A database node to be removed
#' @return Nothing. The DB is modified in place.
#' @examples
#' RemoveSignature(SignatuR$Hs$Compartments$TCR)
#' @import data.tree
#' @export 

RemoveSignature <- function(node) {
  parent <- node$parent
  m <- names(parent$children) != node$name
  parent$children <- parent$children[m]
  sig_reformat(node)
  invisible(node)
}  

#' Add node to DB
#'
#' Add a new internal node to the DB. This generates a local, updated copy of the database.
#'
#' @param db The database object to be updated
#' @param parent_node The parent node where the new node should be added
#' @param name Name for the new node
#' @param reference Optional text to describe the node
#' @return An update database containing the new node
#' @examples
#' SignatuR <- AddNode(SignatuR, parent_node=SignatuR$Hs, name="New_category")
#' @import data.tree
#' @export 

AddNode <- function(db, parent_node, name="New_signature", reference=NA) {
  clone <- Clone(db)
  path <- parent_node$Climb()$path
  
  loc <- clone
  if (length(path)>1) {
    for (i in 2:length(path)) {
      loc <- loc[[path[i]]]
    }
  }   
  loc$AddChild(name=name,
               Reference=reference)
  
  sig_reformat(clone)
  return(clone)
}

#' Save a local copy of SignatuR
#'
#' Store a modified copy of your SignatuR DB, either to a .rds or .rda file
#'
#' @param db The database object to be saved
#' @param file Destination file (.rds or .rda)
#' @examples
#' # Save DB
#' SaveSignatuR(SignatuR, file="mySignatuR.rds")
#' # Load it back
#' mySignatuR <- LoadSignatuR("mySignatuR.rds")
#' @import data.tree
#' @importFrom tools file_ext
#' @seealso [LoadSignatuR]
#' @export 

SaveSignatuR <- function(db, file="mySignatuR.rds") {
  
  ext <- tolower(file_ext(file))
  message(sprintf("Saving %s to file: %s", db$name, file))
  if (ext == "rds") {
    saveRDS(db, file=file)
  } else if (ext == "rda") {
    save(db, file=file)
  } else {
    stop(sprintf("Format %s not supported", ext))
  }
}

#' Load SignatuR from local file
#'
#' Load a .rds or .rda file storing a SignatuR object
#'
#' @param file Source file (.rds or .rda)
#' @return A SignatuR object
#' @examples
#' mySignatuR <- LoadSignatuR(file="mySignatuR.rds")
#' @import data.tree
#' @importFrom tools file_ext
#' @seealso [SaveSignatuR]
#' @export 

LoadSignatuR <- function(file="mySignatuR.rds") {
  
  ext <- tolower(file_ext(file))
  
  if (ext == "rds") {
    return(readRDS(file))
  } else if (ext == "rda") {
    name <- load(file)
    return(get(name))
  } else {
    stop(sprintf("Cannot read file %s", file))
  }
}

### HELPER (non-exported) functions

#Formatting for printing signature (max 3 genes)
sig_reformat <- function(db) {
  SetFormat(db, "Signature", formatFun = function(x) {
    if (length(x) > 3) {
      paste0(c(x[1:3], "..."))
    } else {
      x[1:length(x)]
    }
  })
}

