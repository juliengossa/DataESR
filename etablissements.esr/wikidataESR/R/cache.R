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
#
# Author: Julien Gossa <gossa@unistra.fr>


#' Instance_of of french ESR institutions.
#'
#' A dataset containing the main instance_of (nature) french ESR institutions,
#' together with some additionnal informations.
#'
#' @format A data frame with 6 variables:
#' - id: the wikipedia id of the item;
#' - libellé: the libellé (label) of the item;
#' - recommandé: whether this item is recommanded to use ("oui") or not ("non");
#' - niveau: level of the item (1:international, 2:national, 3:group of institutions, 4:institutions, 5:intermediary level, 6:sub-institutions);
#' - wikipedia: url to the wikipedia notice;
#' - note: note to help the user.

#' @source \url{https://www.wikidata.org}
"wdesr.natures"


#' Clear the local WDESR cache.
#'
#' To improve the performances, wikidata items are cached.
#' Must be used whenever the data of wikidata are modified during a R session.
#'
#' @return The WDESR cache.
#' @export
#'
#' @examples wdesr_clear_cache()
#'
#' @references
#' - \url{https://github.com/juliengossa/DataESR/tree/master/etablissements.esr/wikidataESR}
#' @seealso
#' - \code{\link{wdesr_get_cache}}
#' - \code{\link{wdesr_save_cache}}
#' - \code{\link{wdesr_load_cache}}
#' @author Julien Gossa, \email{gossa@unistra.fr}
wdesr_clear_cache <- function() {
  wdesr.cache$instance_ofs <- data.frame("id"=character(),"label"=character())
  wdesr.cache$items <- data.frame()

  return(wdesr.cache)
}

#' Get the cache.
#'
#' To improve the performances, wikidata items are cached.
#' This function returns this cache.
#' It contains two dataframes: instance_ofs and items.
#'
#' @return The WDESR cache.
#' @export
#'
#' @examples
#' wdesr.cache <- wdesr_get_cache()
#' wdesr.cache$instance_ofs
#' wdesr.cache$items
#' @references
#' - \url{https://github.com/juliengossa/DataESR/tree/master/etablissements.esr/wikidataESR}
#' @seealso
#' - \code{\link{wdesr_clear_cache}}
#' - \code{\link{wdesr_save_cache}}
#' - \code{\link{wdesr_load_cache}}
#' @author Julien Gossa, \email{gossa@unistra.fr}
wdesr_get_cache <- function() {
  return(wdesr.cache)
}


#' Save the cache.
#'
#' To improve the performances, wikidata items are cached.
#' This function saves this cache on the local drive
#'
#' @param file The name of the file to save the cache to (default to "wdesr-cache.RData").
#'
#' @return nothing
#' @export
#'
#' @examples wdesr_save_cache()
#' @references
#' - \url{https://github.com/juliengossa/DataESR/tree/master/etablissements.esr/wikidataESR}
#' @seealso
#' - \code{\link{wdesr_clear_cache}}
#' - \code{\link{wdesr_get_cache}}
#' - \code{\link{wdesr_load_cache}}
#' @author Julien Gossa, \email{gossa@unistra.fr}
#'
wdesr_save_cache <- function(file = "wdesr-cache.RData") {
  save(instance_ofs, items, envir = wdesr.cache, file = file)
}


#' Load the cache.
#'
#' To improve the performances, wikidata items are cached.
#' This function loads this cache.
#'
#' @param file The name of the file to read the cache from (default to "wdesr-cache.RData").
#' @param default_cache TRUE to load the cache embeded with the package instead of a local cache (default to FALSE).
#'   Be aware that this cache might be outdated compared to wikidata.
#'
#' @return the environment of the cache
#' @export
#'
#' @examples wdesr_load_cache()
#' @references
#' - \url{https://github.com/juliengossa/DataESR/tree/master/etablissements.esr/wikidataESR}
#' @seealso
#' - \code{\link{wdesr_clear_cache}}
#' - \code{\link{wdesr_get_cache}}
#' - \code{\link{wdesr_load_cache}}
#' @author Julien Gossa, \email{gossa@unistra.fr}
#'
wdesr_load_cache <- function(file = "wdesr-cache.RData", default_cache = FALSE) {
  if (default_cache) {
    warning("Using default cache might lead to using deprecated data. Consider building your own cache.")
    wdesr.cache$instance_ofs <- wikidataESR:::instance_ofs
    wdesr.cache$items <- wikidataESR:::items
  } else {
    load(file = "wdesr-cache.RData", envir = wdesr.cache )
  }

  return(wdesr.cache)
}

# Initialization of the cache
wdesr.cache <- new.env()
wdesr_clear_cache()
#wdesr_load_cache(default=TRUE)


#' Maintainance function to build local cache and datasets
#'
#' @return nothing
#'
#' @examples wdes_make_local_data()
#' @noRd
wdes_make_local_data <- function() {
  wdesr.natures <- read.table("wdesr.natures.csv",header=TRUE,sep=';',quote='"')
  usethis::use_data(wdesr.natures, overwrite = TRUE)

  usethis::use_data(items,instance_ofs, internal = TRUE, overwrite = TRUE)
}
