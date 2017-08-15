#' Wrapper function Algorithm
#'
#' @param serverURL a WTSPS server URL
#' @param id a Process identifier
#' 
#' @name Process
#' @rdname Process-class
#' @export
Process <- function(serverURL, id) {
  
  methods::new (Class = "Process", 
                id = id)
  
}

validProcessObject <- function(object) {
  
  errors <- character()
  length_id <- length(object@id)
  
  if (length_id != 1) {
    messsage <- paste("[WTSPS: Process Object validation] Process has no id!", sep = "")
    errors <- c(errors, message)
  }
  
  length_status <- length(object@status)
  
  if (length_status != 1) {
    messsage <- paste("[WTSPS: Process Object validation] Process has no status!", sep = "")
    errors <- c(errors, message)
  }
  
  if (length(errors) == 0) TRUE else errors
  
}

setValidity(
  
  Class = "Process", 
  
  method = validProcessObject
  
)

#' Returns a Process id
#'
#' @param object A Process object
#' @aliases getId-generic
#' @export
setGeneric("getId", function(object){ standardGeneric("getId")})

#' @rdname getId
setMethod(
  
  f = "getId",
  
  signature = "Process", 
  
  definition = function(object) {
    
    return (object@id)
    
  }
  
)

#' Returns a Process status
#'
#' @param object A Process object
#' @aliases getStatus-generic
#' @export
setGeneric("getStatus", function(object){ standardGeneric("getStatus")})

#' @rdname getStatus
setMethod(
  
  f = "getStatus",
  
  signature = "Process", 
  
  definition = function(object) {
    
    return (object@status)
    
  }
  
)