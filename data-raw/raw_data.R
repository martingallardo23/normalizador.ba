url_usig          <- "https://ws.usig.buenosaires.gob.ar/"
url_usig_geocoder <- "https://ws.usig.buenosaires.gob.ar/geocoder/2.2/"
url_usig_rest     <- "https://ws.usig.buenosaires.gob.ar/rest/"
url_usig_old      <- "http://servicios.usig.buenosaires.gob.ar/normalizar/"
usethis::use_data(url_usig, url_usig_geocoder, url_usig_rest,
                  url_usig_old, overwrite = T)
