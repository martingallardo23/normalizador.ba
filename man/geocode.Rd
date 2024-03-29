% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geocode.R
\name{geocode}
\alias{geocode}
\title{Buscar cordenadas a partir de dirección (Geocoding)}
\usage{
geocode(calle, altura = NULL, desambiguar = 1, output = "gkba")
}
\arguments{
\item{calle}{Nombre de la calle o intersección completa}

\item{altura}{Altura de la calle (vacío en caos de intersección)}

\item{desambiguar}{Permitir permutaciones de las palabras de \code{calle} (1)
o no (0)}

\item{output}{Formato de las coordenadas de salida. Uno de \code{gkba},
\code{lonlat} o \code{degrees}.}
}
\description{
Encuentra la coordenada más cercana a la dirección provista. Formato de
output es \code{gkba (x,y)} por default. Seleccionar \code{lonlat} o \code{degrees} en el
parámetro \code{output} para modificar.
}
\examples{
geocode(calle  = "Córdoba av",
        altura = 637)

geocode(calle  = "Córdoba av",
        altura = 637,
        output = "lonlat")
}
