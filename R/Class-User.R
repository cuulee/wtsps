#' @include utils.R
#' Class User.
#'
#' Class \code{User} declaration helps to define a Web Time Series Processing Service.
#' 
#'@section Slots :
#' \describe{
#' \item{\code{login}:}{Attribute of class \code{"character"}, login of the User.}
#' \item{\code{permissions}:}{Attribute of class \code{"character"}, permissions of the User.}
#' }
#' 
#' @name User-class
#' @rdname User-class
#' @exportClass User
setClass(
  
  # Set the name for the class
  Class = "User",
  
  # Define the slots
  slots = c(
    login = "character",
    permissions = "character"
  )
  
)

# Constructor method of User Class.
setMethod(
  
  # initialize function
  f = "initialize",
  
  # Method signature
  signature = "User",
  
  # Function definition
  definition = function(.Object, serverURL = "character", login = "character") {
    
    # if serverURL is missing
    if (missing(serverURL))
      serverURL <- "www.github.com/e-sensing/wtsps/inst/extdata/wtsps/" # server URL in the R package
    
    if (missing(login))
      .Object@login <- 1 # first User identifier
    
    # manage permissions from User 
    requestHTTP <-paste(serverURL,"manage_permissions?login=", .Object@login, sep="") 
    
    # submit HTTP request and get JSON response
    responseJSON <- parseJsonResponse(sendHttpRequest(requestHTTP))
    
    # assign attribute values (permissions) to the User object
    .Object@permissions <- responseJSON$permissions
    
    methods::validObject(.Object)
    
    return(.Object)
    
  }
  
)