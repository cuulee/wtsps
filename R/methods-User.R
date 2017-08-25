#' Wrapper function User
#'
#' @param serverURL a WTSPS server URL
#' @param login a Process identifier
#' 
#' @name User
#' @rdname User-class
#' @export
User <- function(serverURL, login) {
  
  methods::new (Class = "User", 
                serverURL = serverURL, 
                login = login)
  
}

validUserObject <- function(object) {
  
  errors <- character()
  length_login <- length(object@login)
  
  if (length_login != 1) {
    messsage <- paste("[WTSPS: User Object validation] User has no login!", sep = "")
    errors <- c(errors, message)
  }
  
  length_permissions <- length(object@permissions)
  
  if (length_permissions != 1) {
    messsage <- paste("[WTSPS: User Object validation] User has no permissions!", sep = "")
    errors <- c(errors, message)
  }
  
  if (length(errors) == 0) TRUE else errors
  
}

setValidity(
  
  Class = "User", 
  
  method = validUserObject
  
)

setGeneric("getLogin", function(object){standardGeneric("getLogin")})

setMethod(
  
  f = "getLogin",
  
  signature = "User", 
  
  definition = function(object) {
    
    return (object@login)
    
  }
  
)

setGeneric("getPermission", function(object){standardGeneric("getPermission")})

setMethod(
  
  f = "getPermission",
  
  signature = "User", 
  
  definition = function(object) {
    
    return (object@permission)
    
  }
  
)