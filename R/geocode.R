#' Buscar cordenadas a partir de dirección (Geocoding)
#'
#' Encuentra la coordenada más cercana a la dirección provista. Formato de
#' output es `gkba (x,y)` por default. Seleccionar `lonlat` o `degrees` en el
#' parámetro `output` para modificar.
#'
#' @param calle Nombre de la calle o intersección completa
#' @param altura Altura de la calle (vacío en caos de intersección)
#' @param desambiguar Permitir permutaciones de las palabras de `calle` (1)
#' o no (0)
#' @param output Formato de las coordenadas de salida. Uno de `gkba`,
#' `lonlat` o `degrees`.
#' @examples
#' geocode(calle  = "Córdoba av",
#'         altura = 637)
#'
#' geocode(calle  = "Córdoba av",
#'         altura = 637,
#'         output = "lonlat")
#' @export
geocode <- function(calle, altura = NULL, desambiguar = 1, output = "gkba") {

  calle <- gsub(" ", "%20", calle)

  if (!is.null(altura)) {
  url <- paste0(url_usig_rest, "normalizar_y_geocodificar_direcciones?calle=", calle,
                "&altura=", altura, "&desambiguar=", desambiguar)
  } else {

  url <- paste0(url_usig_rest, "normalizar_y_geocodificar_direcciones?calle=", calle,
                "&desambiguar=", desambiguar)
  }


  data <- httr::GET(url)
  data <- jsonlite::fromJSON(rawToChar(data$content))
  data <- dplyr::as_tibble(data$GeoCodificacion)

  if (output != "gkba") {
    data <- convertir_coord(data$x, data$y, output = output)
  }

  return(data)
}
