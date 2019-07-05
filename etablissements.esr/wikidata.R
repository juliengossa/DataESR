library(WikidataR)
library(stringr)
library(stringi)


wd_get_item_instance_of <- function(item) {
  instance_ofID <- wd_get_item_statement_as_list(item,"P31")[[1]][[1]]
  if(is.null(instance_ofID)) return(NA)
  if (!instance_ofID %in% instance_ofs$id) {
    it <- get_item(id = instance_ofID)
    instance_ofs <<- rbind(instance_ofs,cbind("id"=instance_ofID,"label"=wd_get_item_label(it)))
  }
  
  return(subset(instance_ofs, id == instance_ofID, label)[[1]])
}

wd_get_item_label <- function(item) {
  ifelse(!is.null(item[[1]]$labels$fr$value[[1]]),
         item[[1]]$labels$fr$value[[1]],
         item[[1]]$labels$en$value[[1]])
}

wd_get_item_alias <- function(item) {
  a <- c(item[[1]]$aliases$fr$value,item[[1]]$aliases$en$value)
  if(length(a) == 0) 
    return(abbreviate(stri_enc_toascii(wd_get_item_label(item)),12))
  return(a[str_length(a) == min(str_length(a))][1])
}

wd_get_item_statement_as_year <- function(item,prop) {
  tryCatch(
    date <- item[[1]]$claims[[prop]]$mainsnak$datavalue$value$time[1],
    error = function(e) date<-NULL)
  
  return(ifelse(is.null(date),NA,substr(as.character.Date(date),2,5)))
}

wd_get_item_statement_as_list <- function(item,prop) {
  I(list(item[[1]]$claims[[prop]]$mainsnak$datavalue$value$id))
}

wd_get_item_statement_qualifier_as_list <- function(item,prop,qual) {
  dates <- item[[1]]$claims[[prop]]$qualifiers[[qual]]
  if(is.null(dates)) return(NA)
  l <- unlist(
    lapply(item[[1]]$claims[[prop]]$qualifiers[[qual]], 
           function(x) substr(x$datavalue$value$time,2,5)))
  return(I(list(l)))
}
