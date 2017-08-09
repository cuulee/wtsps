Algorithm <- function(serverUrl, name, parameters, output, description) {
  
  methods::new(Class = "Algorithm", 
              name = name, 
              parameters = parameters, 
              output = output, 
              description = description)
}

validAlgorithmObject <- function(object) {
  
  errors <- character()
  length_name <- length(object@name)
  
  if (length_name != 1) {
    messsage <- paste("[WTSPS: validation Class] Algorithm name was not provided!!!", sep = "")
    errors <- c(errors, message)
  }
  
  length_parameters <- length(object@parameters)
  
  if (length_parameters != 1) {
    messsage <- paste("[WTSPS: validation Class] Algorithm parameters was not provided!!!", sep = "")
    errors <- c(errors, message)
  }
  
  length_output <- length(object@output)
  
  if (length_output != 1) {
    messsage <- paste("[WTSPS: validation Class] Algorithm output was not provided!!!", sep = "")
    errors <- c(errors, message)
  }
  
  length_description <- length(object@description)
  
  if (length_description != 1) {
    messsage <- paste("[WTSPS: validation Class] Algorithm description was not provided!!!", sep = "")
    errors <- c(errors, message)
  }
  
  if (length(errors) == 0) TRUE else errors
  
}

setValidity(
  
  Class = "Algorithm", 
  
  method = validAlgorithmObject
  
)

setGeneric("getName", function(object){ standardGeneric("getName")})

setMethod(
  
  f = "getName",
  
  signature = "Algorithm", 
  
  definition = function(object) {
    
    return (object@name)
    
  }
  
)

setGeneric("getParameters", function(object){ standardGeneric("getParameters")})

setMethod(
  
  f = "getParameters",
  
  signature = "Algorithm", 
  
  definition = function(object) {
    
    return (object@parameters)
    
  }
  
)

setGeneric("getOutput", function(object){ standardGeneric("getOutput")})

setMethod(
  
  f = "getOutput",
  
  signature = "Algorithm", 
  
  definition = function(object) {
    
    return (object@output)
    
  }
  
)

setGeneric("getDescription", function(object){ standardGeneric("getDescription")})

setMethod(
  
  f = "getDescription",
  
  signature = "Algorithm", 
  
  definition = function(object) {
    
    return (object@description)
    
  }
  
)
