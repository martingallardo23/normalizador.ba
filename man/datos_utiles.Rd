% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/datos_utiles.R
\name{datos_utiles}
\alias{datos_utiles}
\title{Obtener datos útiles sobre una dirección o coordenada}
\usage{
datos_utiles(calle = NULL, altura = NULL, x = NULL, y = NULL)
}
\arguments{
\item{calle}{Calle o intersecciónm}

\item{altura}{Altura de la dirección (si no es intersecciónm)}

\item{x}{Coordenada x o longitud (sólo si no se usa la dirección)}

\item{y}{Coordenada y o latitud (sólo si no se usa la dirección)}
}
\description{
Devuelve datos útiles sobre una dirección o coordenada. Ejemplos: comuna,
barrio, comisaría, distrito escolar, código postal, etc.
}
\examples{
datos_utiles(calle = "Córdoba av",
             altura = 637)

datos_utiles(x = -58.37583628694437,
             y = -34.59857730467378)
}
