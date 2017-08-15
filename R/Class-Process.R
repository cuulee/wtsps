#' @include utils.R
#' Class Process.
#'
#' Class \code{Process} declaration helps to define a Web Time Series Processing Service.
#' 
#'@section Slots :
#' \describe{
#' \item{\code{id}:}{Attribute of class \code{"character"}, an identifier of a Process.}
#' \item{\code{status}:}{Attribute of class \code{"character"}, a status of a Process.}
#' }
#' 
#' @name Process-class
#' @rdname Process-class
#' @exportClass Process
setClass(
  
  # Set the name for the class
  Class = "Process",
  
  # Define the slots
  slots = c(
    id = "character",
    status = "character"
  )
  
)

# Constructor method of Process Class.
setMethod(
  
  # initialize function
  f = "initialize",
  
  # method signature
  signature = "Process",
  
  # function definition
  definition = function(.Object, serverURL = "character", id = "character") {
    
    # if serverURL is missing
    if (missing(serverURL))
      serverURL <- "www.github.com/e-sensing/wtsps/inst/extdata/wtsps/" # server URL in the R package
    
    if (missing(id))
      .Object@id <- 1 # first Process identifier
      
    # describe status from Process 
    requestHTTP <-paste(serverURL, "status_process?id=", .Object@id, sep="") 
    
    # submit HTTP request and get JSON response
    responseJSON <- parseJsonResponse(sendHttpRequest(requestHTTP))
    
    # assign attribute values (status) to the Process object
    .Object@status <- responseJSON$status
    
    methods::validObject(.Object)
    
    return(.Object)
    
  }
  
)