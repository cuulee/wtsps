# R Client API for Web Time Series Processing Service (WTSPS)

**wtsps** is an R Client package for handling Web Time Series Processing Service (WTSPS) in the client side.

## Build the package:

Clone the project: git clone https://github.com/e-sensing/wtsps.git.

Open Rstudio, go to File - Open Project and pick the file wtsps.Rproj.

Install the required package install.packages("roxygen2").

Go to the Build tab in the upper-right panel and press the button Build & Reload. 

## Getting started

Installing and loading wtsps package

``` r
devtools::install_github("e-sensing/wtsps") # github repository name is wtsps
library(wtsps) # R package name is wtsps
```

A simple example of creating a WTSPS connection

``` r 
wtsps.server <- WTSPS()
```

The result is an Object of Class WTSPS. 

``` r
wtsps.server
```

``` r
An object of class "WTSPS"
Slot "serverURL":
[1] "inst/extdata/wtsps/"

Slot "algorithms":
[1] "TWDTW" "BFAST"
```

It is possible to get the list of algorithms provided by a WTSPS service using a WTSPS object or simply a WTSPS server URL.

``` r
listAlgorithms("inst/extdata/wtsps/")
```

``` r
## [1] "TWDTW" "BFAST"
```

We are also able to acquire any algorithm metadata with describeAlgorithm. This function returns an Algorithm class containing its name, input_parameters, output and a description using a WTSPS object already created or directly a WTSPS server URL. 

```r
describeAlgorithm(wtsps.server, "TWDTW")
```
``` r
An object of class "Algorithm"
Slot "name":
[1] "TWDTW"

Slot "input_parameters":
         patterns       dist.method             alpha              beta             theta          interval              span 
"twdtwTimeSeries"       "character"          "double"          "double"          "double"       "character"         "integer" 
             keep           overlap        start_date          end_date 
        "boolean"          "double"       "character"       "character" 

Slot "output":
     from        to     label  distance 
"integer" "integer" "integer"  "double" 

Slot "description":
[1] "Time-Weighted Dynamic Time Warping (TWDTW) method for land use and land cover mapping using satellite image time series."
```

## Reporting Bugs

Any problem should be reported to esensing-developers@dpi.inpe.br.
