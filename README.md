# R Client API for Web Time Series Processing Service 

**wtsps** is an R Client package for handling Web Time Series Processing Service (WTSPS) in the client side.

## Build the package:

Clone the project: git clone https://github.com/e-sensing/wtsps.R.git.

Open Rstudio, go to File - Open Project and pick the file wtsps.R.Rproj.

Install the required package install.packages("roxygen2").

Go to the Build tab in the upper-right panel and press the button Build & Reload. 

## Getting started

Installing and loading wtsps package

``` r
devtools::install_github("e-sensing/wtsps.R") # github repository name is wtsps
library(wtsps.R) # R package name is wtsps
```

A simple example of creating a WTSPS connection

``` r 
wtsps.server <- WTSPS(serverURL = "inst/extdata/wtsps/")
```

The result is an Object of Class WTSPS. 

``` r
wtsps.server
```

``` r
Object of Class WTSPS

The WTSPS server URL is: inst/extdata/wtsps/ 
The available algorithms are: TWDTW 
```
It is possible to get the list of algorithms provided by a WTSPS service using a WTSPS object or simply a WTSPS server URL.

``` r
listAlgorithms(serverInfo = "inst/extdata/wtsps/")
```

``` r
## [1] "TWDTW"
```

We are also able to acquire any algorithm metadata with describeAlgorithm. This function returns an Algorithm class containing its name, input_parameters, output and a description using a WTSPS object already created or directly a WTSPS server URL. 

```r
describeAlgorithm(serverInfo = wtsps.server, name = "TWDTW")
```
``` r
Object of Class Algorithm: 

The Algorithm name is: TWDTW 

input parameters: 
   patterns = twdtwTimeSeries 
    dist.method = character 
    alpha = double 
    beta = double 
    theta = double 
    interval = character 
    span = integer 
    keep = boolean 
    overlap = double 
    start_date = character 
    end_date = character 

output: 
   from = integer 
    to = integer 
    label = integer 
    distance = double 

description:  Time-Weighted Dynamic Time Warping (TWDTW) method for land use and land cover mapping using satellite image time series.
```

Using input_parameters we can run any process with that algorithm as many parameters as possible.

```r
run_process <- runProcess(serverInfo = "inst/extdata/wtsps/", name = "TWDTW", patterns = "X")
```
```r
run_process
Object of Class Process: 

The Process uuid is: 1 

Current status: Scheduled 

Command (parameter = value) to enter in the server: 
    name  =  TWDTW 
    patterns  =  X
```

After that, WTSPS generates an identifier for this process so the user can see its status if necessary.

```r
status.proc <- statusProcess(serverInfo = "inst/extdata/wtsps/", processInfo = 1)
```
```r
status.proc
Object of Class Process: 

The Process uuid is: 1 

Current status: In Progress 

Command (parameter = value) to enter in the server: 
    name  =  TWDTW 
    patterns  =  X
```

Or even cancel the process.

```r
cancel.proc <- cancelProcess(serverInfo = "inst/extdata/wtsps/", processInfo = 1)
```
```r
cancel.proc
Object of Class Process: 

The Process uuid is: 1 

Current status: Cancelled 

Command (parameter = value) to enter in the server: 
    name  =  TWDTW 
    patterns  =  X
```

## Reporting Bugs

Any problem should be reported to esensing-developers@dpi.inpe.br.
