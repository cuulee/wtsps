#' Wrapper function WTSPS
#'
#' @param serverURL a WTSPS server URL
#' 
#' @name WTSPS
#' @rdname WTSPS-class
#' @export
WTSPS <- function(serverURL) {
  
  methods::new (Class = "WTSPS", 
                serverURL = serverURL)
  
}

validWTSPSObject <- function(object) {
  
  errors <- character()
  length_serverURL <- length(object@serverURL)
  
  if (length_serverURL != 1) {
    messsage <- paste("[WTSPS: Object validation] URL server was not provided!", sep = "")
    errors <- c(errors, message)
  }
  
  nchar_serverURL <- nchar(object@serverURL)
  
  if (nchar_serverURL <= 1) {
    message <- paste("[WTSPS: Object validation] URL server is invalid!", sep = "")
    errors <- c(errors, message)
  }
  
  length_serverURL <- length(object@algorithms)
  
  if (length_serverURL != 1) {
    messsage <- paste("[WTSPS: Object validation] URL server provided has no algorithm!", sep = "")
    errors <- c(errors, message)
  }
  
  if (length(errors) == 0) TRUE else errors
  
}

setValidity(
  
  Class = "WTSPS", 
  
  method = validWTSPSObject
  
)

#' Returns the WTSPS object's server URL
#'
#' @param object A WTSPS object
#' @aliases getServerURL-generic
#' @export
setGeneric("getServerURL", function(object){standardGeneric("getServerURL")})

#' @rdname getServerURL
setMethod(
  
  f = "getServerURL",
  
  signature = "WTSPS", 
  
  definition = function(object) {
    
    # if last character is different from slash add one
    if(substr(object@serverURL, nchar(object@serverURL), nchar(object@serverURL)) != "/") 
      return(paste(object@serverURL,"/", sep=""))
    
    return (object@serverURL)
    
  }
  
)

#' Returns the WTSPS object's algorithms
#'
#' @param object A WTSPS object
#' @aliases getAlgorithms-generic
#' @export
setGeneric("getAlgorithms", function(object){standardGeneric("getAlgorithms")})

#' @rdname getAlgorithms
setMethod(
  
  f = "getAlgorithms",
  
  signature = "WTSPS", 
  
  definition = function(object) {
    
    return(object@algorithms)
    
  }
  
)