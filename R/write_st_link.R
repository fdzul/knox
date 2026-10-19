#' @title Writting shapefile of space-time links
#' @description Writing shapefile from a data frame of space-time links
#' @author Thanh Le Viet, \email{lethanhx2k@@gmail.com}
#' @param data A data frame holds at least 3 columns: longtitude, latitude and
#'   time.
#' @param x Longitude, should be projected to a planar system.
#' @param y Latitude, should be projected to a planar system.
#' @param time time column.
#' @param ds  a cut-off distance in space.
#' @param dt  a cut-off distance in time.
#' @param w default is TRUE, to write out a shapefile.
#' @param file.out default is "st_links", shapfile name to be written.
#' @param ... parameters of the plot function of a line, i.e col, width, etc.
#' @return A plot of space-time links in lines. By default, \code{w} is set
#'   TRUE, a shapefile will be written out as well.
#' @seealso \code{\link{st_link}}
#' @export
writeSHP <- function(data, x, y, time, ds, dt, w = TRUE, file.out = "st_links", ...){
  if (!requireNamespace("sf", quietly = TRUE)) {
    stop("Package 'sf' is needed for writeSHP(). Install it with install.packages('sf').")
  }
  st_link <- with(data, st_link(x = x, y = y, time = time, ds = ds, dt = dt))
  lines <- lapply(seq_len(nrow(st_link)), function(i) {
    with(st_link[i, ], sf::st_linestring(cbind(c(Xo, Xd), c(Yo, Yd))))
  })
  shape <- sf::st_sf(id = seq_len(nrow(st_link)), geometry = sf::st_sfc(lines))
  if (w) {
    sf::st_write(shape, dsn = paste0(file.out, ".shp"), quiet = TRUE,
                 delete_dsn = file.exists(paste0(file.out, ".shp")))
  }
  plot(sf::st_geometry(shape), ...)
}
