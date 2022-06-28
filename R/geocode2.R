#' Buscar cordenadas a partir de dirección (Geocoding) basado en USIG 2.1.2
#'
#' Encuentra la coordenada más cercana a la dirección provista. Formato de
#' output es `lonlat` (longitud, latitud) por default. Seleccionar `gkba` o
#' `degrees` en el parámetro `output` para modificar.
#' A diferencia de `geocode` (que utiliza el sistema USIG 2.2),
#' se utiliza el sistema previo USIG 2.1.2.
#'
#' @param direccion Incluye calle y altura o intersección
#' @param maxOptions Cantidad máxima de opciones a devolver
#' @param output Formato de las coordenadas de salida. Uno de `gkba`,
#' `lonlat` o `degrees`.
#' @examples
#' geocode2(calle  = "Córdoba av 637, caba")
#'
#' geocode(calle  = "Córdoba y florida, caba")
#' @export
geocode2 <- function(direccion, maxOptions = 1, output = "lonlat") {

  if (!(output %in% c("lonlat", "degrees", "gkba"))) {
    rlang::abort(c("x" = "`output` debe ser 'lonlat', 'degrees', o 'gkba'"))
  }

  direccion <- gsub(" ", "%20", direccion)

  url <- paste0(url_usig_old, "?direccion=", direccion,
                "&maxOptions=", maxOptions)

  data <- httr::GET(url)
  data <- jsonlite::fromJSON(rawToChar(data$content))
  if (!is.null(data$errorMessage)) {
    rlang::abort(c("x" = "Dirección no encontrada."))
  }
  data <- dplyr::as_tibble(data$direccionesNormalizadas$coordenadas[c('x', 'y')])

  if (output != "lonlat") {
    data <- convertir_coord(data$x, data$y, output = output)
  }

  return(data)
}
