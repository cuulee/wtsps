#' @include utils.R
#'
#' Class Algorithm.
#'
#' Class \code{Algorithm} declaration helps to define an Algorithm in Web Time Series Processing Service.
#' 
#'@section Slots :
#' \describe{   
#'   \item{\code{name}:}{Attribute of class \code{"character"}, Name of the Algorithm.}
#'   \item{\code{input_parameters}:}{Attribute of class \code{"character"}, Input parameters of the Algorithm}
#'   \item{\code{output}:}{Attribute of class \code{"character"}, Output columns of the Algorithm}
#'   \item{\code{description}:}{Attribute of class \code{"character"}, Description of the Algorithm}
#' }
#' 
#' @name Algorithm-class
#' @rdname Algorithm-class
#' @exportClass Algorithm
setClass(
  
  # Set the name for the class
  Class = "Algorithm",
  
  # Define the slots
  slots = c(
    name = "character",
    input_parameters = "character",
    output = "character",
    description = "character"
  )
  
)

# Constructor method of Algorithm Class.
setMethod(
  
  # initialize function
  f = "initialize",
  
  # Method signature
  signature = "Algorithm",
  
  # Function definition
  definition = function(.Object, serverURL = "character", name = "character") {
    
    # if WTSPS server URL is missing
    if (missing(serverURL))
      stop("Missing a WTSPS server URL")
    else if (class(serverURL) != "character")   
      stop("WTSPS server URL type is not recognized")
    
    # if Algorithm name is missing
    if (missing(name))
      stop("Missing an Algorithm name")
    else if (class(name) != "character")   
      stop("Algorithm name type is not recognized")
    
    # send request with describe algorithm
    request <- paste(serverURL, "describe_algorithm?name=", name, sep="") 
    response  <- sendRequest(request)
    
    # get JSON response as list
    responseJSON <- parseResponse(response)
    
    # assign attribute values (name, parameters, output, description) to the Algorithm object
    .Object@name <- name 
    .Object@input_parameters <- unlist(responseJSON$input_parameters) # list of input parameters
    .Object@output <- unlist(responseJSON$output) # list of output parameters
    .Object@description <- responseJSON$description
    
    methods::validObject(.Object)
    
    return(.Object)
    
  }
  
)