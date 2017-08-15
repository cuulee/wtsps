#' @include utils.R
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
    
    if (missing(serverURL))
      serverURL <- "www.github.com/e-sensing/wtsps/inst/extdata/wtsps/"
    
    if (missing(name))
      .Object@name <- "FirstAlgorithm"
    
    # describe metadata from Algorithm 
    requestHTTP <-paste(serverURL,"describe_algorithm?name=", .Object@name, sep="") 
    
    # submit HTTP request and get JSON response
    responseJSON <- sendRequest(requestHTTP)
    
    # assign attribute values (parameters, output, description) to the Algorithm object
    .Object@input_parameters <- responseJSON$input_parameters
    .Object@output <- responseJSON$output
    .Object@description <- responseJSON$description
    
    methods::validObject(.Object)
    
    return(.Object)
    
  }
  
)