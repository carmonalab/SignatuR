#' A database of gene signatures for single-cell data analysis
#'
#' The DB is structured in a tree format, using the `data.tree` data type. See the examples below to browse and access this data type.
#' print(SignatuR) 
#' @format A `data.tree` object with signatures organized by species and category. Gene lists are stored in the "Signature" attribute,
#' comments and references for the signature are stored in the "Reference" attribute.
#' \describe{
#'   \item{Load DB}{
#'   `library(SignatuR)` \cr `data("SignatuR")`}
#'   \item{See database structure}{
#'   `print(SignatuR)`}
#'   \item{Plot database structure}{
#'   `library(DiagrammeR)` \cr `plot(SignatuR)`}
#'   \item{See database with annotations}{
#'   `print(SignatuR, "Reference","Signature")`}
#'   \item{Extract a specific signature}{
#'   `SignatuR$Hs$Compartments$TCR$Signature`}
#'   \item{Extract all signatures below a given node (Get accessor)}{
#'   `SignatuR$Hs$Compartments$Get("Signature", filterFun = isLeaf)`}
#'   \item{Add a new signature to the DB (e.g. to cell types node)}{
#'   `node <- SignatuR$Mm$Cell_types` \cr `node$AddChild("Tcell", Reference="A simple T cell signature", Signature=c("Cd2","Cd3d","Cd3e"))`}
#' }
#' @import data.tree
"SignatuR"