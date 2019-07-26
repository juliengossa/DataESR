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
