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
    
    # if serverURL use a local WTSPS server
    if (missing(serverURL))
      .Object@serverURL <- "inst/extdata/wtsps/"
    else
      .Object@serverURL <- serverURL
    
    # build list algorithms request string
    request <- paste(.Object@serverURL, "list_algorithms", sep = "")
    
    # check whether HTTP request or not
    if (RCurl::url.exists(request))
       response <- sendHttpRequest(request) # submit HTTP request
    else
       response <- readLines(paste(request, ".json", sep = "")) # read direclty a json file
    
    # parse JSON response
    responseJSON <- parseJsonResponse(response)
    
    # assign attribute values (algorithms) to the WTSPS object
    .Object@algorithms <- responseJSON$algorithms
    
    # check whether .Object is valid or not
    methods::validObject(.Object)
    
    return(.Object)
    
  }
  
)