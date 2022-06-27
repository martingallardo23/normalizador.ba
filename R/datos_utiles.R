#' Obtener datos útiles sobre una dirección o coordenada
#'
#' Devuelve datos útiles sobre una dirección o coordenada. Ejemplos: comuna,
#' barrio, comisaría, distrito escolar, código postal, etc.
#'
#' @param calle Calle o intersecciónm
#' @param altura Altura de la dirección (si no es intersecciónm)
#' @param x Coordenada x o longitud (sólo si no se usa la dirección)
#' @param y Coordenada y o latitud (sólo si no se usa la dirección)
#' @examples
#' datos_utiles(calle = "Córdoba av",
#'              altura = 637)
#'
#' datos_utiles(x = -58.37583628694437,
#'              y = -34.59857730467378)
#' @export
datos_utiles <- function(calle = NULL, altura = NULL, x=NULL, y=NULL) {

  if (is.null(c(x,y)) & !is.null(calle) ) {

    calle <- gsub(" ", "%20", calle)

    if (!is.null(altura)) {
    url <- paste0(url_usig, "/datos_utiles?calle=", calle,
                  "&altura=", altura)
    } else {
      url <- paste0(url_usig, "/datos_utiles?calle=", calle)
    }
  } else if (!is.null(c(x, y)) & is.null(calle)) {
    url <- paste0(url_usig, "/datos_utiles?x=", x, "&y=", y)
  } else {
    rlang::abort("x" = "Se debe proveer calle, calle y altura o x e y")
  }

  data <- httr::GET(url)
  data <- jsonlite::fromJSON(rawToChar(data$content))
  data <- dplyr::as_tibble(data)

  return(data)
}
