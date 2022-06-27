# Normalizador y geocodificador de direcciones

Este paquete provee una interfaz simplificada para interactuar a través de R con la API del servicio USIG provisto por el Gobierno de la Ciudad de Buenos Aires. La documentación del servicio original se encuentra disponible [aquí](https://usig.buenosaires.gob.ar/apis/).

## Instalación
```r
# install.packages("devtools")
devtools::install_github("martingallardo23/normalizador.ba")
```

Las funciones actualmente disponibles son

- [`normalizar_direccion(calle, altura, desambiguar)`](#book-normalizar_direccion)
- [`geocode(calle, altura, desambiguar, output)`](#earth-americas-geocode)
- [`reverse_geocode(x, y)`](#round_pushpin-reverse_geocode)
- [`datos_utiles(calle, altura, x, y)`](#bulb-datos_utiles)
- [`convertir_coord(x, y, output)`](#globe_with_meridians-convertir_coordenadas)

## Funciones

### :book: `normalizar_direccion`

Utiliza el servicio USIG para normalizar una dirección. Devuelve el nombre de la calle normalizado y el código identificador. Se puede buscar una calle y altura o una intersección, en cuyo caso la intersección completa se incluye en la variable calle. 

```r
data <- normalizar_direccion(calle  = "córdoba", 
                             altura = 637)

dplyr::glimpse(data)

# Rows: 1
# Columns: 3
# $ CodigoCalle <chr> "3165"
# $ Calle       <chr> "CORDOBA AV."
# $ Altura      <chr> "637"
```

### :earth_americas: `geocode`

Encuentra la coordenada más cercana a la dirección provista. No es necesario que la dirección esté normalizada. 
 
```r
data <- geocode(calle  = "Córdoba av",
                altura = 637)

dplyr::glimpse(data)

# Rows: 1
# Columns: 2
# $ x <chr> "108019.466613"
# $ y <chr> "103392.789588"

data <- geocode(calle  = "Córdoba av",
                altura = 637,
                output = "lonlat")

dplyr::glimpse(data)
        
# Rows: 1
# Columns: 2
# $ x <chr> "-58.375881"
# $ y <chr> "-34.598654"
```
### :round_pushpin: `reverse_geocode`

Encuentra la dirección más cercana a la coordenada provista. Formato de coordenada detectado automáticamente.
 
```r
coord_a_dir(x = -58.37583628694437,
            y = -34.59857730467378)

# Rows: 1
# Columns: 9
# $ parcela          <chr> "03-041-027"
# $ puerta           <chr> "CORDOBA AV. 637"
# $ puerta_x         <chr> "108019.466613"
# $ puerta_y         <chr> "103392.789588"
# $ calle_alturas    <chr> "CORDOBA AV. 601-700"
# $ esquina          <chr> "CORDOBA AV. y FLORIDA"
# $ metros_a_esquina <chr> "40.8"
# $ altura_par       <chr> "CORDOBA AV. 632"
# $ altura_impar     <chr> "CORDOBA AV. 631"

```

### :bulb: `datos_utiles`

Devuelve datos útiles sobre una dirección o coordenada. Ejemplos: comuna,
barrio, comisaría, distrito escolar, código de planeaminento urbano, etc. Se puede buscar por intersección, calle y altura, o coordenadas.
 
```r
data <- datos_utiles(calle  = "Córdoba av",
                     altura = 637)

dplyr::glimpse(data)

# Rows: 1
# Columns: 12
# $ comuna                        <chr> "Comuna 1"
# $ barrio                        <chr> "Retiro"
# $ comisaria                     <chr> "15"
# $ area_hospitalaria             <chr> "HTAL. J.A.FERNÁNDEZ"
# $ region_sanitaria              <chr> "I (Este)"
# $ distrito_escolar              <chr> "Distrito Escolar   I"
# $ comisaria_vecinal             <chr> "1A"
# $ seccion_catastral             <chr> "03"
# $ distrito_economico            <chr> ""
# $ codigo_de_planeamiento_urbano <chr> "C2"
# $ partido_amba                  <chr> ""
# $ localidad_amba                <chr> ""

data <- datos_utiles(x = -58.37583628694437,
                     y = -34.59857730467378)

dplyr::glimpse(data)

# Rows: 1
# Columns: 12
# $ comuna                        <chr> "Comuna 1"
# $ barrio                        <chr> "Retiro"
# $ comisaria                     <chr> "15"
# $ area_hospitalaria             <chr> "HTAL. J.A.FERNÁNDEZ"
# $ region_sanitaria              <chr> "I (Este)"
# $ distrito_escolar              <chr> "Distrito Escolar   I"
# $ comisaria_vecinal             <chr> "1A"
# $ seccion_catastral             <chr> "03"
# $ distrito_economico            <chr> ""
# $ codigo_de_planeamiento_urbano <chr> "C2"
# $ partido_amba                  <chr> ""
# $ localidad_amba                <chr> ""
```

### :globe_with_meridians: `convertir_coordenadas`

Convierte coordenadas a formatos `GKBA`, `WGS84 (Lon/Lat)` y `WGS84 (grados, minutos y segundos)`. El parámetro `output` puede ser uno de `gkba`, `lonlat` o `degrees`.
Acepta cualquier formato de entrada. El formato de entrada es detectado automáticamente.
 
```r
data <- convertir_coord(x = -58.37583628694437,
                        y = -34.59857730467378,
                        output = "degrees")

dplyr::glimpse(data)

# Rows: 1
# Columns: 2
# $ x <chr> "58d22'33.01\"W"
# $ y <chr> "34d35'54.878\"S"

```