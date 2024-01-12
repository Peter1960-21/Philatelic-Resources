#analysis of philatelic reference library Middle East and Latin America

#remove all object in R 
rm(list=ls(all=TRUE))
curWD <- dirname(rstudioapi::getSourceEditorContext()$path) #Get the directory of current script
setwd(curWD)

Phil_ref = read.csv('Phlatelic Resources -articles, books, websites.csv',sep=',')

library(stringr)
library(data.table)
library(magrittr)
library(writexl)

DT <- as.data.table(Phil_ref)

#unlist authors by Key
Ref_Author = {
  DT[, .(Author = unlist(strsplit(as.character(Author), ";", fixed = TRUE))), 
           by = .(Key)]}

#unlist keywords by key
Ref_Tags = {
  DT[, .(Manual.Tags = unlist(strsplit(as.character(Manual.Tags), ";", fixed = TRUE))), 
     by = .(Key)]}

#general statistics for Authors and Tags files
summary(Ref_Author)
summary(Ref_Tags)

str(Ref_Author)
str(Ref_Tags)

Tbl_Ref_Tags <- table(Ref_Tags)

# Remove duplicates on selected columns
Ref_Author_Unq <- unique( Ref_Author[ , c('Author') ] )
Ref_Tags_Unq <- unique( Ref_Tags[ , c('Manual.Tags') ] )

#summary(Ref_Author_Unq)
#summary(Ref_Tags_Unq)

Ref_Tags$TrimTag <- str_trim(Ref_Tags$Manual.Tags, side="left")
Ref_Author$TrimAuthor <- str_trim(Ref_Author$Author, side="left")

#write.xlsx(Ref_Tags, file = "Ref_Tags.xlsx", sheetName="Ref_Tags", append=False)

write_xlsx(Ref_Tags, 'Ref_Tags.xlsx')
write_xlsx(Ref_Author, 'Ref_Author.xlsx')