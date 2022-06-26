#' Convertir formato de coordenadas
#'
#' Convierte coordenadas a formatos `GKBA`, `WGS84 (Lon/Lat)` y
#'  `WGS84 (grados, minutos y segundos)`. El parámetro `output` puede ser uno de
#'  `gkba`, `lonlat` o `degrees`.
#'  Acepta cualquier formato de entrada. El formato de entrada es
#'  detectado automáticamente.
#'
#'
#' @param x Coordenada `x`
#' @param y Coordenada `y`
#' @param output Formato de coordenada de salida. Uno de `gkba`, `lonlat` o `degrees`.
#' @examples
#' convertir_coord(x = -58.37583628694437,
#'                 y = -34.59857730467378,
#'                 output = "degrees")
#' @export
convertir_coord <- function(x, y, output = "lonlat") {
  url <- paste0(url_usig_rest, "convertir_coordenadas?x=",
                x, "&y=", y, "&output=", output)

  data <- httr::GET(url)
  data <- jsonlite::fromJSON(rawToChar(data$content))
  data <- dplyr::as_tibble(data$resultado)

  return(data)
}
