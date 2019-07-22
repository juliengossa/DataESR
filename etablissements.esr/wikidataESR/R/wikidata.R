# This file is part of wikidataESR.
#
# wikidataESR is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# wikidataESR is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

#' @author Julien Gossa, \email{gossa@unistra.fr}
#' @references \url{https://cran.r-project.org/web/packages/WikidataR/}
#' @seealso \url{https://www.wikidata.org}
#' @keywords wikidata, ESR

library(WikidataR)
library(stringr)
library(stringi)

wd.env <- new.env()
wd.env$instance_ofs <- data.frame("id"=character(),"label"=character())

#' Get the instance of an item
#'
#' @param item a wikidata item
#'
#' @return the instance of the item
#'
#' @examples wd_get_item_instance_of(item)
wd_get_item_instance_of <- function(item) {
  instance_of_id <- wd_get_item_statement_as_list(item,"P31")[[1]][[1]]
  if(is.null(instance_of_id)) return(NA)
  if (!instance_of_id %in% wd.env$instance_ofs$id) {
    it <- WikidataR::get_item(id = instance_of_id)
    wd.env$instance_ofs <- rbind(wd.env$instance_ofs,cbind("id"=instance_of_id,"label"=wd_get_item_label(it)))
  }

  return(subset(wd.env$instance_ofs, id == instance_of_id, label)[[1]])
}

#' Get the label of a wikidata item
#' Check for fr first, and get the en otherwise
#'
#' @param item a wikidata item
#'
#' @return the label of the item
#'
#' @examples wd_get_item_label(item)
wd_get_item_label <- function(item) {
  ifelse(!is.null(item[[1]]$labels$fr$value[[1]]),
         item[[1]]$labels$fr$value[[1]],
         item[[1]]$labels$en$value[[1]])
}

#' Get the shortest alias of an item.
#'
#' If no alias found, return the label.
#'
#' @param item a wikidata item
#'
#' @return the shortest alias of an item
#'
#' @examples wd_get_item_alias(item)
wd_get_item_alias <- function(item) {
  a <- c(item[[1]]$aliases$fr$value,item[[1]]$aliases$en$value)
  if(length(a) == 0)
    return(wd_get_item_label(item))
    #return(abbreviate(stringi::stri_enc_toascii(wd_get_item_label(item)),12))
  return(a[stringr::str_length(a) == min(stringr::str_length(a))][1])
}

#' Get the year from a statement of the item
#' (It's very dirty)
#'
#' @param item a wikidata item
#' @param prop the property to get the year from
#'
#' @return the year inside a statement of the item
#'
#' @examples wd_get_item_statement_as_year(item, "P571")
wd_get_item_statement_as_year <- function(item,prop) {
  tryCatch(
    date <- item[[1]]$claims[[prop]]$mainsnak$datavalue$value$time[1],
    error = function(e) date<-NULL)

  return(ifelse(is.null(date),NA,substr(as.character.Date(date),2,5)))
}

#' Get the list of statements for a given property
#'
#' @param item a wikidata item
#' @param prop the property to get the statement for
#'
#' @return the liste of statements
#'
#' @examples wd_get_item_statement_as_list(item,"P527")
wd_get_item_statement_as_list <- function(item,prop) {
  I(list(item[[1]]$claims[[prop]]$mainsnak$datavalue$value$id))
}

#' Get the qualifiers of statements of the item
#'
#' @param item a wikidata item
#' @param prop the property to get the statements
#' @param qual the qualifier to retrieve
#'
#' @return a liste of item statement qualifiers
#'
#' @examples wd_get_item_statement_qualifier_as_list(item,"P1365","P585")
wd_get_item_statement_qualifier_as_list <- function(item,prop,qual) {
  dates <- item[[1]]$claims[[prop]]$qualifiers[[qual]]
  if(is.null(dates)) return(NA)
  l <- unlist(
    lapply(item[[1]]$claims[[prop]]$qualifiers[[qual]],
           function(x) substr(x$datavalue$value$time,2,5)))
  return(I(list(l)))
}

