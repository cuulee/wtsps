#' @include utils.R
#' Class WTSPS.
#'
#' Class \code{WTSPS} declaration helps to define a Web Time Series Processing Service.
#' 
#'@section Slots :
#' \describe{
#' \item{\code{serverURL}:}{Attribute of class \code{"character"}, URL of the server.}
#' \item{\code{algorithms}:}{Attribute of class \code{"character"}, algorithms of the server.}
#' }
#' 
#' @name WTSPS-class
#' @rdname WTSPS-class
#' @exportClass WTSPS
setClass(
  
  # Set the name for the class
  Class = "WTSPS",
  
  # Define the slots
  slots = c(
    serverURL = "character",
    algorithms = "character"
  )
  
)

# Constructor method of WTSPS Class.
setMethod(
  
  # initialize function
  f = "initialize",
  
  # Method signature
  signature = "WTSPS",
  
  # Function definition
  definition = function(.Object, serverURL = "character") {
    
    # if serverURL is missing
    if (missing(serverURL))
      .Object@serverURL <- "www.github.com/e-sensing/wtsps/inst/extdata/wtsps/"
    else
      .Object@serverURL <- serverURL
    
    # list algorithms from WTSPS 
    requestHTTP <-paste(serverURL,"list_algorithms", sep = "") 
    
    # submit HTTP request and get JSON response
    responseJSON <- parseJSON(sendRequest(requestHTTP))
    .Object@algorithms <- responseJSON
    
    methods::validObject(.Object)
    
    return(.Object)
    
  }
  
)