# RUTrentoOpenData

RUTrentoOpenData is an easy to use R interface to the <a href="www.dati.trentino.it">Open Data portal of Trento</a>. 
It enable the user to obtain data from the portal directly in R, through the use of a friendly user interface.

##Installation

RUTrentoOpenData is still in its infancy and not yet submitted to CRAN.
You can install the package directly from github:
``` r
    devtools::install_github("Trento-R-User-Group/RUTrentoOpenData")
```

##Usage
The main function is `trentino()`.
```r
dat <- trentino('sensori')
#> The query returned these datasets,
#>                              which one do you want to load? 
#> 
#>  1: Anagrafica Sensori Ufficio Dighe
#>  2: Rilevamento Sensori Idrometrici - Livello
#>  3: Rilevamento Sensori Idrometrici - Portata (Calcolata)
#>  4: Dati in tempo reale della stazione di Campodenno
#>  5: Anagrafica delle Stazioni di rilevamento di Campodenno
#>  6: Report mensile dei dati della stazione di Campodenno
#>  7: Riassunto rilievo traffico automatico (stazioni fisse) anno 2014
#>  8: Riassunto rilievo traffico automatico (stazioni fisse) anno 2013
#>  9: Riassunto rilievo traffico automatico (stazioni fisse) anno 2006
#> 10: Riassunto rilievo traffico automatico (stazioni fisse) anno 2007
#> 11: Riassunto rilievo traffico automatico (stazioni fisse) anno 2012
#> 12: Riassunto rilievo traffico automatico (stazioni fisse) anno 2011
#> 13: Riassunto rilievo traffico automatico (stazioni fisse) anno 2010
#> 14: Riassunto rilievo traffico automatico (stazioni fisse) anno 2009
#> 15: Riassunto rilievo traffico automatico (stazioni fisse) anno 2008
#> 16: Riassunto rilievo traffico automatico (stazioni fisse) anno 2005
#> 17: Riassunto rilievo traffico automatico (stazioni fisse) anno 2015
#>
#> Selection: 2
```
The user can select the dataset she/he is intersted in.  
The package will then try to select the most sensible reource available. If it can't find it, it will ask the user to choose the best resource.
```r
#> These are the available resources,
#>                     which one do you want? 
#> 
#>  1: Sensore Idrometrico livello - Trento
#>  2: Sensore Idrometrico livello - Trento-Fersina
#>  3: Sensore Idrometrico livello - Rovereto
#>  4: Sensore Idrometrico livello - Fiera di Primiero
#>  5: Sensore Idrometrico livello - Borgo Valsugana
#>  6: Sensore Idrometrico livello - Malè
#>  7: Sensore Idrometrico livello - Sarche
#>  8: Sensore Idrometrico livello - Cimego
#>  9: Sensore Idrometrico livello - Lavis
#> 10: Sensore Idrometrico livello - S. Michele Adige
#> 
#> Selection: 1
```
It is possibile to avoid the interactive menus using `pack_sel` and `res_sel` parameters, the first will select the package, while the second will select its resource, possibly overriding the default
```r
# Resource selection is done automatically
dat <- trentino('nati', pack_sel = 5)
dat <- trentino('sensori', pack_sel = 2, res_sel = 1)
```

##Code Contributions
Every contribution is welcome, be it in form of suggestion, bug report, code implementation.  
If you would like to contribute to this R package, pleas read the following <a href="http://adv-r.had.co.nz/Style.html">code style guidelines</a>

