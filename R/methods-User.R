User <- function(name, id, permission) {
  
  methods::new (Class = "User", 
                name = name, 
                id = id, 
                permission = permission)
  
}

validUserObject <- function(object) {
  
  errors <- character()
  length_name <- length(object@name)
  
  if (length_name != 1) {
    messsage <- paste("[WTSPS: validation Class] User name was not provided!!!", sep = "")
    errors <- c(errors, message)
  }
  
  length_id <- length(object@id)
  
  if (length_id != 1) {
    messsage <- paste("[WTSPS: validation Class] User id was not provided!!!", sep = "")
    errors <- c(errors, message)
  }
  
  length_permissions <- length(object@permissions)
  
  if (length_permissions != 1) {
    messsage <- paste("[WTSPS: validation Class] User permissions was not provided!!!", sep = "")
    errors <- c(errors, message)
  }
  
  if (length(errors) == 0) TRUE else errors
  
}

setValidity(
  
  Class = "User", 
  
  method = validUserObject
  
)

setGeneric("getName", function(object){ standardGeneric("getName")})

setMethod(
  
  f = "getName",
  
  signature = "User", 
  
  definition = function(object) {
    
    return (object@name)
    
  }
  
)

setGeneric("getId", function(object){ standardGeneric("getId")})

setMethod(
  
  f = "getId",
  
  signature = "User", 
  
  definition = function(object) {
    
    return (object@id)
    
  }
  
)

setGeneric("getPermission", function(object){ standardGeneric("getPermission")})

setMethod(
  
  f = "getPermission",
  
  signature = "User", 
  
  definition = function(object) {
    
    return (object@permission)
    
  }
  
)