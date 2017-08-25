#' @include utils.R
#' 
#' Class Process.
#'
#' Class \code{Process} declaration helps to define a Web Time Series Processing Service.
#' 
#'@section Slots :
#' \describe{
#' \item{\code{uuid}:}{Attribute of class \code{"character"}, an identifier of a Process.}
#' \item{\code{status}:}{Attribute of class \code{"character"}, a status of a Process.}
#' \item{\code{command}:}{Attribute of class \code{"character"}, a command of a Process.}
#' }
#' 
#' @name Process-class
#' @rdname Process-class
#' @exportClass Process
setClass(
  
  # Set the name for the class
  Class = "Process",
  
  # Define the slots
  slots = c(
    uuid = "numeric",
    status = "character",
    command = "character"
  )
  
)

# Constructor method of Process Class.
setMethod(
  
  # initialize function
  f = "initialize",
  
  # method signature
  signature = "Process",
  
  # function definition
  definition = function(.Object, serverInfo = "ANY", processInfo = "ANY", processStatus = "character") {
    
    # if wtsps information is missing
    if (missing(serverInfo))
      stop("Missing WTSPS information: Process cannot be created")
    else
      if (class(serverInfo) == "WTSPS")
        serverURL <- serverInfo@serverURL
      else
        serverURL <- serverInfo
      
    # if process information is missing
    if (missing(processInfo))
      stop("Missing Process information: either an id process or a command to execute")
    else if (class(processInfo) == "numeric") {  # Process identifier
            if (missing(processStatus))
              stop("Missing Process Status")
            else
                if (processStatus == "Cancelled") # cancel_process if status is equal to Cancelled
                  request <- paste(serverURL, "cancel_process?UUID=", processInfo, sep="")
                else # otherwise 
                  request <- paste(serverURL, "status?UUID=", processInfo, sep="")    
         }
         else if(class(processInfo) == "character") { # Process command
                check <- parametrizeAlgorithm(serverURL, processInfo) # check algorithm parameters
                if (!check)
                  stop("Algorithm does not match with its parameters")
                else
                  request <-paste(serverURL, "run_process?", processInfo, sep="")
         }
      else
        stop("Process information is not recognized")
      
    # submit HTTP request and get JSON response
    responseJSON <- parseResponse(sendRequest(request))
    
    # assign attribute values (status) to the Process object
    .Object@uuid <- responseJSON$uuid
    .Object@status <- responseJSON$status
    .Object@command <- responseJSON$command
    
    methods::validObject(.Object)
    
    return(.Object)
    
  }
  
)