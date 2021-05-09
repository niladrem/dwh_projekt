vendor <- read.csv("vendor.csv", header=F, sep=";")
colnames(vendor) <- c("name", "since", "address", "voivodeship", "postalcode", "city", "url", "flag")
library(stringi)
library(dplyr)

street <- function(addr){
  a <- stri_replace_first_regex(addr, "^[Uu][Ll]\\. ?", "") %>% stri_replace_first_regex(",? ?(nr )?\\d.*$", "")
  return(a)
}
streetnumber <- function(addr){
  a <- stri_replace_first_regex(addr, "^\\D*", "")
  return(a)
}
vendor$ad_street <- street(vendor$address)
vendor$ad_streetnumber <- streetnumber(vendor$address)
write.csv2(vendor, "vendor2.csv", quote=F)
vendor2 <- read.csv("vendor2.csv", header=F, sep=";", encoding="UTF-8", stringsAsFactors=F)

colnames(vendor2) <- c("id", "name", "since", "address", "voivodeship", "postalcode", "city", "url", "flag", "street", "number")
