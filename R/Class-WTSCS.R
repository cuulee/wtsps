#' @include utils.R
#' 
#' Class WTSCS.
#'
#' Class \code{WTSCS} declaration helps to define a Web Time Series Processing Service.
#' 
#'@section Slots :
#' \describe{
#' \item{\code{serverURL}:}{Attribute of class \code{"character"}, URL of the server.}
#' \item{\code{algorithms}:}{Attribute of class \code{"character"}, algorithms of the server.}
#' }
#' 
#' @name WTSCS-class
#' @rdname WTSCS-class
#' @exportClass WTSCS
setClass(
  
  # Set the name for the class
  Class = "WTSCS",
  
  # Define the slots
  slots = c(
    serverURL = "character",
    algorithms = "character"
  )
  
)

# Constructor method of WTSCS Class.
setMethod(
  
  # initialize function
  f = "initialize",
  
  # Method signature
  signature = "WTSCS",
  
  # Function definition
  definition = function(.Object, serverURL = "character") {
    
    # if WTSCS server URL is missing
    if (missing(serverURL))
       stop("Missing a WTSCS server URL")
    else if (class(serverURL) != "character")   
            stop("WTSCS server URL type is not recognized")
    
    # build list algorithms request string
    request <- paste(serverURL, "list_algorithms", sep = "")
    response  <- sendRequest(request)
    
    # parse JSON response
    responseJSON <- parseResponse(response)
    
    # assign attribute values (algorithms) to the WTSCS object
    .Object@serverURL <- serverURL
    .Object@algorithms <- responseJSON$algorithms
    
    # check whether .Object is valid or not
    methods::validObject(.Object)
    
    return(.Object)
    
  }
  
)