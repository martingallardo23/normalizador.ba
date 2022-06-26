#' Buscar dirección a partir de coordenadas (Reverse Geocoding)
#'
#' Encuentra la dirección más cercana a la coordenada provista. Formato de
#' coordenada detectado automáticamente.
#'
#' @param x Coordenada x o longitud
#' @param y Coordenada y o latitud
#' @examples
#' coord_a_dir(x = -58.37583628694437,
#'             y = -34.59857730467378)
#' @export
reverse_geocode <- function(x, y) {

  url <- paste0(url_usig_geocoder, "reversegeocoding?x=", x,
                "&y=", y)

  data <- httr::GET(url)
  data <- jsonlite::fromJSON(gsub("\\(|\\)", '', rawToChar(data$content)))
  data <- dplyr::as_tibble(data)

  return(data)
}
