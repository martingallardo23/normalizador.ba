
# Normalizador y geocodificador de direcciones

Este paquete provee una interfaz simplificada para interactuar a través
de R con la API del servicio USIG provisto por el Gobierno de la Ciudad
de Buenos Aires. La documentación del servicio original se encuentra
disponible [aquí](https://usig.buenosaires.gob.ar/apis/).

## Instalación

``` r
# install.packages("devtools")
devtools::install_github("martingallardo23/normalizador.ba")
```

``` r
library(normalizador.ba)
```

## Funciones

Las funciones actualmente disponibles son

-   [`normalizar_direccion(calle, altura, desambiguar)`](#book-normalizar_direccion)
-   [`geocode(calle, altura, desambiguar, output)`](#earth_americas-geocode)
-   [`geocode2(direccion, maxOptions, output, srid)`](#earth_asia-geocode2)
-   [`reverse_geocode(x, y)`](#round_pushpin-reverse_geocode)
-   [`datos_utiles(calle, altura, x, y)`](#bulb-datos_utiles)
-   [`convertir_coord(x, y, output)`](#globe_with_meridians-convertir_coord)

## Ejemplos

### :book: `normalizar_direccion`

Utiliza el servicio USIG para normalizar una dirección. Devuelve el
nombre de la calle normalizado y el código identificador. Se puede
buscar una calle y altura o una intersección, en cuyo caso la
intersección completa se incluye en la variable calle.

``` r
data <- normalizar_direccion(calle  = "córdoba", 
                             altura = 637)

dplyr::glimpse(data)
```

    ## Rows: 1
    ## Columns: 3
    ## $ CodigoCalle <chr> "3165"
    ## $ Calle       <chr> "CORDOBA AV."
    ## $ Altura      <chr> "637"

### :earth_americas: `geocode`

Encuentra la coordenada más cercana a la dirección provista. No es
necesario que la dirección esté normalizada.

``` r
data <- geocode(calle  = "Córdoba av",
                altura = 637)

dplyr::glimpse(data)
```

    ## Rows: 1
    ## Columns: 2
    ## $ x <chr> "108019.466613"
    ## $ y <chr> "103392.789588"

``` r
data <- geocode(calle  = "Córdoba av",
                altura = 637,
                output = "lonlat")

dplyr::glimpse(data)
```

    ## Rows: 1
    ## Columns: 2
    ## $ x <chr> "-58.375881"
    ## $ y <chr> "-34.598654"

### :earth_asia: `geocode2`

Encuentra la coordenada más cercana a la dirección provista utilizando
USIG 2.1.2. Ligeramente más flexible que `geocode`. No es necesario
separar la calle y altura. Se recomienda incluir la provincia en la
dirección. Se permite obtener hasta `maxOptions` coordenadas. Se permite
cambiar el sistema de referencia con el parámetro `srid`.

``` r
data <- geocode2(direccion  = "Córdoba y florida, caba")

dplyr::glimpse(data)
```

    ## Rows: 1
    ## Columns: 3
    ## $ direccion <chr> "CORDOBA AV. y FLORIDA, CABA"
    ## $ x         <chr> "-58.375376"
    ## $ y         <chr> "-34.598704"

``` r
data <- geocode2(direccion  = "Córdoba 637",
                 maxOptions = 2,
                 output     = "gkba")

dplyr::glimpse(data)
```

    ## Rows: 2
    ## Columns: 3
    ## $ direccion <chr> "CORDOBA AV. 637, CABA", "Provincia de Córdoba 637, Almirant…
    ## $ x         <chr> "108019.43", "109613.85"
    ## $ y         <chr> "103392.83", "83335.55"

### :round_pushpin: `reverse_geocode`

Encuentra la dirección más cercana a la coordenada provista. Formato de
coordenada detectado automáticamente.

``` r
data <- reverse_geocode(x = -58.37583628694437,
                        y = -34.59857730467378)

dplyr::glimpse(data)
```

    ## Rows: 1
    ## Columns: 9
    ## $ parcela          <chr> "03-041-027"
    ## $ puerta           <chr> "CORDOBA AV. 637"
    ## $ puerta_x         <chr> "108019.466613"
    ## $ puerta_y         <chr> "103392.789588"
    ## $ calle_alturas    <chr> "CORDOBA AV. 601-700"
    ## $ esquina          <chr> "CORDOBA AV. y FLORIDA"
    ## $ metros_a_esquina <chr> "40.8"
    ## $ altura_par       <chr> "CORDOBA AV. 632"
    ## $ altura_impar     <chr> "CORDOBA AV. 631"

### :bulb: `datos_utiles`

Devuelve datos útiles sobre una dirección o coordenada. Ejemplos:
comuna, barrio, comisaría, distrito escolar, código de planeaminento
urbano, etc. Se puede buscar por intersección, calle y altura, o
coordenadas.

``` r
data <- datos_utiles(calle  = "Córdoba av",
                     altura = 637)

dplyr::glimpse(data)
```

    ## Rows: 1
    ## Columns: 14
    ## $ comuna                        <chr> "Comuna 1"
    ## $ barrio                        <chr> "Retiro"
    ## $ comisaria                     <chr> "15"
    ## $ area_hospitalaria             <chr> "HTAL. J.A.FERNÁNDEZ"
    ## $ region_sanitaria              <chr> "I (Este)"
    ## $ distrito_escolar              <chr> "Distrito Escolar   I"
    ## $ comisaria_vecinal             <chr> "1A"
    ## $ seccion_catastral             <chr> "03"
    ## $ distrito_economico            <chr> ""
    ## $ codigo_de_planeamiento_urbano <chr> ""
    ## $ partido_amba                  <chr> ""
    ## $ localidad_amba                <chr> ""
    ## $ codigo_postal                 <chr> "1054"
    ## $ codigo_postal_argentino       <chr> "C1054AAF"

``` r
data <- datos_utiles(x = -58.37583628694437,
                     y = -34.59857730467378)

dplyr::glimpse(data)
```

    ## Rows: 1
    ## Columns: 12
    ## $ comuna                        <chr> "Comuna 1"
    ## $ barrio                        <chr> "Retiro"
    ## $ comisaria                     <chr> "15"
    ## $ area_hospitalaria             <chr> "HTAL. J.A.FERNÁNDEZ"
    ## $ region_sanitaria              <chr> "I (Este)"
    ## $ distrito_escolar              <chr> "Distrito Escolar   I"
    ## $ comisaria_vecinal             <chr> "1A"
    ## $ seccion_catastral             <chr> "03"
    ## $ distrito_economico            <chr> ""
    ## $ codigo_de_planeamiento_urbano <chr> "C2"
    ## $ partido_amba                  <chr> ""
    ## $ localidad_amba                <chr> ""

### :globe_with_meridians: `convertir_coord`

Convierte coordenadas a formatos `GKBA`, `WGS84 (Lon/Lat)` y
`WGS84 (grados, minutos y segundos)`. El parámetro `output` puede ser
uno de `gkba`, `lonlat` o `degrees`. Acepta cualquier formato de
entrada. El formato de entrada es detectado automáticamente.

``` r
data <- convertir_coord(x = -58.37583628694437,
                        y = -34.59857730467378,
                        output = "degrees")

dplyr::glimpse(data)
```

    ## Rows: 1
    ## Columns: 2
    ## $ x <chr> "58d22'33.01\"W"
    ## $ y <chr> "34d35'54.878\"S"
