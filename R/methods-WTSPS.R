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
    messsage <- paste("[WTSPS: Object validation] WTSPS has no URL server", sep = "")
    errors <- c(errors, message)
  }
  
  nchar_serverURL <- nchar(object@serverURL)
  
  if (nchar_serverURL <= 1) {
    message <- paste("[WTSPS: Object validation] WTSPS has an invalid URL server", sep = "")
    errors <- c(errors, message)
  }
  
  length_algorithms <- length(object@algorithms)
  
  if (length_algorithms < 1) {
    messsage <- paste("[WTSPS: Object validation] WTSPS has no algorithms", sep = "")
    errors <- c(errors, message)
  }
  
  if (length(errors) == 0) TRUE else errors
  
}

setValidity(
  
  Class = "WTSPS", 
  
  method = validWTSPSObject
  
)

printWTSPSobject <- function(object) {
 
  # initial message
  cat(paste("Object of Class WTSPS\n\n"))
  
  # print serverURL
  cat(paste("The WTSPS server URL is:", object@serverURL, "\n"))
  
  # print algorithms
  cat(paste("The available algorithms are:", object@algorithms, "\n"))
   
}

setMethod(
  
  # Name of the function
  f = "show", 
  
  # Method signature
  signature = "WTSPS", 
  
  # Stylish print of the objects
  definition = function(object) {
    
    printWTSPSobject(object)
    
    return(invisible())
    
  }
  
)

#' Returns the WTSPS object's server URL
#'
#' @param serverInfo A WTSPS object
#' @aliases getServerURL-generic
#' @export
setGeneric("getServerURL", function(serverInfo){standardGeneric("getServerURL")})

#' @rdname getServerURL
setMethod(
  
  f = "getServerURL",
  
  signature = "WTSPS", 
  
  definition = function(serverInfo) {
    
    # if last character is different from slash add one
    if(substr(serverInfo@serverURL, nchar(serverInfo@serverURL), nchar(serverInfo@serverURL)) != "/") 
      return(paste(serverInfo@serverURL,"/", sep=""))
    
    return (serverInfo@serverURL)
    
  }
  
)

#' Returns the WTSPS object's algorithms
#'
#' @param serverInfo A WTSPS object
#' @aliases getAlgorithms-generic
#' @export
setGeneric("getAlgorithms", function(serverInfo){standardGeneric("getAlgorithms")})

#' @rdname getAlgorithms
setMethod(
  
  f = "getAlgorithms",
  
  signature = "WTSPS", 
  
  definition = function(serverInfo) {
    
    return(serverInfo@algorithms)
    
  }
  
)

#' Returns the WTSPS object's algorithms
#'
#' @param serverInfo A WTSPS object or URL
#' @aliases listAlgorithms-generic
#' @export
setGeneric("listAlgorithms", function(serverInfo){standardGeneric("listAlgorithms")})

#' @rdname listAlgorithms
setMethod(
  
  f = "listAlgorithms",
  
  signature = "ANY", 
  
  definition = function(serverInfo) {
    
    if (missing(serverInfo)) 
      stop("Missing a WTSPS server information")
    
    if (class(serverInfo) == "WTSPS") 
      algorithms <- serverInfo@algorithms
    else {
        if (class(serverInfo) == "character") {
            wtsps.server <- WTSPS(serverInfo)
            algorithms <- wtsps.server@algorithms
        } else 
             stop("WTSPS server object type is not recognized") 
    }
    
    return(algorithms)

  }
  
)

#' Returns an Algorithm Class in a WTSPS server URL queried by name
#'
#' @param serverInfo a WTSPS server object or URL
#' @param name An Algorithm name
#' @aliases describeAlgorithm-generic
#' @export
setGeneric("describeAlgorithm", function(serverInfo, name){standardGeneric("describeAlgorithm")})

#' @rdname describeAlgorithm
setMethod(
  
  f = "describeAlgorithm",
  
  signature(serverInfo = "ANY", name = "character"), 
  
  definition = function(serverInfo, name) {
    
    if (missing(serverInfo)) 
      stop("Missing a WTSPS server information")
    
    if (missing(name)) 
      stop("Missing an Algorithm name")
    
    if (class(serverInfo) == "WTSPS")
      serverURL <- serverInfo@serverURL
    else
      serverURL <- serverInfo
    
    alg <- Algorithm(serverURL, name)
    
    return (alg)
    
  }
  
)

#' Returns a Process status in a WTSPS server URL
#'
#' @param serverInfo a WTSPS object or URL
#' @param processInfo a Process object
#' @aliases statusProcess-generic
#' @export
setGeneric("statusProcess", function(serverInfo, processInfo){standardGeneric("statusProcess")})

#' @rdname statusProcess
setMethod(
  
  f = "statusProcess",
  
  signature(serverInfo = "ANY", processInfo = "ANY"), 
  
  definition = function(serverInfo, processInfo) {
    
    # check missing wtsps information
    if (missing(serverInfo))
      stop("Missing a WTSPS server information")
    
    # check missing process information
    if (missing(processInfo))
      stop("Missing a Process information")
    
    # check class of server information
    if (class(serverInfo) == "WTSPS")
        serverURL <- serverInfo@serverURL
    else {
        if (class(serverInfo) == "character")
            serverURL <- serverInfo
        else 
          stop("WTSCS server information type is not recognized") 
    }
    
    # check class of process information
    if (class(processInfo) == "Process")
        uuid <- processInfo@uuid
    else {
       if (class(processInfo) == "numeric")
          uuid <- processInfo
       else 
          stop("Process information type is not recognized") 
    }
    
    # create a process instance with status as empty
    proc <- Process(serverURL, uuid, "")
    
    return (proc)
    
  }
  
)

#' Returns a Process status in a WTSPS server URL
#'
#' @param serverInfo a WTSPS object or URL
#' @param processInfo a Process object
#' @aliases cancelProcess-generic
#' @export
setGeneric("cancelProcess", function(serverInfo, processInfo){standardGeneric("cancelProcess")})

#' @rdname cancelProcess
setMethod(
  
  f = "cancelProcess",
  
  signature(serverInfo = "ANY", processInfo = "ANY"), 
  
  definition = function(serverInfo, processInfo) {
    
    # check missing wtsps information
    if (missing(serverInfo)) 
      stop("Missing a WTSPS server information")
    
    # check missing process information
    if (missing(processInfo))
      stop("Missing a Process information")
    
    # check class of wtsps information
    if (class(serverInfo) == "WTSPS")
        serverURL <- serverInfo@serverURL
    else {
        if (class(serverInfo) == "character")
          serverURL <- serverInfo
        else 
          stop("WTSPS server information type is not recognized")
    }
    
    # check class of process information
    if (class(processInfo) == "Process")
        uuid <- processInfo@uuid
    else {
        if (class(processInfo) == "numeric")
          uuid <- processInfo
        else 
          stop("Process information type is not recognized") 
    }
    
    # create a process instance with status as cancelled
    proc <- Process(serverURL, uuid, "Cancelled")
    
    return (proc)
    
  }
  
)

#' Executes a Process command in a WTSPS server URL
#'
#' @param serverInfo a WTSPS object or URL
#' @param ... remaining Algorithm parameters
#' @aliases runProcess-generic
#' @export
setGeneric("runProcess", function(serverInfo, ...){standardGeneric("runProcess")})

#' @rdname runProcess
setMethod(

  f = "runProcess",

  definition = function(serverInfo, ...) {

    # check missing wtsps information
    if (missing(serverInfo)) 
      stop("Missing a WTSCS server information")
    
    
    if (class(serverInfo) == "WTSPS")
      serverURL <- serverInfo@serverURL
    else {
      if (class(serverInfo) == "character")
        serverURL <- serverInfo
      else 
        stop("WTSPS server information type is not recognized")
    }

    params <- as.list(match.call())[c(-1,-2)] # get params from the function call
    value_params <- unname(unlist(params)) # get the parameters value
    name_params <- names(unlist(params)) # get the parameters name

    # Change URL separator parameters
    commands <- gsub("c\\(|\\)| ", "", paste(name_params, value_params, sep="=", collapse = ",")) # remove special characters when vectors data
    
    # create a Process object with commands
    proc <- Process(serverURL, commands) 

    return (proc)

  }

)

#' Executes a Process status in a WTSPS server URL
#'
#' @param userInfo a User object or a login
#' @aliases managePermissions-generic
#' @export
setGeneric("managePermissions", function(userInfo){standardGeneric("managePermissions")})

#' @rdname managePermissions
setMethod(
  
  f = "managePermissions",
  
  signature(userInfo = "ANY"), 
  
  definition = function(userInfo) {
    
    #### TO DO
    
    return (userInfo)
    
  }
  
)
