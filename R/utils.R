#' Send a HTTP request
#'
#' @description This function submits a HTTP request to a URL
#' 
#' @param HTTP_request a HTTP request
sendRequest <- function(HTTP_request) {
  
  tryCatch(HTTP_response <- RCurl::getURL(HTTP_request), # check if URL exists and perform the request
           error = function(e) { # error method
                e$message <- paste("HTTP request failed. The URL server may be incorrect or the service may be temporarily unavailable."); 
                stop(e); # stop with that message when no URL exists
          })
  
  return(HTTP_response) # return response
  
}

#' Parse a JSON response
#'
#' @description This function parses a HTTP reponse in case is JSON
#' 
#' @param HTTP_response a HTTP request
parseJSON <- function(HTTP_response) {
  
  if (jsonlite::validate(HTTP_response)) { # if HTTP response contains a valid json
    json_response <- jsonlite::fromJSON(HTTP_response) # parse json
    if("exception" %in% names(json_response)) stop(json_response) # in the case server has an error json response stop
    return(json_response) # otherwise return json response
  }
  else
    stop(HTTP_response) # stop with http response (not a valid json)
  
}