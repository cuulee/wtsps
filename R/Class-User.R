#' @include utils.R
#' 
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
    
    ### TO DO
    
    return(.Object)
    
  }
  
)