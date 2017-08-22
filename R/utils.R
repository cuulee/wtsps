#' Send a HTTP request
#'
#' @description This function submits a HTTP request to a URL
#' 
#' @param http_request a HTTP request
#' @export
sendHttpRequest <- function(http_request) {
  
  # check if URL exists and perform the request
  tryCatch(http_response <- RCurl::getURL(http_request), 
           error = function(e) { # error method
                e$message <- paste("HTTP request failed. The URL server may be incorrect or the service may be temporarily unavailable."); 
                stop(e); # stop with that message when no URL exists
          })
  
  return(http_response) # return http response
  
}

#' Parse a JSON response
#'
#' @description This function parses a JSON reponse
#' 
#' @param json_response a server response
#' @export
parseJsonResponse <- function(json_response) {
  
  json_list <- jsonlite::fromJSON(json_response) # parse json
  
  # in the case server has an error json response stop
  if("exception" %in% names(json_list)) 
    stop(json_response) 
    
  return(json_list) # otherwise return json as a list
  
}

#' Parse a response
#'
#' @description This function parses a reponse
#' 
#' @param response a server response
#' @export
parseResponse <- function(response) {
  
  # if HTTP response contains a valid json
  if (jsonlite::validate(response)) { 
    json_response <- parseJsonResponse(response)
  }
  else
    stop(response) # stop with a not valid json response
  
  return(json_response)
  
}


#' Send a HTTP request
#'
#' @description This function submits a HTTP request to a URL
#' 
#' @param request a HTTP request
#' @export
sendRequest <- function(request) {
  
  # check if URL exists and perform the request
  if (RCurl::url.exists(request))
    response <- sendHttpRequest(request) # submit HTTP request
  else
    response <- readLines(gsub("\\?|\"","", paste(request, ".json", sep = ""))) # read direclty a json file
    
  return(response)
  
}