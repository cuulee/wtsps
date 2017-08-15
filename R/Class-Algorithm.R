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
      serverURL <- "inst/extdata/wtsps/"
      
    if (missing(name))
      .Object@name <- "TWDTW"
    else 
      .Object@name <- name
    
    # describe metadata from Algorithm 
    request <- paste(serverURL, "describe_algorithm", sep="") 
    
    # check whether HTTP request or not
    if (RCurl::url.exists(request)) {
      request <- paste(request, "?name=", .Object@name)
      response <- sendHttpRequest(request) # submit HTTP request
      responseJSON <- parseJsonResponse(response) # get JSON response as list
    }
    else { # only works for the wtsps package server
      response <- readLines(paste(request, ".json", sep = "")) # read direclty a json file
      auxJSON <- parseJsonResponse(response) # get JSON response as list
      idx_row <- which(auxJSON$algorithms$name == .Object@name)
      responseJSON <- auxJSON$algorithms[idx_row, ]
      responseJSON$name <- auxJSON$algorithms$name[idx_row] # replace algorith name of the queried name
      idx_col_input_parameters <- which(!is.na(auxJSON$algorithms[idx_row,]$input_parameters))
      responseJSON$input_parameters <- auxJSON$algorithms[idx_row,]$input_parameters[,idx_col_input_parameters] # replace algorith input_parameters of the queried name
      idx_col_output <- which(!is.na(auxJSON$algorithms[idx_row,]$output))
      responseJSON$output <- auxJSON$algorithms[idx_row,]$output[, idx_col_output] # replace algorith output of the queried name
      responseJSON$description <- auxJSON$algorithms$description[idx_row]
    }
    
    # assign attribute values (parameters, output, description) to the Algorithm object
    .Object@input_parameters <- unlist(responseJSON$input_parameters) # list of input parameters
    .Object@output <- unlist(responseJSON$output) # list of output parameters
    .Object@description <- responseJSON$description
    
    methods::validObject(.Object)
    
    return(.Object)
    
  }
  
)