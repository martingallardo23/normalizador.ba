#' Buscar cordenadas a partir de dirección (Geocoding) basado en USIG 2.1.2
#'
#' Encuentra la coordenada más cercana a la dirección provista. Formato de
#' output es `lonlat` (longitud, latitud) por default. Seleccionar `gkba` o
#' `degrees` en el parámetro `output` para modificar.
#' A diferencia de `geocode` (que utiliza el sistema USIG 2.2),
#' se utiliza el sistema previo USIG 2.1.2.
#'
#' @param direccion Character. Incluye calle y altura o intersección.
#' @param maxOptions Numeric. Cantidad máxima de opciones a devolver
#' @param output Uno de `gkba`, `lonlat` o `degrees`.
#' Formato de las coordenadas de salida.
#' @param srid Numeric or string. SRID a usar en la geocodificación. El
#' default es `srid = 4326`
#' @examples
#' geocode2(calle  = "Córdoba av 637, caba")
#'
#' geocode2(direccion  = "Córdoba 637",
#'          maxOptions = 2,
#'          output     = "gkba")
#' @export
geocode2 <- function(direccion, maxOptions = 1, output = "lonlat",
                     srid = "4326") {

  if (!(output %in% c("lonlat", "degrees", "gkba"))) {
    rlang::abort(c("x" = "`output` debe ser 'lonlat', 'degrees', o 'gkba'"))
  }

  direccion <- gsub(" ", "%20", direccion)

  url <- paste0(url_usig_old, "?direccion=", direccion,
                "&maxOptions=", maxOptions,
                "&geocodificar=True&srid=", srid)

  data <- httr::GET(url)
  data <- jsonlite::fromJSON(rawToChar(data$content))
  if (!is.null(data$errorMessage)) {
    rlang::abort(c("x" = "Dirección no encontrada."))
  }
  data <- dplyr::tibble(direccion = data$direccionesNormalizadas$direccion,
                        x         = data$direccionesNormalizadas$coordenadas$x,
                        y         = data$direccionesNormalizadas$coordenadas$y)

  if (output != "lonlat") {
    for (ii in 1:nrow(data)) {
      data[ii, c("x", "y")] <- convertir_coord(data[ii,"x"], data[ii, "y"], output = output)
    }
  }
  return(data)
}
