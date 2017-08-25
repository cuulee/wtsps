#' Wrapper function Process
#'
#' @param serverInfo a WTSPS server URL
#' @param processInfo a Process identifier
#' @param processStatus a Process identifier
#' 
#' @name Process
#' @rdname Process-class
#' @export
Process <- function(serverInfo, processInfo, processStatus) {
  
  methods::new (Class = "Process", 
                serverInfo = serverInfo,
                processInfo = processInfo,
                processStatus = processStatus)
  
}

validProcessObject <- function(object) {
  
  errors <- character()
  length_uuid <- length(object@uuid)
  
  if (length_uuid != 1) {
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

printProcessobject <- function(object) {
  
  cat(paste("Object of Class Process: \n\n"))
  
  # print uuid
  cat(paste("The Process uuid is:", object@uuid, "\n\n"))
  
  # print status
  cat(paste("Current status:", object@status, "\n\n"))
  
  # print command
  cat(paste("Command (parameter = value) to enter in the server: \n"))
  
  # change collapse when necessary
  command.vec <- unlist(strsplit(unlist(strsplit(object@command, ",")), "="))
  
  # print each (parameter, value) separately
  for(i in seq(1, length(command.vec), 2))
    cat(paste("   ", command.vec[i], " = ", command.vec[i+1], "\n"))
  
}

setMethod(
  
  # Name of the function
  f = "show", 
  
  # Method signature
  signature = "Process", 
  
  # Stylish print of the objects
  definition = function(object) {
    
    printProcessobject(object)
    
    return(invisible())
    
  }
  
)

#' Returns a Process id
#'
#' @param processInfo A Process object
#' @aliases getUuid-generic
#' @export
setGeneric("getUuid", function(processInfo){ standardGeneric("getUuid")})

#' @rdname getUuid
setMethod(
  
  f = "getUuid",
  
  signature = "Process", 
  
  definition = function(processInfo) {
    
    return (processInfo@uuid)
    
  }
  
)

#' Returns a Process status
#'
#' @param processInfo A Process object
#' @aliases getStatus-generic
#' @export
setGeneric("getStatus", function(processInfo){ standardGeneric("getStatus")})

#' @rdname getStatus
setMethod(
  
  f = "getStatus",
  
  signature = "Process", 
  
  definition = function(processInfo) {
    
    return (processInfo@status)
    
  }
  
)

#' Returns a Process status
#'
#' @param processInfo A Process object
#' @aliases getCommand-generic
#' @export
setGeneric("getCommand", function(processInfo){ standardGeneric("getCommand")})

#' @rdname getCommand
setMethod(
  
  f = "getCommand",
  
  signature = "Process", 
  
  definition = function(processInfo) {
    
    return (processInfo@command)
    
  }
  
)

#' Check Algorithm parameters of a running Process object
#'
#' @param serverInfo A WTSPS object or URL
#' @param processInfo A Process object or command
#' @aliases parametrizeAlgorithm-generic
#' @export
setGeneric("parametrizeAlgorithm", function(serverInfo, processInfo){ standardGeneric("parametrizeAlgorithm")})

#' @rdname parametrizeAlgorithm
setMethod(

  f = "parametrizeAlgorithm",

  signature(serverInfo = "ANY", processInfo = "ANY"),

  definition = function(serverInfo, processInfo) {

    if (class(serverInfo) == "WTSPS")
      serverURL <- serverInfo@serverURL
    else if (class(serverInfo) == "character")
            serverURL <- serverInfo
          else
            stop("WTSPS information type is not recognized")

    if (class(processInfo) == "Process")
      commands <- processInfo@commands
    else if (class(processInfo) == "character")
            commands <- processInfo
         else
           stop("Process information type is not recognized")

    # We do need to change separator parameters
    alg_params <- unlist(strsplit(commands, ",")) # parse algorithm parameters
    tmp_parameters <- unlist(lapply(alg_params, function(x) {l <- unlist(strsplit(x, "="))})) # create a tmp vector of algorithm parameters names and values
    
    idx <- which(tmp_parameters == "name") # get name key idx
    alg_name <- tmp_parameters[idx+1] # get name value (idx + 1)
    alg <- Algorithm(serverURL, alg_name) # build Algorithm template object 
    
    tmp_parameters <- utils::tail(tmp_parameters, -2) # remove first two elements (name key and its value)
    
    if(length(tmp_parameters) != 0) #if any parameter
      check <- applyAlgorithm(alg, tmp_parameters) # apply tmp_parameters into the Algorithm template
    else 
      check <- TRUE
    
    return (check)

  }

)
