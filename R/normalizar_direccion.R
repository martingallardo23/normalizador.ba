#' Normalizador de direcciones
#'
#' Utiliza el servicio USIG para normalizar una dirección. Devuelve el nombre
#' de la calle normalizado y el código identificador. Se puede buscar una
#' calle y altura o una intersección, en cuyo caso la intersección se incluye
#' en la variable `calle`.
#'
#'
#' @param calle Nombre de la calle o intersección completa
#' @param altura Altura de la calle (vacío en caos de intersección)
#' @param desambiguar Permitir permutaciones de las palabras de `calle` (1)
#' o no (0)
#' @examples
#' normalizar_direccion("córdoba", 637)
#' @export
normalizar_direccion <- function(calle, altura = NULL, desambiguar = 1) {

  if (!(desambiguar %in% c(0,1))) {
    rlang::abort("x" = "`desambiguar` debe ser 0 o 1")
  }

  calle <- gsub(" ", "%20", calle)
  if (!is.null(altura)) {
  url <- paste0(url_usig_rest, 'normalizar_direcciones?calle=', calle,
                "&altura=", altura, "&desambiguar=", desambiguar)
  } else {
  url <- paste0(url_usig_rest, 'normalizar_direcciones=', calle,
                "&desambiguar=", desambiguar)
  }

  data <- httr::GET(url)
  data <- jsonlite::fromJSON(rawToChar(data$content))
  data <- dplyr::as_tibble(data$DireccionesCalleAltura$direcciones)

  return(data)
}
