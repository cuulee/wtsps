WTSPS <- function(serverUrl) {
  
  methods::new (Class = "WTSPS", 
                serverUrl = serverUrl)
  
}

validWTSPSObject <- function(object) {
  
  errors <- character()
  length_serverURL <- length(object@serverURL)
  
  if (length_serverURL != 1) {
    messsage <- paste("[WTSPS: validation Class] URL server was not provided!!!", sep = "")
    errors <- c(errors, message)
  }
  
  nchar_serverURL <- nchar(object@serverURL)
  
  if (nchar_serverURL <= 1) {
    message <- paste("[WTSPS: validation Class] serverURL has an invalid URL server", sep = "")
    errors <- c(errors, message)
  }
  
  if (length(errors) == 0) TRUE else errors
  
}

setValidity(
      
  Class = "WTSPS", 
  
  method = validWTSPSObject
  
)

setMethod(
  
  # initialize function
  f = "initialize",
  
  # Method signature
  signature = "WTSPS",
  
  # Function definition
  definition = function(.Object, serverUrl) {
    
    .Object@serverUrl <- serverUrl
    
    methods::validObject(.Object)
    
    return(.Object)
    
  }
  
)

setGeneric("getServerURL", function(object){ standardGeneric("getServerURL")})

setMethod(
  
  f = "getServerURL",
  
  signature = "WTSPS", 
  
  definition = function(object) {
  
    # if last character is different from slash add one
    if(substr(object@serverUrl, nchar(object@serverUrl), nchar(object@serverUrl)) != "/") 
    return(paste(object@serverUrl,"/", sep=""))
    
    return (object@serverUrl)
  
  }
  
)

setGeneric("getAlgorithms", function(object){ standardGeneric("getAlgorithms")})

setMethod(
  
  f = "getAlgorithms",
  
  signature = "WTSPS", 
  
  definition = function(object) {
    
  }
  
)

