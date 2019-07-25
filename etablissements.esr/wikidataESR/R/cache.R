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
# @author Julien Gossa, \email{gossa@unistra.fr}
# @references \url{https://cran.r-project.org/web/packages/WikidataR/}
# @seealso \url{https://www.wikidata.org}
# @keywords wikidata, ESR



#' Clear the local WDESR cache
#'
#' Must be used whenever the data of wikidata are modified during a R session.
#'
#' @return nothing
#' @export
#'
#' @seealso \code{\link{wdesr_clear_cache}} \code{\link{wdesr_get_cache}} \code{\link{wdesr_save_cache}} \code{\link{wdesr_load_cache}}
#' @examples wdesr_clear_cache()
wdesr_clear_cache <- function() {
  wdesr.cache$instance_ofs <- data.frame("id"=character(),"label"=character())
  wdesr.cache$items <- data.frame()
}

#' Get the cache
#'
#' To improve the performances, items are cached.
#' This function returns this cache.
#' It contains two dataframes: instances_ofs and items.
#'
#' @return the environement of the cache
#' @export
#'
#' @seealso \code{\link{wdesr_clear_cache}} \code{\link{wdesr_get_cache}} \code{\link{wdesr_save_cache}} \code{\link{wdesr_load_cache}}
#' @examples
#' wdesr.cache <- wdesr_get_cache()
#' wdesr.cache$instance_ofs
#' wdesr.cache$items
wdesr_get_cache <- function() {
  return(wdesr.cache)
}


#' Save the cache
#'
#' To improve the performances, items are cached.
#' This function saves this cache.
#'
#' @return nothing
#' @export
#'
#' @seealso \code{\link{wdesr_clear_cache}} \code{\link{wdesr_get_cache}} \code{\link{wdesr_save_cache}} \code{\link{wdesr_load_cache}}
#' @examples wdesr_save_cache()
wdesr_save_cache <- function() {
  save(instance_ofs, items, envir = wdesr.cache, file = "wdesr-cache.RData")
}


#' Load the cache
#'
#' To improve the performances, items are cached.
#' This function loads this cache.
#'
#' @return the environment of the cache
#' @export
#'
#' @seealso \code{\link{wdesr_clear_cache}} \code{\link{wdesr_get_cache}} \code{\link{wdesr_save_cache}} \code{\link{wdesr_load_cache}}
#'
#' @examples wdesr_load_cache()
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
