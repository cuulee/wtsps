#' Wrapper function Algorithm
#'
#' @param serverURL a WTSCS server URL
#' @param name an Algorithm name
#' 
#' @name Algorithm
#' @rdname Algorithm-class
#' @export
Algorithm <- function(serverURL, name) {
  
  methods::new (Class = "Algorithm", 
                serverURL = serverURL,
                name = name)
  
}

validAlgorithmObject <- function(object) {
  
  errors <- character()
  length_name <- length(object@name)
  
  if (length_name != 1) {
    messsage <- paste("[WTSCS: Algorithm Object validation] Algorithm has no name!", sep = "")
    errors <- c(errors, message)
  }
  
  length_input_parameters <- length(object@input_parameters)
  
  if (length_input_parameters < 1) {
    messsage <- paste("[WTSCS: Algorithm Object validation] Algorithm has no input parameters!", sep = "")
    errors <- c(errors, message)
  }
  
  length_output <- length(object@output)
  
  if (length_output < 1) {
    messsage <- paste("[WTSCS: Algorithm Object validation] Algorithm has no output!", sep = "")
    errors <- c(errors, message)
  }
  
  length_description <- length(object@description)
  
  if (length_description != 1) {
    messsage <- paste("[WTSCS: Algorithm Object validation] Algorithm has no description!", sep = "")
    errors <- c(errors, message)
  }
  
  if (length(errors) == 0) TRUE else errors
  
}

setValidity(
  
  Class = "Algorithm", 
  
  method = validAlgorithmObject
  
)

#' Returns an Algorithm name
#'
#' @param object An Algorithm object
#' @aliases getName-generic
#' @export
setGeneric("getName", function(object){standardGeneric("getName")})

#' @rdname getName
setMethod(
  
  f = "getName",
  
  signature = "Algorithm", 
  
  definition = function(object) {
    
    return (object@name)
    
  }
  
)

#' Returns Algorithm parameters
#'
#' @param object An Algorithm object
#' @aliases getInputParameters-generic
#' @export
setGeneric("getInputParameters", function(object){standardGeneric("getInputParameters")})

#' @rdname getInputParameters
setMethod(
  
  f = "getInputParameters",
  
  signature = "Algorithm", 
  
  definition = function(object) {
    
    return (object@input_parameters)
    
  }
  
)

#' Returns algorithm output
#'
#' @param object An Algorithm object
#' @aliases getOutput-generic
#' @export
setGeneric("getOutput", function(object){ standardGeneric("getOutput")})

#' @rdname getOutput
setMethod(
  
  f = "getOutput",
  
  signature = "Algorithm", 
  
  definition = function(object) {
    
    return (object@output)
    
  }
  
)

#' Returns algorithm description
#'
#' @param object An Algorithm object
#' @aliases getDescription-generic
#' @export
setGeneric("getDescription", function(object){standardGeneric("getDescription")})

#' @rdname getDescription
setMethod(
  
  f = "getDescription",
  
  signature = "Algorithm", 
  
  definition = function(object) {
    
    return (object@description)
    
  }
  
)

#' Assign Algorithm parameters to an Algorithm object
#'
#' @param alg an Algorithm object
#' @param algParameters Algorithm parameters
#' @aliases applyAlgorithm-generic
#' @export
setGeneric("applyAlgorithm", function(alg, algParameters){standardGeneric("applyAlgorithm")})

#' @rdname applyAlgorithm
setMethod(

  f = "applyAlgorithm",

  signature(alg = "Algorithm", algParameters = "character"),

  definition = function(alg, algParameters) {

    if(missing(algParameters))
      stop("Missing Algorithm parameters")
    
    names_input_parameters <- names(alg@input_parameters) # get input parameters
    check <- TRUE
    for(i in seq(1, length(algParameters), by = 2)) {
      check <- algParameters[i] %in% names_input_parameters # check each parameter
      if (!check)
        break
    }
    
    return(check)
    
  }

)