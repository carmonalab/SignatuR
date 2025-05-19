library(usethis)
library(data.tree)
library(tools)

file = "data-raw/mySignatuR.csv"

ext <- tolower(tools::file_ext(file))
df <- read.csv(file=file)
df$Signature <- gsub(pattern=";", replacement = ",", x = df$Signature)
SignatuR <- FromDataFrameTable(df)
SignatuR <- sig_reformat(SignatuR)

#Save to RDA (SignatuR.rda)
usethis::use_data(SignatuR, overwrite = TRUE)