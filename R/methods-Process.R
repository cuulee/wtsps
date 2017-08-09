Process <- function(id, status) {
  
  methods::new (Class = "Process", 
                id = id, 
                status = status)
  
}

validProcessObject <- function(object) {
  
  errors <- character()
  length_id <- length(object@id)
  
  if (length_id != 1) {
    messsage <- paste("[WTSPS: validation Class] Process id was not provided!!!", sep = "")
    errors <- c(errors, message)
  }
  
  length_status <- length(object@status)
  
  if (length_status != 1) {
    messsage <- paste("[WTSPS: validation Class] Process status was not provided!!!", sep = "")
    errors <- c(errors, message)
  }
  
  if (length(errors) == 0) TRUE else errors
  
}

setValidity(
  
  Class = "Process", 
  
  method = validProcessObject
  
)

setGeneric("getId", function(object){ standardGeneric("getId")})

setMethod(
  
  f = "getId",
  
  signature = "Process", 
  
  definition = function(object) {
    
    return (object@id)
    
  }
  
)

setGeneric("getStatus", function(object){ standardGeneric("getStatus")})

setMethod(
  
  f = "getStatus",
  
  signature = "Process", 
  
  definition = function(object) {
    
    return (object@status)
    
  }
  
)